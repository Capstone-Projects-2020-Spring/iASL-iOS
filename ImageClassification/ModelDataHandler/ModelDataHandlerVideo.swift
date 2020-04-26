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

 
  /// Information about the alpha component in RGBA data.
  private let alphaComponent = (baseOffset: 4, moduloRemainder: 3)

	private var frames: Array<String> = []
  // MARK: - Initialization

  /// A failable initializer for `ModelDataHandler`. A new instance is created if the model and
  /// labels files are successfully loaded from the app's main bundle. Default `threadCount` is 1.
  init?() {

  }

  // MARK: - Internal Methods

  /// Performs image preprocessing, invokes the `Interpreter`, and processes the inference results.
  func runModel(onFrame pixelBuffer: CVPixelBuffer) -> Result? {

    let sourcePixelFormat = CVPixelBufferGetPixelFormatType(pixelBuffer)
    assert(sourcePixelFormat == kCVPixelFormatType_32ARGB ||
             sourcePixelFormat == kCVPixelFormatType_32BGRA ||
               sourcePixelFormat == kCVPixelFormatType_32RGBA)

    let imageChannels = 4
    assert(imageChannels >= inputChannels)

    // Crops the image to the biggest square in the center and scales it down to model dimensions.
    let scaledSize = CGSize(width: inputWidth, height: inputHeight)
    guard let thumbnailPixelBuffer = pixelBuffer.centerThumbnail(ofSize: scaledSize) else {
      return nil
    }

    let interval: TimeInterval
    do {
      

      // Remove the alpha component from the image buffer to get the RGB data.
      guard let rgbData = rgbDataFromBuffer(
        thumbnailPixelBuffer,
        byteCount: batchSize * inputWidth * inputHeight * inputChannels,
        isModelQuantized: false
      ) else {
        print("Failed to convert the image buffer to RGB data.")
        return nil
      }


      // Run inference by invoking the `Interpreter`.
      let startDate = Date()
      interval = Date().timeIntervalSince(startDate) * 1000


   
    // Return the inference time and inference results.
    return videoResult
	
	}
	}

  // MARK: - Private Methods

  
	var videoResult: Result?

	func interpretServerPrediction(data: Data){
		do {
			// make sure this JSON is in the format we expect
			if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
				// try to read out a string array
				if let scores: [String:Double] = json["scores"] as? [String:Double] {
					print(scores)
					let greatestScore = scores.max { a, b in a.value < b.value }
					print(greatestScore!.key)
					videoResult = Result(inferenceTime: 0, inferences: [Inference(confidence: Float(greatestScore!.value), label: greatestScore!.key)])
					
				}
			}
		} catch let error as NSError {
			print("Failed to load: \(error.localizedDescription)")
		}
	}
	
/// Returns the RGB data representation of the given image buffer with the specified `byteCount`.
  ///
  /// - Parameters
  ///   - buffer: The pixel buffer to convert to RGB data.
  ///   - byteCount: The expected byte count for the RGB data calculated using the values that the
  ///       model was trained on: `batchSize * imageWidth * imageHeight * componentsCount`.
  ///   - isModelQuantized: Whether the model is quantized (i.e. fixed point values rather than
  ///       floating point values).
  /// - Returns: The RGB data representation of the image buffer or `nil` if the buffer could not be
  ///     converted.
	private func rgbDataFromBuffer(
		_ buffer: CVPixelBuffer,
		byteCount: Int,
		isModelQuantized: Bool
	) -> Data? {
		CVPixelBufferLockBaseAddress(buffer, .readOnly)
		defer {
			CVPixelBufferUnlockBaseAddress(buffer, .readOnly)
		}
		guard let sourceData = CVPixelBufferGetBaseAddress(buffer) else {
			return nil
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
      return nil
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
        return nil
    }

    let byteData = Data(bytes: destinationBuffer.data, count: destinationBuffer.rowBytes * height)
    if isModelQuantized {
        return byteData
    }
	
    // Not quantized, convert to floats
    let bytes = [UInt8](unsafeData: byteData)!
	
	//data to send
	let base64String = byteData.base64EncodedString()
	if frames.count == 40 {
		//Ian
		
		let frame = frames.joined()
			let url = URL(string: "http://192.168.73.155:8080/predict")!
//			let url = URL(string: "https://iasl.azurewebsites.net:8080/predict")!
			//request
			let jsonEncoder = JSONEncoder()
			let paramaters: [String:Any] = ["vid_stuff":frame]

			var request = URLRequest(url: url)
		//	request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

		//		let send = try! JSONSerialization.data(withJSONObject: paramaters, options: .prettyPrinted)
			request.httpBody = paramaters.percentEncoded()
			request.httpMethod = "POST"
			//SEND
			let task = URLSession.shared.dataTask(with: request) { data, response, error in
						guard let data = data,
							let response = response as? HTTPURLResponse,
							error == nil else {                                              // check for fundamental networking error
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

						guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
							print("statusCode should be 2xx, but is \(response.statusCode)")
							print("response = \(response)")
							DispatchQueue.main.async {
								print("Message was not sent. Status code is \(response.statusCode).")
							}
							return
						}

						let responseString = String(data: data, encoding: .utf8)
//						print("responseString = \(responseString)")
						
						DispatchQueue.main.async {
//							oldServerResponeFunction()
							self.interpretServerPrediction(data: data)
						}
						
			//			defaultPresent(vc: )
					}

					task.resume()
		frames.removeAll()
	}
	frames.append(base64String)
	print("CURRENT NUMBER OF FRAMES\(frames.count)")
	// url of server
	//Tarek
	//	let url = URL(string: "http://192.168.1.39:8080/predict_img")!
	
	//		defaultPresent(vc: EmailCustomerListVC())
		
    var floats = [Float]()
    for index in 0..<bytes.count {
        floats.append((Float(bytes[index]) / 127.5) - 1.0)
    }
    return Data(copyingBufferOf: floats)
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
