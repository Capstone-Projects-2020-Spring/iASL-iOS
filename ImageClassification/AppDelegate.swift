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

import UIKit
import Speech
import Firebase
import FirebaseMessaging
import FirebaseFirestore
import KeychainSwift
//import SwiftMonkeyPaws

/// Global variable to access user defaults.
let defaults = UserDefaults.standard
var ranBefore:Bool?

@UIApplicationMain
/** Manages your app’s shared behaviors. The app delegate is effectively the root object of your app, and it works in conjunction with UIApplication to manage some interactions with the system. Like the UIApplication object, UIKit creates your app delegate object early in your app’s launch cycle so it is always present.
*/
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
	///The backdrop for your app’s user interface and the object that dispatches events to your views.
  var window: UIWindow?
	
	/// Tells the delegate that the launch process is almost done and the app is almost ready to run.
	/// - Parameters:
	///   - application: The singleton app object.
	///   - launchOptions: A dictionary indicating the reason the app was launched (if any). The contents of this dictionary may be empty in situations where the user launched the app directly. For information about the possible keys in this dictionary and how to handle them, see Launch Options Keys.
	/// - Returns: `false` if the app cannot handle the URL resource or continue a user activity, otherwise return true. The return value is ignored if the app is launched as a result of a remote notification.
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    requestTranscribePermissions()

    FirebaseApp.configure()
    
    let keychain = KeychainSwift(keyPrefix: "iasl_")
    
    print("called app delegate")
    


    //just for editing the chatVC
//    window = UIWindow(frame: UIScreen.main.bounds)
//    window?.rootViewController = NotesVC()
//    window?.makeKeyAndVisible()

    application.registerForRemoteNotifications()

    Messaging.messaging().delegate = self

    
//	if CommandLine.arguments.contains("--MonkeyPaws") {
//		paws = MonkeyPaws(view: window!)
//	}
    
    
    
    #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            // Code only executes when tests are running
            print("TESTS ARE RUNNINGGGGGGGGGGGGGGG")
            let email = "Test1@gmail.com"
            let password = "password"

            //sign in with username and password
            Auth.auth().signIn(withEmail: email, password: password) { (_, err) in
                if err != nil {
                    print(err!)
                    return
                }

                //successfully signed in
                print("you signed in successfully")
            }

//            window = UIWindow(frame: UIScreen.main.bounds)
//            window?.rootViewController = ViewController()
//            window?.makeKeyAndVisible()
            return true
        }

    #endif
    
    //need a local scope so code can continue afterwards
    
    //if we can get email and password from keychain, skip sign in screen
    if let email = keychain.get("email"), let password = keychain.get("password") {
        print("Did not get email and password")
        
        //sign in with username and password
        Auth.auth().signIn(withEmail: email, password: password) { (_, err) in
            if err != nil {
                print(err!)
                return
            }
            
            //successfully signed in
            print("you signed in successfully")
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
    } else {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginVC()
        window?.makeKeyAndVisible()
    }
    
    self.window?.makeKeyAndVisible()
    
    return true

  }
	
	/// Asks the user to allow your app to perform speech recognition.
    func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    print("Good to go!")
                } else {
                    print("Transcription permission was declined.")
                }
            }
        }
    }

}
