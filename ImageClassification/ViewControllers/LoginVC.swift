//
//  LoginVC.swift
//  ImageClassification
//
//  Created by Liam Miller on 3/14/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    var isRegisterButton: Bool = true
    
    override func viewDidLoad() {
        
        
        
        let view = UIView()
        view.backgroundColor = .systemPink
        
        isRegisterButton = true
        
        //view.addSubview(label)
        view.addSubview(inputContainerView)
        view.addSubview(infoSubmitButton)
        view.addSubview(cameraContainerView)
        view.addSubview(toggleRegisterLoginButton)
        
        self.view = view
        
        //this has to be BELOW THE self.view = view line of code
        setupInputContainerView()
        setupInfoSubmitButton()
        setupCameraView()
        setupToggleRegisterLoginButton()
    }
    
    //need to add some text fields inside the container view
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true //makes the little dots appear for password
        return tf
    }()
    
    
    //need an input container view
    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    
    func setupInputContainerView() {
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
    
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setupNameTextFieldConstraints() {
        nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        //get a reference for the toggle later
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
    }
    
    func setupEmailTextFieldConstraints() {
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        //need a reference
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
    }
    
    func setupPasswordTextFieldConstraints() {
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        //need a reference
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    func setupNameSeparatorViewConstraints() {
        nameSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupEmailSeparatorViewConstraints() {
        emailSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    //need a camera container view
    let cameraContainerView: UIView = {
        let cameraView = UIView()
        cameraView.backgroundColor = .white
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        cameraView.layer.cornerRadius = 5
        cameraView.layer.masksToBounds = true
        return cameraView
    }()
    
    func setupCameraView() {
        cameraContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cameraContainerView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -12).isActive = true
        cameraContainerView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, multiplier: 0.5).isActive = true
        cameraContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    //need a register/login button
    let toggleRegisterLoginButton: UIButton = {
        let toggleButton = UIButton(type: .system)
        toggleButton.backgroundColor = .white
        toggleButton.setTitle("Already a user? Login", for: .normal)
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.layer.cornerRadius = 5
        toggleButton.layer.masksToBounds = true
        toggleButton.addTarget(self, action: #selector(toggleRegisterLoginButtonPressed), for: .touchUpInside)
        return toggleButton
    }()
    
    @objc func toggleRegisterLoginButtonPressed() {
        print("we pressed the toggle button")
        
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
    
    func setupToggleRegisterLoginButton() {
        toggleRegisterLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toggleRegisterLoginButton.topAnchor.constraint(equalTo: infoSubmitButton.bottomAnchor, constant: 12).isActive = true
        toggleRegisterLoginButton.widthAnchor.constraint(equalTo: infoSubmitButton.widthAnchor).isActive = true
        toggleRegisterLoginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    //need a segmented control for switching between login and register
    //for this, also need to change the size of the input container view
    //maybe just use a button for this? Have a register button and then below that use a
    let infoSubmitButton: UIButton = {
        let regButton = UIButton(type: .system)
        regButton.backgroundColor = UIColor.white
        regButton.setTitle("Register", for: .normal)
        regButton.translatesAutoresizingMaskIntoConstraints = false
        regButton.layer.cornerRadius = 5
        regButton.layer.masksToBounds = true
        return regButton
    }()

    func setupInfoSubmitButton() {
        infoSubmitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoSubmitButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        infoSubmitButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        infoSubmitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
}
