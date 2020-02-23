//
//  ASLActivity.swift
//  ImageClassification
//
//  Created by Ian Applebaum on 2/21/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
//MARK: Main Activity View Controller
class ASLActivity: UIViewController{
	private var cameraView:UIView?
	private var extraActivity:UIView?
	private var isNoteTaking:Bool?
	private var isMessageActivity:Bool?
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}
//MARK: NoteTakingView
class NoteTaking: UIView {
	let textView = UITextView()
	var textSaved : String?
	private func setUserText(){
		
	}
	private func saveToNotes(){
		
	}
	private func deleteNote(note: String){
		
	}
	private func retrieveNotes()->String{
		return ""
	}
}
class Messageing: UIViewController{
	private var messageView: UIView?
	private var finalSender: User?
	private var recipient: User?
	
	public func checkConnection()-> Bool{
		return false
	}
	public func getText()-> String{
		return ""
	}
	public func setRecipient(user: User){
		
	}
	public func sendMessage(msg: String)-> Bool{
		return false
	}
}
class Conversation: UIViewController{
	private var tts: TextToSpeech
	private var textSoFar: String
	private var recognizerIntent: Intent
	private var conversationView: View
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	private func initTTS(){
		
	}
	private func updateText(newText: String){
			
	}
	public func play(){
				
	}
	public func pause(){
					
	}
	public func stop(){
						
	}
	///Add target connect to button
	public func onListen(){
							
	}
	private func promptSpeechInput(){
								
	}


}
class CameraConnection:UIViewController{
	private final var LOGGER: Logger?
	private final var imageListener: OnImageAvailableListener?
	private final var inputSize: Size?
	private final var layout: int?
	private final var cameraConnectionCallback: ConnectionCallBack?
	private var sensorOrientation: int?
	private var cameraDevice: CameraDevice?
	private var backgroundThread: HandlerThread?
	private var backgroundHandler: Handler?
	private final var stateCallback: StateCallback?
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	fileprivate func chooseOptimalSize(choises:[CGSize], width: Int, height: Int)->CGSize{
		return CGSize.zero
	}
	public func setUpCamera(cameraId: String){
		
	}
	public func setCamera(cameraId: String){
			
	}
	public func openCamera(width: Int, height: Int){
				
	}
	public func closeCamera(){
					
	}
	private func startBackgroundThread(){
						
	}
	private func stopBackgroundThread(){
							
	}
}

class CameraActivity: CameraConnection {
	private final var LOGGER: logger?
	private final var PERMISSIONS_REQUEST: Int?
	private final var PERMISSION_CAMERA: String?
	private var handler: Handler?
	private var model: Model?
	private var device: Device?
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	fileprivate func getRgbBytes() -> [Int]{
		return [Int.zero]
	}
	public func onImageAvailable(reader: ImageReader){
		
	}
	public func synchronizedOnStart(){
		
	}
	public func synchronizedOnResume(){
		
	}
	public func synchronizedOnPause(){
		
	}
	public func synchronizedOnStop(){
		
	}
	public func synchronizedOnDestroy(){
		
	}
	private func chooseCamera(){
		
	}
	fileprivate func getScreenOr(){
	}
	fileprivate func getModel() {
	}
	private func setModel(model:Model){
	}
	fileprivate func getDevice(){
	}
	private func setDevice(device:Device){
		
	}
	fileprivate func processImage(){
	}


}

