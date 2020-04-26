//
//  LoginVC.swift
//  ImageClassification
//
//  Created by Liam Miller on 3/14/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

// FIXME: Add a thing where the view will disappear when the user presses "login" or "register"

// FIXME: Add a skip button so user's don't have to login if they don't want. Not needed for the main part of the app

// FIXME: What happens when a user forgets their password?

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import KeychainSwift
import AppleWelcomeScreen
/**
 This view controller is for the login screen that a user will see when they first open the app. The user should be able to enter their name, email, and password if they have not registered before or just their email and password if they are a returning user.
 */
class LoginVC: UIViewController, UITextFieldDelegate {

    // MARK: VARIABLES

    ///Boolean that determines if we are on the login screen or the register screen
    var isRegisterButton: Bool = true

    ///Constant that holds the "users" node for Firebase
    let usersStringConstant: String = "users"
	
    /// The configuration struct that configures the appearence of our welcome screen.
	var welcomeScreenConfig = AWSConfigOptions()

    /// presents the welcome screen using our custom configuration.
	@objc func showWelcomeScreen() {
		  let vc = AWSViewController()
		vc.configuration = self.welcomeScreenConfig
		  self.present(vc, animated: true)
	}
	/// Notifies the view controller that its view was added to a view hierarchy.
	/// - Parameter animated: If `true`, the view was added to the window using an animation.
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
        
        #if DEBUG
            return
        #endif
        
