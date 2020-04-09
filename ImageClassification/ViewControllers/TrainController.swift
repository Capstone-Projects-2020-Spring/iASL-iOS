//
//  TrainController.swift
//  ImageClassification
//
//  Created by Ian Applebaum on 4/8/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import YouTubePlayer
struct Train {
	var signs: [String: String]?
}

class TrainController: UIViewController,YouTubePlayerDelegate {
	var signVideos: Train? = Train()
	let nextButton = UIButton()
	let block = UIView()
	var recordButton = RecordButton(frame: .zero)
	var videoPlayer: YouTubePlayerView?
	let previewView = PreviewView()
	// MARK: Controllers that manage functionality
	   // Handles all the camera related functionality
//	private lazy var cameraCapture = CameraFeedVideoManager(previewView: self.previewView)
	fileprivate func nextButtonSetup() {
		view.addSubview(nextButton)
		nextButton.translatesAutoresizingMaskIntoConstraints = false
		nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		nextButton.widthAnchor.constraint(equalToConstant: 115).isActive = true
		nextButton.bottomAnchor.constraint(equalTo: block.bottomAnchor,constant: -30).isActive = true
		nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor ,constant: -10).isActive = true
		nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
		nextButton.setTitle("Next Video", for: .normal)
		if #available(iOS 13.0, *) {
			nextButton.setImage(UIImage(systemName: "chevron.left")?.withTintColor(.white,renderingMode: .alwaysOriginal), for: .normal)
		} else {
			// Fallback on earlier versions
		}
		let pink: UIColor = .systemPink
		nextButton.backgroundColor = pink.withAlphaComponent(0.75)
		nextButton.layer.cornerRadius = 10
		nextButton.semanticContentAttribute = UIApplication.shared
		.userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
		
	}
	

	fileprivate func blockVideoViewSetup() {
		view.addSubview(block)
		block.translatesAutoresizingMaskIntoConstraints = false
		block.topAnchor.constraint(equalTo: previewView.bottomAnchor, constant: 0).isActive = true
		block.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		block.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		//		block.heightAnchor.constraint(equalToConstant: 200).isActive = true
		block.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		block.backgroundColor = .clear
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
//	var countdownLabel : CountdownLabel?
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
		videoPlayer?.playerVars = ["playsinline": 1 as AnyObject, "controls": 0 as AnyObject]
		blockVideoViewSetup()
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
//		countDownlabelSetup()
		nextButtonSetup()
	
//		cameraCapture.delegate = self
		
    }
//	func countDownlabelSetup()  {
//			countdownLabel = CountdownLabel(frame: .zero, minutes: 5)// you can use NSDate as well
//
//				countdownLabel?.animationType = .Evaporate
//				self.view.addSubview(countdownLabel!)
//				countdownLabel?.translatesAutoresizingMaskIntoConstraints = false
//				countdownLabel!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//				countdownLabel!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//				countdownLabel?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//				countdownLabel?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//				countdownLabel!.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
//				countdownLabel!.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//				countdownLabel?.textAlignment = .center
//				countdownLabel?.isHidden = true
//		//		countdownLabel?.font.
//	}
	override func viewDidAppear(_ animated: Bool) {
		  let recordButtonSide = self.view.bounds.size.height/10
			  recordButton = RecordButton(frame: CGRect(x: self.view.bounds.width/2-recordButtonSide/2,
															y: self.view.bounds.height-recordButtonSide,
															width: recordButtonSide,
															height: recordButtonSide))
		recordButton.delegate = self
		view.addSubview(recordButton)
	}
	@objc func nextButtonPressed(){
		let video = signVideos?.signs?.popFirst()
		print(video?.key)
		guard let url : URL = URL(string: video!.value) else{return}
		videoPlayer?.loadVideoURL(url)
	}
	override func viewWillAppear(_ animated: Bool) {
//		#if !targetEnvironment(simulator)
//		cameraCapture.checkCameraConfigurationAndStartSession()
//		#endif
		}
	#if !targetEnvironment(simulator)
	   override func viewWillDisappear(_ animated: Bool) {
		   super.viewWillDisappear(animated)
//		   cameraCapture.stopSession()
	   }
	   #endif
	func playerReady(_ videoPlayer: YouTubePlayerView) {
		videoPlayer.play()
	}
	func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
		if playerState == .Ended {
			videoPlayer.seekTo(0, seekAhead: false)
			
			videoPlayer.play()
		}
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

	

extension TrainController: RecordButtonDelegate{
	func tapButton(isRecording: Bool) {
		print("record")
		
		
			if isRecording == true{
//				if countdownLabel?.timeRemaining == 0{
//					countdownLabel?.setCountDownTime(minutes: 5)
//				}
//				countdownLabel?.start()
//				self.countdownLabel!.start()
				// from current Date, after 30 minutes.
				
				//			countDownImage.isHidden = true
				
				print("start recording")
			}else{
				print("stopped")
			}
		
		
	}
	
	
}
