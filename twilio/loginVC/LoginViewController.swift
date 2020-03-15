import UIKit

/**
 Handles the login functionality for users
 */
class LoginViewController: UIViewController {
    ///button to be pressed when user wants to login
    @IBOutlet weak var loginButton: UIButton!
    ///textfield that holds the username
    @IBOutlet weak var usernameTextField: UITextField!
    ///shows that a task is in progress
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Injectable Properties

    ///class for handling the alert dialogue
    var alertDialogControllerClass = AlertDialogController.self
    ///sets the messaging manager to self
    var messagingClientClass = MessagingManager.self

    // MARK: - Initialization

    ///sets the text field form handler
    var textFieldFormHandler: TextFieldFormHandler!

    ///called when view controller loads
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTextFields()
    }

    ///initializes text fields and delegates
    func initializeTextFields() {
        let textFields: [UITextField] = [usernameTextField]
        textFieldFormHandler = TextFieldFormHandler(withTextFields: textFields, topContainer: view)
        textFieldFormHandler.delegate = self
    }

    ///resets the first responder after the sign up mode has changed, for keyboard
    func resetFirstResponderOnSignUpModeChange() {
        self.view.layoutSubviews()

        if let index = self.textFieldFormHandler.firstResponderIndex {
            if index > 1 {
                textFieldFormHandler.setTextFieldAtIndexAsFirstResponder(index: 1)
            } else {
                textFieldFormHandler.resetScroll()
            }
        }
    }

    ///cleans up the textfield handler when the view controller is about to close
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textFieldFormHandler.cleanUp()
    }

    ///when a memory warning is called
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    ///function for login button, calls the login user function to log a user in
    @IBAction func loginButtonTouched(_ sender: UIButton) {
        loginUser()
    }

    // MARK: - Login

    ///logs the user in with their username
    func loginUser() {
        if validUserData() {
            view.isUserInteractionEnabled = false
            activityIndicator.startAnimating()

            let messagingManager = MessagingClientClass.sharedManager()
            if let username = usernameTextField.text {
                messagingManager.loginWithUsername(username: username, completion: handleResponse)
            }
        }
    }

    /**
     Checks to see if the username entered was empty.
     
     - Returns: a boolean that determines if username field was empty or not
     */
    func validUserData() -> Bool {
        if let usernameEmpty = usernameTextField.text?.isEmpty, !usernameEmpty {
            return true
        }
        showError(message: "All fields are required")
        return false
    }

    /**
     Shows an error message as an alert box if something went wrong.
     
     - Parameter message: describes what the error was
     */
    func showError(message: String) {
        alertDialogControllerClass.showAlertWithMessage(message: message, title: nil, presenter: self)
    }

    /**
     Manages the dispatch queue and activity indicator.
     
     - Parameter succeeded: boolean that determines if the response was successful or not
     - Parameter error: the actual error, if there is one
     */
    func handleResponse(succeeded: Bool, error: NSError?) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            if let error = error, !succeeded {
                self.showError(message: error.localizedDescription)
            }
            self.view.isUserInteractionEnabled = true
        }
    }

    // MARK: - Style

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//
//    override var shouldAutorotate: Bool {
//        return true
//    }

//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if (UI_USER_INTERFACE_IDIOM() == .pad) {
//            return .all
//        }
//        return .portrait
//    }

//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .portrait
//    }
}

// MARK: - TextFieldFormHandlerDelegate
extension LoginViewController: TextFieldFormHandlerDelegate {
    func textFieldFormHandlerDoneEnteringData(handler: TextFieldFormHandler) {
        loginUser()
    }
}
