![Integration Testing](https://github.com/Capstone-Projects-2020-Spring/iASL-iOS/workflows/Integration%20Testing/badge.svg)
![Documentation](https://capstone-projects-2020-spring.github.io/iASL-iOS/badge.svg)
# iASL iOS Application

## Overview
This repository is for the iASL Android application. The app will use the iOS device's front-facing camera to record the user signing in ASL. It will then attempt to convert the ASL to text by using machine learning. The application will also support a speech-to-text feature to allow Deaf individuals to read what the other person is saying aloud.

Users will be able to save the ASL to text as a note. iASL also features an instant messaging feature. Users can sign in front of the camera, or speak into the microphone, and have the resulting text be sent to someone else.


iASL uses [TensorFlow Lite](https://tensorflow.org/lite)
on iOS. <!--It uses [Image classification](https://www.tensorflow.org/lite/models/image_classification/overview)
to continuously classify whatever it sees from the device's back camera, using
a quantized MobileNet model.  
-->
Go checkout [TensorFlow Lite Example App](https://github.com/tensorflow/examples/tree/master/lite/examples/image_classification/ios).
The application must be run on device not simulator.

<!-- TODO(b/124116863): Add app screenshot. -->

### Model
The repository containing the machine learning model and backend for converting ASL to text can be found at: https://github.com/Capstone-Projects-2020-Spring/iASL-Backend


### iOS app details

The app is written entirely in Swift and uses the TensorFlow Lite
[Swift library](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/lite/experimental/swift)
for performing image classification.

## Requirements

*   Device with iOS 12.0 or above

*   Xcode 10.0 or above

*   Valid Apple Developer ID

*   Xcode command-line tools (run `xcode-select --install`)

*   [CocoaPods](https://cocoapods.org/) (run `bash sudo gem install cocoapods`)


Note: The demo app requires a camera and must be executed on a real iOS device.
You can build it and run with the iPhone Simulator, but the app will raise a
`Camera not found` exception.

## Build and run

1.  Clone this GitHub repository to your workstation. `bash git clone
    https://github.com/Capstone-Projects-2020-Spring/iASL-iOS.git`

2.  Install the pod to generate the workspace file: `bash cd
    examples/lite/examples/image_classification/ios pod install`

Note: If you have installed this pod before and that command doesn't work, try
`pod update`.

At the end of this step you should have a directory called
`ImageClassification.xcworkspace`.

1.  Open the project in Xcode with the following command: `bash open
    ImageClassification.xcworkspace`

This launches Xcode and opens the `ImageClassification` project.

1.  Select the `ImageClassification` project in the left hand navigation to open
    the project configuration. In the **Signing** section of the **General**
    tab, select your development team from the dropdown.

2.  In order to build the project, you must modify the **Bundle Identifier** in
    the **Identity** section so that it is unique across all Xcode projects. To
    create a unique identifier, try adding your initials and a number to the end
    of the string.

3.  With an iOS device connected, build and run the app in Xcode.

You'll have to grant permissions for the app to use the device's camera. Point
the camera at various objects and enjoy seeing how the model classifies things!

## Model references
_Do not delete the empty references_ to the .tflite and .txt files after you
clone the repo and open the project. These references will be fulfilled once the
model and label files are downloaded when the application is built and run for
the first time. If you delete the references to them, you can still find that
the .tflite and .txt files are downloaded to the Model folder, the next time you
build the application. You will have to add the references to these files in the
bundle separately in that case.

## Code reference
For documentation of iASL code, refer to [iASL Documentation](https://capstone-projects-2020-spring.github.io/iASL-iOS/).
