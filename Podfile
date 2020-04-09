# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'ImageClassification' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ImageClassification
   pod 'TensorFlowLiteSwift'
   pod 'Firebase'
   pod 'Firebase/Database'
    # Add the Firebase pod for Google Analytics
    pod 'Firebase/Analytics'
    pod 'Firebase/Auth'
    pod 'Firebase/Core'
    pod 'Firebase/Firestore'
    pod 'FirebaseFirestoreSwift'
pod 'SnapKit', '~> 5.0.0'


    # Add the pod for Firebase Cloud Messaging
    pod 'Firebase/Messaging'
    pod 'SwiftLint'
    pod 'SwiftMonkeyPaws', '~> 2.1.0'
    pod 'AppleWelcomeScreen'
    pod 'YouTubePlayer', :git => 'https://github.com/weakfl/Swift-YouTube-Player.git', :branch => 'use-wkwebview' # replace with original pod after the pull request got merged
    # pod 'SwiftVideoRecorder',:git => 'https://github.com/ApplebaumIan/swift-video-recorder.git', :branch => 'master'
    pod "SwiftyCam"
    pod 'KeychainSwift'

end
target 'iASLUITests' do
  pod 'SwiftMonkey', '~> 2.1.0'
end
#   Disable Code Coverage for Pods projects
post_install do |installer_representation|
   installer_representation.pods_project.targets.each do |target|
       target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
       end
   end
end
