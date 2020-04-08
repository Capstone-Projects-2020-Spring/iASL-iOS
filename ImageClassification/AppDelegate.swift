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
//import SwiftMonkeyPaws
let navigationController = UINavigationController()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        requestTranscribePermissions()
        
        FirebaseApp.configure()
        
        //initializes the firestore firebase
        //let db = Firestore.firestore()
        
        //FIXME: May need to reavaluate this solution
        //changes the root view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ChatVC()
        window?.makeKeyAndVisible()
        
        //just for editing the chatVC
        //    window = UIWindow(frame: UIScreen.main.bounds)
        //    window?.rootViewController = ViewController()
        //    window?.makeKeyAndVisible()
        
        //just for editing the chatVC
        //    window = UIWindow(frame: UIScreen.main.bounds)
        //    window?.rootViewController = RemoteConversationVC()
        //    window?.makeKeyAndVisible()
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        self.window?.makeKeyAndVisible()
        //	if CommandLine.arguments.contains("--MonkeyPaws") {
        //		paws = MonkeyPaws(view: window!)
        //	}
        return true
        
    }
    
    func application(application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
        let windows = UIApplication.shared.windows
        
        for window in windows {
            window.removeConstraints(window.constraints)
        }
    }
    
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