		if defaults.bool(forKey: "WelcomeVersion1.0.0") {
					   return
				   } else {
					   self.showWelcomeScreen()

			}
	}
    
    /// Configures the welcome screen. Setting it's style, and content in `welcomeScreenConfig`.
	fileprivate func welcomeScreenSetup() {
		welcomeScreenConfig.appName = "iASL (Beta)"
		welcomeScreenConfig.appDescription = "iASL is a Temple University capstone project designed to transcribe American Sign Language to text using your iPhone's camera. We sincerely thank you for taking the time to test our app before public release. We are testing the following features."
		welcomeScreenConfig.tintColor = .systemPink

		var item1 = AWSItem()
		if #available(iOS 13.0, *) {

			item1.image = UIImage(systemName: "hand.draw.fill")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
		} else {
			// Fallback on earlier versions
		}
		item1.title = "ASL Finger Spelling Recognition"
		item1.description = "Spell words using American Sign Language letters."

		var item2 = AWSItem()
		if #available(iOS 13.0, *) {
			item2.image = UIImage(systemName: "bubble.left.and.bubble.right.fill")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
		} else {
			// Fallback on earlier versions
		}
		item2.title = "Messaging"
		item2.description = "Our chat feature lets you send messages to other iASL users using Sign Language instead of a keyboard."

		var item3 = AWSItem()
		if #available(iOS 13.0, *) {
			item3.image = UIImage(systemName: "camera.on.rectangle.fill")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
		} else {
			// Fallback on earlier versions
		}
		item3.title = "We need your help."
		item3.description = "We're working on supporting full American Sign Language words, and we need your help to train iASL. With your permission, we ask you to tap the train iASL button where you will be prompted with a video of the sign that you will perform and send to our server."

		welcomeScreenConfig.items = [item1, item2, item3]

		welcomeScreenConfig.continueButtonAction = {
			defaults.set(true, forKey: "WelcomeVersion1.0.0")
			self.dismiss(animated: true)
		}
	}



    ///Keychain that holds the users password and email so that users do not have to sign in every time they open the app
    let keychain = KeychainSwift(keyPrefix: "iasl_")

    //MARK: REFERENCE VARIABLES
    
    ///Creates a reference to the input container height anchor to be altered later
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    ///Creates a reference to the name text field
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    ///Creates a reference to the email text field
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    ///Creates a reference to the password text field
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?

    ///Button for skipping the login screen
    let skipButton: UIButton = {
        let skip = UIButton(type: .system)
        skip.backgroundColor = .clear
        skip.setTitle("Skip for now", for: .normal)
        skip.setTitleColor(.white, for: .normal)
        skip.translatesAutoresizingMaskIntoConstraints = false
        skip.layer.cornerRadius = 5
        skip.layer.masksToBounds = true
        skip.addTarget(self, action: #selector(handleSkipButton), for: .touchUpInside)
        return skip
    }()

    ///Toggle for turning on and off the keychain feature
    let keychainToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.tintColor = .black
        toggle.onTintColor = .black
        return toggle
    }()

    ///The label that informs the user about the toggle feature
    lazy var keychainToggleLabel: UILabel = {
        let toggle = UILabel()
        toggle.backgroundColor = .clear
        toggle.text = "Save user?"
        toggle.textColor = .white
        toggle.font = .boldSystemFont(ofSize: 16)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()

    //need a camera container view
    ///Container that is holding the logo
    let logoContainerView: UIView = {
        let cameraView = UIView()
        cameraView.backgroundColor = .clear
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        cameraView.layer.cornerRadius = 5
        cameraView.layer.masksToBounds = true
        return cameraView
    }()
    
    ///The textfield where the user can enter their name when they are registering
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.textColor = .black
        textField.tintColor = .systemPink
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    ///The textfield where the user can enter their email when they are registering
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.textColor = .black
        textField.tintColor = .systemPink
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    ///The textfield where the user can enter their password when they are registering
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.textColor = .black
        textField.tintColor = .systemPink
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true //makes the little dots appear for password
        return textField
    }()

    ///Container that holds the three textviews
    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    ///creates the orange lines between the name and the email
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    ///Creates the orange line between the email and the password
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    ///A logo for the login screen
    let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "yo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    ///The button that changes the view from register mode to login mode
    let toggleRegisterLoginButton: UIButton = {
        let toggleButton = UIButton(type: .system)
        toggleButton.backgroundColor = .white
        toggleButton.setTitle("Already a user? Login", for: .normal)
        toggleButton.setTitleColor(.systemPink, for: .normal)
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.layer.cornerRadius = 5
        toggleButton.layer.masksToBounds = true
        toggleButton.addTarget(self, action: #selector(toggleRegisterLoginButtonPressed), for: .touchUpInside)
        return toggleButton
    }()

    ///When this button is pressed, the information entered will be sent to firebase
    let infoSubmitButton: UIButton = {
        let submitButton = UIButton(type: .system)
        submitButton.backgroundColor = UIColor.white
        submitButton.setTitle("Register", for: .normal)
        submitButton.setTitleColor(.systemPink, for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.layer.cornerRadius = 5
        submitButton.layer.masksToBounds = true
        submitButton.addTarget(self, action: #selector(infoSubmitButtonPressed), for: .touchUpInside)
        return submitButton
    }()

    ///Called when the toggle switch is toggled
    @objc func switchChanged() {
        print("switched")
    }

    // MARK: VIEW DID LOAD

    ///View did load function that calls the important setup functions
    override func viewDidLoad() {
        let view = UIView()
        view.backgroundColor = .systemPink

        let removeKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))

        //set the delegates for the keyboards
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self

        //Listening for keyboard hide/show events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        //true means register button is sent
        //false means login button is sent
        isRegisterButton = true

        view.addGestureRecognizer(removeKeyboardTap)

        self.view = view

        //this has to be BELOW THE self.view = view line of code
        setupInputContainerView()
        setupCameraView()
        setupKeychainToggleLabel()
        setupKeychainToggle()
        setupInfoSubmitButton()
        setupToggleRegisterLoginButton()
        setupSkipButton()

		welcomeScreenSetup()
        //print(toggleRegisterLoginButton.frame.origin.y)
    }

    // MARK: LOGIC-Y STUFF

    ///Called when this view controller needs to disappear and the main view controller needs to load
    func handleLeaveLogin() {
        let mainVC = ViewController()
        mainVC.modalTransitionStyle = .crossDissolve
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
    }

    ///Handles what happens with the skip button is pressed
    @objc func handleSkipButton() {
        //print("handle skip button pressed")
        handleLeaveLogin()
    }

    ///This gets called when the register or login button is pressed
    func hideKeyboard() {
        //gives up the first repsonder if any of these are active
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    ///When the user taps anywhere else on the screen, it hides the keyboard
    @objc func hideKeyboardOnTap() {
        //removes the keyboard
        view.endEditing(true)
    }

    ///This is for removing the keyboard notifications
    deinit {
        //Stop listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

	/// Called when the keyboard is about to change
	/// - Parameter notification: The system notification that calls for the Keyboard.
    @objc func keyboardWillChange(notification: Notification) {
        print("Keyboard will show \(notification.name.rawValue)")

        //get the size of the keyboard
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            print("Could not find the keyboard height")
            return
        }

        //gets the rects for the button and the top of the keyboard for math
        let bottomLeftOfButton = toggleRegisterLoginButton.frame.origin.y + toggleRegisterLoginButton.frame.height
        let topOfKeyboard = view.frame.height - keyboardRect.height

        //print("Top of Keyboard: \(topOfKeyboard)")
        //print("Bottom of button: \(bottomLeftOfButton)")

        //difference between height of keyboard and bottom of button. view will change by this much
        let difference = topOfKeyboard - bottomLeftOfButton

        //print("Difference: \(difference)")

        //For shifting the screen up and down
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            //move the screen up by the same size as the keyboard
            view.frame.origin.y = difference - 10
        } else {
            view.frame.origin.y = 0
        }

    }

    ///Handles the toggle button for the register and login button
    @objc func toggleRegisterLoginButtonPressed() {
        print("we pressed the toggle button")

        //hide the keyboard
        hideKeyboard()

        toggleRegisterLoginButton.setTitle(isRegisterButton ? "Not a user? Register" : "Already a user? Login", for: .normal)
        infoSubmitButton.setTitle(isRegisterButton ? "Login" : "Register", for: .normal)

        //what happens when this is pressed?
        //both button titles need to change and input container needs to shrink, removing the name field

        inputsContainerViewHeightAnchor?.constant = isRegisterButton ? 100 : 150

        //for removing the name text field
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: isRegisterButton ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true

        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: isRegisterButton ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true

        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: isRegisterButton ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true

        isRegisterButton = !isRegisterButton

    }

    ///When this is pressed, the info should be sent to Firebase and the keyboard should disappear, and the view should disappear
    @objc func infoSubmitButtonPressed() {
        //for now, just make the keyboard disappear
        print("info submit button pressed")

            //hide the keyboard
            hideKeyboard()

            //if isRegister = true, then its on the register screen
            //else if isRegister = false, then its on the login screen
            if isRegisterButton {
                if nameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" {
                    handleRegister()
                } else {
                    if nameTextField.text == "" {
                        //nameTextField.backgroundColor = UIColor.red.withAlphaComponent(0.2)
                        view.shake(viewToShake: nameTextField)
                    }
                    if emailTextField.text == "" {
                        view.shake(viewToShake: emailTextField)
                    }
                    if passwordTextField.text == "" {
                        view.shake(viewToShake: passwordTextField)
                    }
                }

            } else {

                if emailTextField.text != "" && passwordTextField.text != "" {
                    handleLogin()

                } else {
                    if emailTextField.text == "" {
                        view.shake(viewToShake: emailTextField)
                    }
                    if passwordTextField.text == "" {
                        view.shake(viewToShake: passwordTextField)
                    }
                }

            }

    }

    ///Handles what happens when the user decides to register an account
    func handleRegister() {

        //get email and password and name
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Did not get email and password")
            return
        }

        //code for creating a user in auth
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if err != nil {
                print(err!)
                let alert = UIAlertController(title: "Alert", message: err?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }

            //check to see if uid exists
            guard let uid = result?.user.uid else {
                return
            }

            //let db = Firestore.firestore()
            var ref: DatabaseReference!
            ref = Database.database().reference()
            //gets the user child in the database with the UID as the child name
            let userReference = ref.child(self.usersStringConstant).child(uid)
            //successfully added user to authentication
            //var ref: DocumentReference? = nil

            //adds the name and the email
            let dataToAdd: [String: Any] = ["name": name, "email": email, "id": uid]

            //for realtime storing
            userReference.updateChildValues(dataToAdd) { (error, _) in
                if error != nil {
                    print(error!)

                    return
                } else {
                    //you've successfully added user to realtime database
                    print("saved user successfully into REALTIME")

                    //if the user wants to save their email and password into keychain
                    self.handleSaveKeychain(email: email, password: password)
                    self.handleLeaveLogin()
                }
            }
        }
    }

	/**
	Handles the saving of the user's email and password into keychain
	- Parameters:
	- email: The email to be saved by the keychain
	- password: The password to be saved by the keychain
	*/
    func handleSaveKeychain(email: String, password: String) {
        if self.keychainToggle.isOn {
            if self.keychain.set(email, forKey: "email", withAccess: .accessibleWhenUnlocked) {
                print("keychained email")
            }
            if self.keychain.set(password, forKey: "password", withAccess: .accessibleWhenUnlocked) {
                print("keychained password")
            }
        }
    }
    
    func getCurrentUser() -> String {
        var variable = "failed"
        guard let uid = Auth.auth().currentUser?.uid else {
            print("could not get UID")
            return ""
        }

        let ref = Database.database().reference().child("users").child(uid)
        ref.observe(.value) { (snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {
                let name = dictionary["name"] as? String
                print(name)
                variable = name!
            }
        }
        return variable
    }

    ///Handles what happens when the user logins in with an existing account
    func handleLogin() {
        //get email and password and name
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Did not get email and password")

            //FIXME: Add some kind of error handling for when a password/email is not entered or if the account can't be found

            return
        }
        
        print("We are in the login")
        print(email)
        print(password)

        //sign in with username and password
        Auth.auth().signIn(withEmail: email, password: password) { (_, err) in
            print(err)
            if err != nil {
                print(err!)
                let alert = UIAlertController(title: "Alert", message: err?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            } else {
                //add email and password into keychain if they want
                self.handleSaveKeychain(email: email, password: password)
                //successfully signed in
                print("you signed in successfully")
                self.handleLeaveLogin()
            }
        }
    }

}

