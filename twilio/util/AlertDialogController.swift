import UIKit

/**
 This is the class that handles the alerts to be shown in the app.
 */
class AlertDialogController: NSObject {

    /**
    This function just shows whatevver alert needs to be shown.
     */
    class func showAlertWithMessage(message: String?, title: String?, presenter: (UIViewController)) {
        showAlertWithMessage(message: message, title: title, presenter: presenter, completion: nil)
    }

    /**
     This function shows the alert and allows a user to handle the alert with actions. Could be something like 'cancel' or 'accept'.
     */
    class func showAlertWithMessage(message: String?, title: String?,
                                    presenter: (UIViewController), completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .cancel) { (_) -> Void in
            if let block = completion {
                block()
            }
        }

        alert.addAction(defaultAction)
        presenter.present(alert, animated: true, completion: nil)
    }
}
