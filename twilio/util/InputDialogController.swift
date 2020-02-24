import UIKit


/**
 Handles dialogue boxes and allows user input.
 */
class InputDialogController: NSObject {
    
    ///Type of alert action that allows user to save information from dialogue box.
    var saveAction: UIAlertAction!
    
    /**
     Shows the dialogue box with several parameters.
     
     - Parameter title: title of dialogue box
     - Parameter message: message of title box to be presented to user describing what is required of user
     - Parameter placeholder: placeholder text for text box
     - Parameter presenter: view controller that is presenting the dialogue box
     - Parameter handler: completion handler
     */
    class func showWithTitle(title: String, message: String,
                             placeholder: String, presenter: UIViewController, handler: @escaping (String) -> Void) {
        InputDialogController().showWithTitle(title: title, message: message,
                                              placeholder: placeholder, presenter: presenter, handler: handler)
    }
    
    /**
     Shows the dialogue box with several parameters and allows user to respond with input.
     
     - Parameter title: title of dialogue box
     - Parameter message: message of title box to be presented to user describing what is required of user
     - Parameter placeholder: placeholder text for text box
     - Parameter presenter: view controller that is presenting the dialogue box
     - Parameter handler: completion handler
     */
    func showWithTitle(title: String, message: String, placeholder: String,
                       presenter: UIViewController, handler: @escaping (String) -> Void) {
		// FIXME: Need implementation
		/*
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            self.removeTextFieldObserver()
        }
        
        saveAction = UIAlertAction(title: "Save", style: .default) { action in
            self.removeTextFieldObserver()
            let textFieldText = alert.textFields![0].text ?? String()
            handler(textFieldText)
        }
        
        saveAction.isEnabled = false
        
        alert.addTextField { textField in
            textField.placeholder = placeholder
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(InputDialogController.handleTextFieldTextDidChangeNotification(notification:)),
                                                   name: NSNotification.Name.UITextFieldTextDidChange,
                                                   object: nil)
        }
        
        alert.addAction(defaultAction)
        alert.addAction(saveAction)
        presenter.present(alert, animated: true, completion: nil)
*/
}
    
    /**
     Handler for text field being changeed by user input.
     
     - Parameter notification: an NSNotification to be evaluated and changed for the save action
     */
    func handleTextFieldTextDidChangeNotification(notification: NSNotification) {
        let textField = notification.object as? UITextField
        saveAction.isEnabled = !(textField!.text?.isEmpty ?? false)
    }
    
    /**
     Removes all entries of observer from notification center's dispatch table.
     */
    func removeTextFieldObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
