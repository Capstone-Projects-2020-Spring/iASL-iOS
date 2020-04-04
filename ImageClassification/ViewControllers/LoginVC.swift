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

/**
 This view controller is for the login screen that a user will see when they first open the app.
 The user should be able to enter their name, email, and password if they have not registered before or
 just their email and password if they are a returning user.
 */
class LoginVC: UIViewController, UITextFieldDelegate {

    ///boolean that determines if we are on the login screen or the register screen
    var isRegisterButton: Bool = true

    let collectionUser: String = "users"
    
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

    ///first function that is called
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
        setupInfoSubmitButton()
        setupCameraView()
        setupToggleRegisterLoginButton()
        setupSkipButton()
        
        //print(toggleRegisterLoginButton.frame.origin.y)
    }
    
    ///called when this view controller needs to disappear and the main view controller needs to load
    func handleLeaveLogin() {
        let mainVC = ViewController()
        mainVC.modalTransitionStyle = .crossDissolve
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
    }
    
    ///handles what happens with the skip button is pressed
    @objc func handleSkipButton() {
        //print("handle skip button pressed")
        handleLeaveLogin()
    }
    
    func setupSkipButton() {
        view.addSubview(skipButton)

        
        skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        skipButton.topAnchor.constraint(equalTo: toggleRegisterLoginButton.bottomAnchor, constant: 12).isActive = true
        skipButton.widthAnchor.constraint(equalTo: toggleRegisterLoginButton.widthAnchor).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    ///This gets called when the register or login button is pressed
    func hideKeyboard() {
        //gives up the first repsonder if any of these are active
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    ///when the user taps anywhere else on the screen, it hides the keyboard
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

    //need to add some text fields inside the container view
	// FIXME: Liam you need to fix these linting issues
	// swiftlint:disable identifier_name
    ///the textfield where the user can enter their name when they are registering
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.attributedPlaceholder = NSAttributedString(string: tf.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.textColor = .black
        tf.tintColor = .systemPink
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    ///the textfield where the user can enter their email when they are registering
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address"
        tf.attributedPlaceholder = NSAttributedString(string: tf.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.textColor = .black
        tf.tintColor = .systemPink
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    ///the textfield where the user can enter their password when they are registering
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.attributedPlaceholder = NSAttributedString(string: tf.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        tf.textColor = .black
        tf.tintColor = .systemPink
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true //makes the little dots appear for password
        return tf
    }()
// swiftlint:enable identifier_name
    //need an input container view

    ///container that holds the three textviews
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

    ///creates the orange line between the email and the password
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    ///creates a reference to the input container height anchor to be altered later
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?

    ///sets up the constraints for the input container
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

    ///creates a reference to the name text field
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    ///creates a reference to the email text field
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    ///creates a reference to the password text field
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?

    ///sets up the constraints of the name text field
    func setupNameTextFieldConstraints() {
        nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true

        //get a reference for the toggle later
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
    }

    ///sets up the constraints of the email text field
    func setupEmailTextFieldConstraints() {
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true

        //need a reference
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
    }

    ///sets up the constraints of the password text field
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

    ///sets up the constraints of the top orange separator
    func setupNameSeparatorViewConstraints() {
        nameSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    ///sets up the constraints of the bottom orange separator
    func setupEmailSeparatorViewConstraints() {
        emailSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    //need a camera container view
    ///container for where I'd like the camera to go
    let cameraContainerView: UIView = {
        let cameraView = UIView()
        cameraView.backgroundColor = .clear
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        cameraView.layer.cornerRadius = 5
        cameraView.layer.masksToBounds = true
        return cameraView
    }()

    ///sets up the constraints of the camera view
    func setupCameraView() {
        view.addSubview(cameraContainerView)
        view.addSubview(logoView)
        
        //sets up the container for the background, helps with visualizing
        cameraContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cameraContainerView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -12).isActive = true
        cameraContainerView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, multiplier: 0.5).isActive = true
        cameraContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        //adds the logo to the view
        logoView.centerXAnchor.constraint(equalTo: cameraContainerView.centerXAnchor).isActive = true
        logoView.bottomAnchor.constraint(equalTo: cameraContainerView.bottomAnchor).isActive = true
        logoView.widthAnchor.constraint(equalTo: cameraContainerView.widthAnchor).isActive = true
        logoView.heightAnchor.constraint(equalTo: cameraContainerView.heightAnchor).isActive = true
    }
    
    ///a logo for the login screen
    let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "yo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    //need a register/login button
    ///the button that changes the view from register mode to login mode
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

    ///handles the toggle button
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

    ///sets up the constraints of the toggle button
    func setupToggleRegisterLoginButton() {
        view.addSubview(toggleRegisterLoginButton)
        
        toggleRegisterLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toggleRegisterLoginButton.topAnchor.constraint(equalTo: infoSubmitButton.bottomAnchor, constant: 12).isActive = true
        toggleRegisterLoginButton.widthAnchor.constraint(equalTo: infoSubmitButton.widthAnchor).isActive = true
        toggleRegisterLoginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    //need a segmented control for switching between login and register
    //for this, also need to change the size of the input container view
    //maybe just use a button for this? Have a register button and then below that use a
    ///when this button is pressed, the information entered will be sent to firebase
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

    ///When this is pressed, the info should be sent to Firebase and the keyboard should disappear, and the view should disappear
    @objc func infoSubmitButtonPressed() {
        //for now, just make the keyboard disappear
        print("info submit button pressed")

        //hide the keyboard
        hideKeyboard()

        //if isRegister = true, then its on the register screen
        //else if isRegister = false, then its on the login screen
        if isRegisterButton {

            handleRegister()

        } else {

            handleLogin()

        }

        //if login successful
        //then exit the view controller

        //This switches this view controller to the main view controller in Main.storyboard
        handleLeaveLogin()
        
    }

    //FIXME: move this
    let usersStringConstant: String = "users"

    ///handles what happens when the user decides to register an account
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
                }

                //you've successfully added user to realtime database
                print("saved user successfully into REALTIME")
            }

            //added user to database with UID as document
            // MARK: The code below is for using Firestore, not realtime
//            db.collection(self.collectionUser).document(uid).setData(dataToAdd, merge: true) { (error) in
//                if let error = error {
//                    print(error)
//                }
//
//                //added user to collection with UID
//                print("added user to database with UID")
//            }
        }
    }

    ///handles what happens when the user logins in with an existing account
    func handleLogin() {
        //get email and password and name
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Did not get email and password")
            
            //FIXME: Add some kind of error handling for when a password/email is not entered or if the account can't be found
            
            return
        }

        //sign in with username and password
        Auth.auth().signIn(withEmail: email, password: password) { (_, err) in
            if err != nil {
                print(err!)
                return
            }

            //successfully signed in
            print("you signed in successfully")

        }
    }

    ///sets up the constraints of the submit button
    func setupInfoSubmitButton() {
        view.addSubview(infoSubmitButton)
        
        infoSubmitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoSubmitButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        infoSubmitButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        infoSubmitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}

extension LoginVC {

    ///checks if we have a valid email address in the login
    func isValidEmail(email: String?) -> Bool {

        guard email != nil else { return false }

        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }

    ///checks if we have a valid password in the login
    func isValidPassword(testStr: String?) -> Bool {
        guard testStr != nil else { return false }

        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
}
