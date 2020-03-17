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

let navigationController = UINavigationController()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    requestTranscribePermissions()
    
//    self.window = UIWindow(frame: UIScreen.main.bounds)
//
//    let navigationController = UINavigationController()
//    navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//    navigationController.navigationBar.shadowImage = UIImage()
//    navigationController.navigationBar.isTranslucent = true
//    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//    let mainViewController = storyBoard.instantiateViewController(withIdentifier: "main")
//    //navigationController.pushViewController(mainViewController, animated: true)
//    navigationController.isNavigationBarHidden = true
//    let mainView = //ViewController()//.instantiateViewController(storyboard)
//    navigationController.viewControllers = [mainViewController]
//    self.window!.rootViewController = navigationController
//    self.window?.makeKeyAndVisible()
    return true
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
