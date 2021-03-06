// Copyright 2019 The TensorFlow Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import CoreImage
import TensorFlowLite
import UIKit
import Accelerate
/// This class handles all data preprocessing and makes calls to run inference on a given frame
/// by invoking the `Interpreter`. It then formats the inferences obtained and returns the top N
/// results for a successful inference.
class VideoModelDataHandler{
	
	// MARK: - Internal Properties
	///The number of results to get from the model.
	let resultCount = 3
	// MARK: - Model Parameters
	/// How many samples propagate through the network at once
	let batchSize = 1
	/// How many channels in the image (3 for RGB or 4 if it’s RGBA, but it shouldn’t be RGBA in our case.)
	let inputChannels = 3
	/// the width the input is scaled to
	let inputWidth = 50
	/// The height the input is scaled to
	let inputHeight = 50
	
	// MARK: - Private Properties
	/// Handles all functions necessary for communication of the video classifier with Views.
	private var videoModelDelegate: VideoModelDelegate?
	/// Information about the alpha component in RGBA data.
	private let alphaComponent = (baseOffset: 4, moduloRemainder: 3)
	/// Array of base64 encoded string video frames. We need 40 of these to send to the server for classification.
	private var frames: Array<String> = []
	var videoCount = 0
	// MARK: - Initialization
	
	/// Initializes communication with the server side video classifier.
	/// - Parameter delegate: View or ViewController that conforms to the `VideoModelDelegate` protocol. Handles all functions necessary for communication of the video classifier with Views.
	init?(delegate: VideoModelDelegate) {
		self.videoModelDelegate = delegate
	}
	
	// MARK: - Internal Methods
	/// Performs image preprocessing, invokes the `Interpreter`, and processes the inference results.
	func runModel(onFrame pixelBuffer: CVPixelBuffer) {
		let sourcePixelFormat = CVPixelBufferGetPixelFormatType(pixelBuffer)
		assert(sourcePixelFormat == kCVPixelFormatType_32ARGB ||
			sourcePixelFormat == kCVPixelFormatType_32BGRA ||
			sourcePixelFormat == kCVPixelFormatType_32RGBA)
		
		let imageChannels = 4
		assert(imageChannels >= inputChannels)
		
//		let scaledSize = CGSize(width: inputWidth, height: inputHeight)
		guard let thumbnailPixelBuffer = pixelBuffer.videoCenter() else {
			return
		}
//		let imageDebug = CIImage(cvPixelBuffer: thumbnailPixelBuffer)//This variable is here for debugging purposes to see what the ML Model sees.
		
		let interval: TimeInterval
		do {
			// Remove the alpha component from the image buffer to get the RGB data.
			collectRGBFrames(
				thumbnailPixelBuffer,
				byteCount: batchSize * inputWidth * inputHeight * inputChannels
			)
			
			// Run inference by invoking the `Interpreter`.
			let startDate = Date()
			interval = Date().timeIntervalSince(startDate) * 1000
			
		}
		
	}
	
	// MARK: - Private Methods
	
