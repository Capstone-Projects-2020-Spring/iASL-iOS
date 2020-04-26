# LoginVC

This view controller is for the login screen that a user will see when they first open the app. The user should be able to enter their name, email, and password if they have not registered before or just their email and password if they are a returning user.

``` swift
class LoginVC: UIViewController, UITextFieldDelegate
```

## Inheritance

`UITextFieldDelegate`, `UIViewController`

## Properties

### `isRegisterButton`

Boolean that determines if we are on the login screen or the register screen

``` swift
var isRegisterButton: Bool
```

### `isFirstOpen`

``` swift
var isFirstOpen
```

### `usersStringConstant`

Constant that holds the "users" node for Firebase

``` swift
let usersStringConstant: String
```

### `welcomeScreenConfig`

``` swift
var welcomeScreenConfig
```

### `keychain`

Keychain that holds the users password and email so that users do not have to sign in every time they open the app

``` swift
let keychain
```

### `inputsContainerViewHeightAnchor`

Creates a reference to the input container height anchor to be altered later

``` swift
var inputsContainerViewHeightAnchor: NSLayoutConstraint?
```

### `nameTextFieldHeightAnchor`

Creates a reference to the name text field

``` swift
var nameTextFieldHeightAnchor: NSLayoutConstraint?
```

### `emailTextFieldHeightAnchor`

Creates a reference to the email text field

``` swift
var emailTextFieldHeightAnchor: NSLayoutConstraint?
```

### `passwordTextFieldHeightAnchor`

Creates a reference to the password text field

``` swift
var passwordTextFieldHeightAnchor: NSLayoutConstraint?
```

### `skipButton`

Button for skipping the login screen

``` swift
let skipButton: UIButton
```

### `keychainToggle`

Toggle for turning on and off the keychain feature

``` swift
let keychainToggle: UISwitch
```

### `keychainToggleLabel`

The label that informs the user about the toggle feature

``` swift
var keychainToggleLabel: UILabel
```

### `logoContainerView`

Container that is holding the logo

``` swift
let logoContainerView: UIView
```

### `nameTextField`

The textfield where the user can enter their name when they are registering

``` swift
let nameTextField: UITextField
```

### `emailTextField`

The textfield where the user can enter their email when they are registering

``` swift
let emailTextField: UITextField
```

### `passwordTextField`

The textfield where the user can enter their password when they are registering

``` swift
let passwordTextField: UITextField
```

### `inputContainerView`

Container that holds the three textviews

``` swift
let inputContainerView: UIView
```

### `nameSeparatorView`

creates the orange lines between the name and the email

``` swift
let nameSeparatorView: UIView
```

### `emailSeparatorView`

Creates the orange line between the email and the password

``` swift
let emailSeparatorView: UIView
```

### `logoView`

A logo for the login screen

``` swift
let logoView: UIImageView
```

### `toggleRegisterLoginButton`

The button that changes the view from register mode to login mode

``` swift
let toggleRegisterLoginButton: UIButton
```

### `infoSubmitButton`

When this button is pressed, the information entered will be sent to firebase

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

Called when the toggle switch is toggled

``` swift
@objc func switchChanged()
```

### `viewDidLoad()`

View did load function that calls the important setup functions

``` swift
override func viewDidLoad()
```

### `handleLeaveLogin()`

Called when this view controller needs to disappear and the main view controller needs to load

``` swift
func handleLeaveLogin()
```

### `handleSkipButton()`

Handles what happens with the skip button is pressed

``` swift
@objc func handleSkipButton()
```

### `hideKeyboard()`

This gets called when the register or login button is pressed

``` swift
func hideKeyboard()
```

### `hideKeyboardOnTap()`

When the user taps anywhere else on the screen, it hides the keyboard

``` swift
@objc func hideKeyboardOnTap()
```

### `keyboardWillChange(notification:)`

Called when the keyboard is about to change

``` swift
@objc func keyboardWillChange(notification: Notification)
```

### `toggleRegisterLoginButtonPressed()`

Handles the toggle button for the register and login button

``` swift
@objc func toggleRegisterLoginButtonPressed()
```

### `infoSubmitButtonPressed()`

When this is pressed, the info should be sent to Firebase and the keyboard should disappear, and the view should disappear

``` swift
@objc func infoSubmitButtonPressed()
```

### `handleRegister()`

Handles what happens when the user decides to register an account

``` swift
func handleRegister()
```

### `handleSaveKeychain(email:password:)`

Handles the saving of the user's email and password into keychain

``` swift
func handleSaveKeychain(email: String, password: String)
```

### `handleLogin()`

Handles what happens when the user logins in with an existing account

``` swift
func handleLogin()
```

### `setupInputContainerView()`

Sets up the constraints for the input container

``` swift
func setupInputContainerView()
```

### `setupNameTextFieldConstraints()`

Sets up the constraints of the name text field

``` swift
func setupNameTextFieldConstraints()
```

### `setupEmailTextFieldConstraints()`

Sets up the constraints of the email text field

``` swift
func setupEmailTextFieldConstraints()
```

### `setupPasswordTextFieldConstraints()`

Sets up the constraints of the password text field

``` swift
func setupPasswordTextFieldConstraints()
```

### `setupNameSeparatorViewConstraints()`

Sets up the constraints of the top orange separator

``` swift
func setupNameSeparatorViewConstraints()
```

### `setupEmailSeparatorViewConstraints()`

Sets up the constraints of the bottom orange separator

``` swift
func setupEmailSeparatorViewConstraints()
```

### `setupCameraView()`

Sets up the constraints of the Logo view

``` swift
func setupCameraView()
```

### `setupKeychainToggleLabel()`

Sets up the keychain toggle label and defines its constraints

``` swift
func setupKeychainToggleLabel()
```

### `setupKeychainToggle()`

Sets up the keychain toggle and defines its constraints

``` swift
func setupKeychainToggle()
```

### `setupSkipButton()`

Sets up the skip button and defines its constraints

``` swift
func setupSkipButton()
```

### `setupToggleRegisterLoginButton()`

Sets up the constraints of the toggle button

``` swift
func setupToggleRegisterLoginButton()
```

### `setupInfoSubmitButton()`

Sets up the constraints of the submit button

``` swift
func setupInfoSubmitButton()
```
