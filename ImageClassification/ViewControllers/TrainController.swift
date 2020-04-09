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
class TrainController: UIViewController,YouTubePlayerDelegate {
var videoPlayer: YouTubePlayerView?
	let previewView = PreviewView()
	// MARK: Controllers that manage functionality
	   // Handles all the camera related functionality
	   private lazy var cameraCapture = CameraFeedManager(previewView: previewView)
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
		view.addSubview(videoPlayerContainer)
		videoPlayerContainer.addSubview(videoPlayer!)
		videoPlayerContainer.backgroundColor = .green
		videoPlayer?.backgroundColor = .red
		videoPlayer?.delegate = self
		videoPlayerContainer.translatesAutoresizingMaskIntoConstraints = false
		videoPlayerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
		videoPlayerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
		videoPlayerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
		videoPlayerContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
		
		videoPlayer?.translatesAutoresizingMaskIntoConstraints = false
		videoPlayer?.topAnchor.constraint(equalTo: videoPlayerContainer.topAnchor).isActive = true
		videoPlayer?.leadingAnchor.constraint(equalTo: videoPlayerContainer.leadingAnchor).isActive = true
		videoPlayer?.trailingAnchor.constraint(equalTo: videoPlayerContainer.trailingAnchor).isActive = true
//		videoPlayer?.heightAnchor.constraint(equalToConstant: 200).isActive = true
		videoPlayer?.bottomAnchor.constraint(equalTo: videoPlayerContainer.bottomAnchor).isActive = true
		guard let url: URL = URL(string: "https://www.youtube.com/watch?v=1N4DfFk01h8") else {return}
//		if let playinline = videoPlayer?.playerVars["playsinline"] as? Int {
////			return playinline == 1
//			if playinline == 1{
//
//			}else{
//				videoPlayer?.playerVars["playsinline"] = 1 as AnyObject
//			}
//		}
		videoPlayer?.playerVars = ["playsinline": 1 as AnyObject]
		videoPlayer?.loadVideoURL(url)
		
		previewViewSetup()
		cameraCapture.delegate = self
		
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
		previewView.topAnchor.constraint(equalTo: videoPlayer!.bottomAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
