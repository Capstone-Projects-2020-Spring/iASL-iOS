//
//  TrainController.swift
//  ImageClassification
//
//  Created by Ian Applebaum on 4/8/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import YouTubePlayer
import WebKit

struct Train {
	var signs: [String: String]?
}

class TrainController: UIViewController,YouTubePlayerDelegate {
	var signVideos: Train? = Train()
	let nextButton = UIButton()
var videoPlayer: YouTubePlayerView?
	let previewView = PreviewView()
	// MARK: Controllers that manage functionality
	   // Handles all the camera related functionality
	   private lazy var cameraCapture = CameraFeedManager(previewView: previewView)
	fileprivate func nextButtonSetup() {
		view.addSubview(nextButton)
		nextButton.translatesAutoresizingMaskIntoConstraints = false
		nextButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
		nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
		nextButton.bottomAnchor.constraint(equalTo: previewView.bottomAnchor,constant: -20).isActive = true
		nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor ,constant: -10).isActive = true
		nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
		nextButton.setTitle("Next Video 􀆊", for: .normal)
	}
	
	fileprivate func videoPlayerContainerSetup(_ videoPlayerContainer: UIView) {
		view.addSubview(videoPlayerContainer)
		videoPlayerContainer.addSubview(videoPlayer!)
		videoPlayerContainer.backgroundColor = .green
		videoPlayer?.backgroundColor = .red
		videoPlayer?.delegate = self
		videoPlayerContainer.translatesAutoresizingMaskIntoConstraints = false
//		videoPlayerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
		videoPlayerContainer.topAnchor.constraint(equalTo: previewView.bottomAnchor, constant: 0).isActive = true
		videoPlayerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		videoPlayerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//		videoPlayerContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
		videoPlayerContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		if #available(iOS 13.0, *) {
			view.backgroundColor = .systemBackground
		} else {
			// Fallback on earlier versions
			view.backgroundColor = .white
		}
        // Do any additional setup after loading the view.
		let videoPlayerContainer = UIView(frame: .zero)
		videoPlayer = YouTubePlayerView(frame: CGRect.zero)
		previewViewSetup()
		videoPlayerContainerSetup(videoPlayerContainer)
		
		videoPlayer?.translatesAutoresizingMaskIntoConstraints = false
		videoPlayer?.topAnchor.constraint(equalTo: videoPlayerContainer.topAnchor).isActive = true
		videoPlayer?.leadingAnchor.constraint(equalTo: videoPlayerContainer.leadingAnchor).isActive = true
		videoPlayer?.trailingAnchor.constraint(equalTo: videoPlayerContainer.trailingAnchor).isActive = true
		videoPlayer?.bottomAnchor.constraint(equalTo: videoPlayerContainer.bottomAnchor).isActive = true
		videoPlayer?.playerVars = ["playsinline": 1 as AnyObject]
		//get videos
	if let path = Bundle.main.path(forResource: "signs", ofType: "json") {
			do {
				  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
				  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
				if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let signs = jsonResult["signs"] as? [String:String] {
							// do stuff
					signVideos?.signs = signs
				  }
			  } catch {
				   // handle error
			  }
		}
		//load first video
		let video = signVideos?.signs?.popFirst()
		print(video?.key)
		guard let url : URL = URL(string: video!.value) else{return}
		videoPlayer?.loadVideoURL(url)
		
		nextButtonSetup()
		cameraCapture.delegate = self
		
    }
	@objc func nextButtonPressed(){
		let video = signVideos?.signs?.popFirst()
		print(video?.key)
		guard let url : URL = URL(string: video!.value) else{return}
		videoPlayer?.loadVideoURL(url)
	}
	override func viewWillAppear(_ animated: Bool) {
		#if !targetEnvironment(simulator)
		cameraCapture.checkCameraConfigurationAndStartSession()
		#endif
		}
	#if !targetEnvironment(simulator)
	   override func viewWillDisappear(_ animated: Bool) {
		   super.viewWillDisappear(animated)
		   cameraCapture.stopSession()
	   }
	   #endif
	func playerReady(_ videoPlayer: YouTubePlayerView) {
		videoPlayer.play()
	}
	func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
		if playerState == .Ended {
			videoPlayer.seekTo(0, seekAhead: false)
			sleep(1)
			videoPlayer.play()
		}
	}

  

}
extension TrainController: CameraFeedManagerDelegate{
	func didOutput(pixelBuffer: CVPixelBuffer) {
		//
	}
	
	func presentCameraPermissionsDeniedAlert() {
		//
	}
	
	func presentVideoConfigurationErrorAlert() {
		//
	}
	
	func sessionRunTimeErrorOccured() {
		//
	}
	
	func sessionWasInterrupted(canResumeManually resumeManually: Bool) {
		//
	}
	
	func sessionInterruptionEnded() {
		//
	}
	
	func previewViewSetup() {
        view.addSubview(previewView)
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		previewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		let height = view.bounds.height
		previewView.heightAnchor.constraint(equalToConstant: height/2).isActive = true
//		previewView.bottomAnchor.constraint(equalTo: videoPlayer!.topAnchor).isActive = true
    }
}