// MARK: SETUPS
///Extension of the LoginVC that holds most of the setup functions for the whole view controller
extension LoginVC {

    ///Sets up the constraints for the input container
    func setupInputContainerView() {
        view.addSubview(inputContainerView)
        //next do the anchors for the container views
        //centerx, centery, width, and height
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        //this looks different because we need to change it later with a toggle
        inputsContainerViewHeightAnchor = inputContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true

        //add the subviews to the input container
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSeparatorView)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(emailSeparatorView)
        inputContainerView.addSubview(passwordTextField)

        //this is for the text fields
        setupNameTextFieldConstraints()
        setupEmailTextFieldConstraints()
        setupPasswordTextFieldConstraints()

        //this is for the separators
        setupNameSeparatorViewConstraints()
        setupEmailSeparatorViewConstraints()
    }

    ///Sets up the constraints of the name text field
    func setupNameTextFieldConstraints() {
        nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true

        //get a reference for the toggle later
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
    }

    ///Sets up the constraints of the email text field
    func setupEmailTextFieldConstraints() {
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true

        //need a reference
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
    }

    ///Sets up the constraints of the password text field
    func setupPasswordTextFieldConstraints() {
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true

        //need a reference
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true

        //make sure this works
        if #available(iOS 12, *) {
            passwordTextField.textContentType = .oneTimeCode
        } else {
            emailTextField.textContentType = .init(rawValue: "")
            passwordTextField.textContentType = .init(rawValue: "")
        }
    }

    ///Sets up the constraints of the top orange separator
    func setupNameSeparatorViewConstraints() {
        nameSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    ///Sets up the constraints of the bottom orange separator
    func setupEmailSeparatorViewConstraints() {
        emailSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    ///Sets up the constraints of the Logo view
    func setupCameraView() {
        view.addSubview(logoContainerView)
        view.addSubview(logoView)

        //sets up the container for the background, helps with visualizing
        logoContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoContainerView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -12).isActive = true
        logoContainerView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, multiplier: 0.5).isActive = true
        logoContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        //adds the logo to the view
        logoView.centerXAnchor.constraint(equalTo: logoContainerView.centerXAnchor).isActive = true
        logoView.bottomAnchor.constraint(equalTo: logoContainerView.bottomAnchor).isActive = true
        logoView.widthAnchor.constraint(equalTo: logoContainerView.widthAnchor).isActive = true
        logoView.heightAnchor.constraint(equalTo: logoContainerView.heightAnchor).isActive = true
    }

    ///Sets up the keychain toggle label and defines its constraints
    func setupKeychainToggleLabel() {
        view.addSubview(keychainToggleLabel)

        keychainToggleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        keychainToggleLabel.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        keychainToggleLabel.widthAnchor.constraint(lessThanOrEqualTo: inputContainerView.widthAnchor, multiplier: 0.5).isActive = true
        keychainToggleLabel.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        keychainToggleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    ///Sets up the keychain toggle and defines its constraints
    func setupKeychainToggle() {
        view.addSubview(keychainToggle)

        keychainToggle.topAnchor.constraint(equalTo: keychainToggleLabel.topAnchor).isActive = true
        keychainToggle.leftAnchor.constraint(equalTo: keychainToggleLabel.rightAnchor, constant: 12).isActive = true
    }

    ///Sets up the skip button and defines its constraints
    func setupSkipButton() {
        view.addSubview(skipButton)

        skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        skipButton.topAnchor.constraint(equalTo: toggleRegisterLoginButton.bottomAnchor, constant: 12).isActive = true
        skipButton.widthAnchor.constraint(equalTo: toggleRegisterLoginButton.widthAnchor).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    ///Sets up the constraints of the toggle button
    func setupToggleRegisterLoginButton() {
        view.addSubview(toggleRegisterLoginButton)

        toggleRegisterLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toggleRegisterLoginButton.topAnchor.constraint(equalTo: infoSubmitButton.bottomAnchor, constant: 12).isActive = true
        toggleRegisterLoginButton.widthAnchor.constraint(equalTo: infoSubmitButton.widthAnchor).isActive = true
        toggleRegisterLoginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    ///Sets up the constraints of the submit button
    func setupInfoSubmitButton() {
        view.addSubview(infoSubmitButton)

        infoSubmitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoSubmitButton.topAnchor.constraint(equalTo: keychainToggleLabel.bottomAnchor, constant: 12).isActive = true
        infoSubmitButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        infoSubmitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
