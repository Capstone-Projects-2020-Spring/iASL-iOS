# LoginVC

This view controller is for the login screen that a user will see when they first open the app.
The user should be able to enter their name, email, and password if they have not registered before or
just their email and password if they are a returning user.

``` swift
class LoginVC: UIViewController, UITextFieldDelegate
```

## Inheritance

`UITextFieldDelegate`, `UIViewController`

## Properties

### `isRegisterButton`

boolean that determines if we are on the login screen or the register screen

``` swift
var isRegisterButton: Bool
```

### `isFirstOpen`

``` swift
var isFirstOpen
```

### `collectionUser`

``` swift
let collectionUser: String
```

### `welcomeScreenConfig`

``` swift
var welcomeScreenConfig
```

### `usersStringConstant`

first function that is called

``` swift
let usersStringConstant: String
```

### `keychain`

``` swift
let keychain
```

### `inputsContainerViewHeightAnchor`

creates a reference to the input container height anchor to be altered later

``` swift
var inputsContainerViewHeightAnchor: NSLayoutConstraint?
```

### `nameTextFieldHeightAnchor`

creates a reference to the name text field

``` swift
var nameTextFieldHeightAnchor: NSLayoutConstraint?
```

### `emailTextFieldHeightAnchor`

creates a reference to the email text field

``` swift
var emailTextFieldHeightAnchor: NSLayoutConstraint?
```

### `passwordTextFieldHeightAnchor`

creates a reference to the password text field

``` swift
var passwordTextFieldHeightAnchor: NSLayoutConstraint?
```

### `skipButton`

``` swift
let skipButton: UIButton
```

### `keychainToggle`

``` swift
let keychainToggle: UISwitch
```

### `keychainToggleLabel`

``` swift
var keychainToggleLabel: UILabel
```

### `cameraContainerView`

container for where I'd like the camera to go

``` swift
let cameraContainerView: UIView
```

### `nameTextField`

the textfield where the user can enter their name when they are registering

``` swift
let nameTextField: UITextField
```

### `emailTextField`

the textfield where the user can enter their email when they are registering

``` swift
let emailTextField: UITextField
```

### `passwordTextField`

the textfield where the user can enter their password when they are registering

``` swift
let passwordTextField: UITextField
```

### `inputContainerView`

container that holds the three textviews

``` swift
let inputContainerView: UIView
```

### `nameSeparatorView`

creates the orange lines between the name and the email

``` swift
let nameSeparatorView: UIView
```

### `emailSeparatorView`

creates the orange line between the email and the password

``` swift
let emailSeparatorView: UIView
```

### `logoView`

a logo for the login screen

``` swift
let logoView: UIImageView
```

### `toggleRegisterLoginButton`

the button that changes the view from register mode to login mode

``` swift
let toggleRegisterLoginButton: UIButton
```

### `infoSubmitButton`

when this button is pressed, the information entered will be sent to firebase

``` swift
let infoSubmitButton: UIButton
```

## Methods

### `showWelcomeScreen()`

``` swift
@objc func showWelcomeScreen()
```

### `viewDidAppear(_:)`

``` swift
override func viewDidAppear(_ animated: Bool)
```

### `welcomeScreenSetup()`

``` swift
fileprivate func welcomeScreenSetup()
```

### `switchChanged()`

``` swift
@objc func switchChanged()
```

### `viewDidLoad()`

first function that is called

``` swift
override func viewDidLoad()
```

### `handleLeaveLogin()`

called when this view controller needs to disappear and the main view controller needs to load

``` swift
func handleLeaveLogin()
```

### `handleSkipButton()`

handles what happens with the skip button is pressed

``` swift
@objc func handleSkipButton()
```

### `hideKeyboard()`

This gets called when the register or login button is pressed

``` swift
func hideKeyboard()
```

### `hideKeyboardOnTap()`

when the user taps anywhere else on the screen, it hides the keyboard

``` swift
@objc func hideKeyboardOnTap()
```

### `keyboardWillChange(notification:)`

``` swift
@objc func keyboardWillChange(notification: Notification)
```

### `toggleRegisterLoginButtonPressed()`

handles the toggle button

``` swift
@objc func toggleRegisterLoginButtonPressed()
```

### `infoSubmitButtonPressed()`

When this is pressed, the info should be sent to Firebase and the keyboard should disappear, and the view should disappear

``` swift
@objc func infoSubmitButtonPressed()
```

### `handleRegister()`

handles what happens when the user decides to register an account

``` swift
func handleRegister()
```

### `handleSaveKeychain(email:password:)`

handles the saving of the user's email and password into keychain

``` swift
func handleSaveKeychain(email: String, password: String)
```

### `handleLogin()`

handles what happens when the user logins in with an existing account

``` swift
func handleLogin()
```

### `setupInputContainerView()`

sets up the constraints for the input container

``` swift
func setupInputContainerView()
```

### `setupNameTextFieldConstraints()`

sets up the constraints of the name text field

``` swift
func setupNameTextFieldConstraints()
```

### `setupEmailTextFieldConstraints()`

sets up the constraints of the email text field

``` swift
func setupEmailTextFieldConstraints()
```

### `setupPasswordTextFieldConstraints()`

sets up the constraints of the password text field

``` swift
func setupPasswordTextFieldConstraints()
```

### `setupNameSeparatorViewConstraints()`

sets up the constraints of the top orange separator

``` swift
func setupNameSeparatorViewConstraints()
```

### `setupEmailSeparatorViewConstraints()`

sets up the constraints of the bottom orange separator

``` swift
func setupEmailSeparatorViewConstraints()
```

### `setupCameraView()`

sets up the constraints of the camera view

``` swift
func setupCameraView()
```

### `setupKeychainToggleLabel()`

``` swift
func setupKeychainToggleLabel()
```

### `setupKeychainToggle()`

``` swift
func setupKeychainToggle()
```

### `setupSkipButton()`

``` swift
func setupSkipButton()
```

### `setupToggleRegisterLoginButton()`

sets up the constraints of the toggle button

``` swift
func setupToggleRegisterLoginButton()
```

### `setupInfoSubmitButton()`

sets up the constraints of the submit button

``` swift
func setupInfoSubmitButton()
```