	/// Function that handles data returned by the model. Makes the decision whether the confidence score associated to the classification is worth using. If it's confident it calls the `videoModelDelegate` to insert the text.
	/// - Parameter data: data response from server.
	private func interpretServerPrediction(data: Data){
		do {
			// make sure this JSON is in the format we expect
			if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
				// try to read out a string array
				if let scores: [String:Double] = json["scores"] as? [String:Double] {
					print(scores)
					let greatestScore = scores.max { predictionA, predictionB in predictionA.value < predictionB.value }
					print(greatestScore!.key)
					// Check confidence
					if greatestScore!.key != "nothing" && greatestScore!.value >= 0.95 {
						//Send data to insert
						videoModelDelegate?.insertText(greatestScore!.key)
					}
					
				}
			}
		} catch let error as NSError {
			print("Failed to load: \(error.localizedDescription)")
		}
	}
	
	/// Send frames collected to server for classification.
	/// - Parameters:
	///   - frame: All collected frames as base64 encoded strings.
	///   - url: url of server to send to.
	fileprivate func sendFramesToServer(_ frames: String, _ url: URL) {
		// url of server
		//Tarek
		//	let url = URL(string: "http://192.168.1.39:8080/predict_img")!
		//			let url = URL(string: "https://iasl.azurewebsites.net:8080/predict")!
		//request
		let jsonEncoder = JSONEncoder()
		let paramaters: [String:Any] = ["vid_stuff":frames]
		
		var request = URLRequest(url: url)
		request.httpBody = paramaters.percentEncoded()
		request.httpMethod = "POST"
		
		//SEND
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data,
				let response = response as? HTTPURLResponse,
				error == nil else { // check for fundamental networking error
					print("error", error ?? "Unknown error")
					if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
						//not connected
						DispatchQueue.main.async {
							print("NO INTERNET")
						}
					}else{
						DispatchQueue.main.async {
							print( "Error \(error.debugDescription.description)")
						}
					}
					return
			}
			
			guard (200 ... 299) ~= response.statusCode else {// check for http errors
				print("statusCode should be 2xx, but is \(response.statusCode)")
				print("response = \(response)")
				DispatchQueue.main.async {
					print("Message was not sent. Status code is \(response.statusCode).")
				}
				return
			}
			// you can print the response string if you'd like for debugging purposes
			//			let responseString = String(data: data, encoding: .utf8)
			DispatchQueue.main.async {
				self.interpretServerPrediction(data: data)
			}
			
		}
		
		task.resume()
	}
	
	/// Collects the RGB data representation of the given image buffer with the specified `byteCount`.
	///Each frame is collected as a base64 encoded string and stored in `frames:Array<String>`.
	///
	/// - Parameters
	///   - buffer: The pixel buffer to convert to RGB data.
	///   - byteCount: The expected byte count for the RGB data calculated using the values that the
	///       model was trained on: `batchSize * imageWidth * imageHeight * componentsCount`.
	///   - isModelQuantized: Whether the model is quantized (i.e. fixed point values rather than
	///       floating point values).
	private func collectRGBFrames(
		_ buffer: CVPixelBuffer,
		byteCount: Int
	) -> Void {
		CVPixelBufferLockBaseAddress(buffer, .readOnly)
		defer {
			CVPixelBufferUnlockBaseAddress(buffer, .readOnly)
		}
		guard let sourceData = CVPixelBufferGetBaseAddress(buffer) else {
			return
		}
		
		let width = CVPixelBufferGetWidth(buffer)
		let height = CVPixelBufferGetHeight(buffer)
		let sourceBytesPerRow = CVPixelBufferGetBytesPerRow(buffer)
		let destinationChannelCount = 3
		let destinationBytesPerRow = destinationChannelCount * width
		
		var sourceBuffer = vImage_Buffer(data: sourceData,
										 height: vImagePixelCount(height),
										 width: vImagePixelCount(width),
										 rowBytes: sourceBytesPerRow)
		
		guard let destinationData = malloc(height * destinationBytesPerRow) else {
			print("Error: out of memory")
			return
		}
		
		defer {
			free(destinationData)
		}
		
		var destinationBuffer = vImage_Buffer(data: destinationData,
											  height: vImagePixelCount(height),
											  width: vImagePixelCount(width),
											  rowBytes: destinationBytesPerRow)
		
		let pixelBufferFormat = CVPixelBufferGetPixelFormatType(buffer)
		
		switch pixelBufferFormat {
		case kCVPixelFormatType_32BGRA:
			vImageConvert_BGRA8888toRGB888(&sourceBuffer, &destinationBuffer, UInt32(kvImageNoFlags))
		case kCVPixelFormatType_32ARGB:
			vImageConvert_ARGB8888toRGB888(&sourceBuffer, &destinationBuffer, UInt32(kvImageNoFlags))
		case kCVPixelFormatType_32RGBA:
			vImageConvert_RGBA8888toRGB888(&sourceBuffer, &destinationBuffer, UInt32(kvImageNoFlags))
		default:
			// Unknown pixel format.
			return
		}
		
		let byteData = Data(bytes: destinationBuffer.data, count: destinationBuffer.rowBytes * height)
		
		//data to send
		let base64String = byteData.base64EncodedString()
		if frames.count == 40 {
			// make all of the frames collected as base64 strings one big base64 encoded string.
			let framesJoined = frames.joined()
			//			let url = URL(string: "http://192.168.73.155:8080/predict")!
			let url = URL(string: "http://34.70.195.11:8080/predict")!
			sendFramesToServer(framesJoined, url)
			//		}
			// remove all of the frames after sending!
			frames.removeAll()
		}
		// collect frames
		frames.append(base64String)
		//	print("CURRENT NUMBER OF FRAMES\(frames.count)")
		
	}
}


// MARK: - Extensions


extension Dictionary {
	func percentEncoded() -> Data? {
		return map { key, value in
			let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
			let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
			return escapedKey + "=" + escapedValue
		}
		.joined(separator: "&")
		.data(using: .utf8)
	}
	
}
extension CharacterSet {
	static let urlQueryValueAllowed: CharacterSet = {
		let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
		let subDelimitersToEncode = "!$&'()*+,;="
		
		var allowed = CharacterSet.urlQueryAllowed
		allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
		return allowed
	}()
}

/// Delegate to handle all communication between Views and the VideoModel
protocol VideoModelDelegate {
	/// Delegate function to handle text returned by the video classifier for use such as insertion.
	/// - Parameter text: The text returned by the video classifier.
	/**
	Example usage:
	`outputTextView` being a `UITextView` where the text returned will be shown.
	~~~
	func insertText(_ text: String) {
	self.outputTextView.text.append("\(text) ")
	}
	~~~
	*/
	func insertText(_ text: String)
}
