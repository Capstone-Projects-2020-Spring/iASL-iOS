import UIKit

/**
 Handles the behavior and logic of the messaging features.
 */
class MessagingManager: NSObject {
    
    ///messaging manager
    static let _sharedManager = MessagingManager()
    
    ///twilio based client, part of API
    var client:TwilioChatClient?
    ///delegate for channel manager
    var delegate:ChannelManager?
    ///boolean to determine if user is connected to channel
    var connected = false
    
    //gets username of user
    var userIdentity:String {
        return SessionManager.getUsername()
    }
    
    ///determines if user is logged in
    var hasIdentity: Bool {
        return SessionManager.isLoggedIn()
    }
    
    ///sets the delegate of the channel manager
    override init() {
        super.init()
        delegate = ChannelManager.sharedManager
    }
    
    /**
     Gets the shared messaging manager.
     
     - Returns: The shared messaging manager.
     */
    class func sharedManager() -> MessagingManager {
        return _sharedManager
    }
    
    ///presents the main view controller of the messaging portion if the user is a user and is signed in
    func presentRootViewController() {
        if (!hasIdentity) {
            presentViewControllerByName(viewController: "LoginViewController")
            return
        }
        
        if (!connected) {
            connectClientWithCompletion { success, error in
                print("Delegate method will load views when sync is complete")
                if (!success || error != nil) {
                    DispatchQueue.main.async {
                        self.presentViewControllerByName(viewController: "LoginViewController")
                    }
                }
            }
            return
        }
        
        presentViewControllerByName(viewController: "RevealViewController")
    }
    
    /**
     Presents the main messaging veiw controller.
     
     - Parameter viewController: the view controller to be presented.
     */
    func presentViewControllerByName(viewController: String) {
        presentViewController(controller: storyBoardWithName(name: "Main").instantiateViewController(withIdentifier: viewController))
    }
    
    /**
     Presents the launch screen.
     */
    func presentLaunchScreen() {
        presentViewController(controller: storyBoardWithName(name: "LaunchScreen").instantiateInitialViewController()!)
    }
    
    /**
     Presents a view controller in a window.
     
     - Parameter controller: presents this view controller as the root view controller
     */
    func presentViewController(controller: UIViewController) {
        let window = UIApplication.shared.delegate!.window!!
        window.rootViewController = controller
    }
    
    /**
     Gets storyboard name.
     
     - Parameter name: name of storyboard to be returned.
     
     - Returns: a called storyboard with the name from the parameter.
     */
    func storyBoardWithName(name:String) -> UIStoryboard {
        return UIStoryboard(name:name, bundle: Bundle.main)
    }
    
    // MARK: User and session management
    
    /**
     Logs into the server with the given username.
     
     - Parameter username: String of users username
     - Parameter completion: Object for determining if user was logged in.
     */
    func loginWithUsername(username: String,
                           completion: @escaping (Bool, NSError?) -> Void) {
        SessionManager.loginWithUsername(username: username)
        connectClientWithCompletion(completion: completion)
    }
    
    ///Used to log out user of server.
    func logout() {
        SessionManager.logout()
        DispatchQueue.global(qos: .userInitiated).async {
            self.client?.shutdown()
            self.client = nil
        }
        self.connected = false
    }
    
    // MARK: Twilio Client
    
    /**
     Loads a chatroom for anyone to enter.
     
     - Parameter completion: object for determing if chatroom connection was successful.
     */
    func loadGeneralChatRoomWithCompletion(completion:@escaping (Bool, NSError?) -> Void) {
        ChannelManager.sharedManager.joinGeneralChatRoomWithCompletion { succeeded in
            if succeeded {
                completion(succeeded, nil)
            }
            else {
                let error = self.errorWithDescription(description: "Could not join General channel", code: 300)
                completion(succeeded, error)
            }
        }
    }
    
    /**
     Handles connection with chatroom.
     
     - Parameter completion. object for determining if chatroom connection was successful.
     */
    func connectClientWithCompletion(completion: @escaping (Bool, NSError?) -> Void) {
        if (client != nil) {
            logout()
        }
        
        requestTokenWithCompletion { succeeded, token in
            if let token = token, succeeded {
                self.initializeClientWithToken(token: token)
                completion(succeeded, nil)
            }
            else {
                let error = self.errorWithDescription(description: "Could not get access token", code:301)
                completion(succeeded, error)
            }
        }
    }
    
    /**
     Creates a client with a token.
     
     - Parameter token: used for securing connection with Twilio client.
     */
    func initializeClientWithToken(token: String) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        TwilioChatClient.chatClient(withToken: token, properties: nil, delegate: self) { [weak self] result, chatClient in
            guard (result.isSuccessful()) else { return }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self?.connected = true
            self?.client = chatClient
        }
    }
    
    /**
     Gets token for client.
     
     - Parameter completion. object for determining if chatroom connection was successful.
     */
    func requestTokenWithCompletion(completion:@escaping (Bool, String?) -> Void) {
        if let device = UIDevice.current.identifierForVendor?.uuidString {
            TokenRequestHandler.fetchToken(params: ["device": device, "identity":SessionManager.getUsername()]) {response,error in
                var token: String?
                token = response["token"] as? String
                completion(token != nil, token)
            }
        }
    }
    
    
    /**
     Handles errors.
     
     - Parameter description: String describing what the error was.
     - Parameter code: Int of code type.
     
     - Returns: NSError type.
     */
    func errorWithDescription(description: String, code: Int) -> NSError {
        let userInfo = [NSLocalizedDescriptionKey : description]
        return NSError(domain: "app", code: code, userInfo: userInfo)
    }
}

// MARK: - TwilioChatClientDelegate
extension MessagingManager : TwilioChatClientDelegate {
    func chatClient(_ client: TwilioChatClient, channelAdded channel: TCHChannel) {
        self.delegate?.chatClient(client, channelAdded: channel)
    }
    
    func chatClient(_ client: TwilioChatClient, channel: TCHChannel, updated: TCHChannelUpdate) {
        self.delegate?.chatClient(client, channel: channel, updated: updated)
    }
    
    func chatClient(_ client: TwilioChatClient, channelDeleted channel: TCHChannel) {
        self.delegate?.chatClient(client, channelDeleted: channel)
    }
    
    func chatClient(_ client: TwilioChatClient, synchronizationStatusUpdated status: TCHClientSynchronizationStatus) {
        if status == TCHClientSynchronizationStatus.completed {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            ChannelManager.sharedManager.channelsList = client.channelsList()
            ChannelManager.sharedManager.populateChannels()
            loadGeneralChatRoomWithCompletion { success, error in
                if success {
                    self.presentRootViewController()
                }
            }
        }
        self.delegate?.chatClient(client, synchronizationStatusUpdated: status)
    }
}

//// MARK: - TwilioAccessManagerDelegate
//extension MessagingManager : TwilioAccessManagerDelegate {
//    func accessManagerTokenWillExpire(_ accessManager: TwilioAccessManager) {
//        requestTokenWithCompletion { succeeded, token in
//            if (succeeded) {
//                accessManager.updateToken(token!)
//            }
//            else {
//                print("Error while trying to get new access token")
//            }
//        }
//    }
//
//    func accessManager(_ accessManager: TwilioAccessManager!, error: Error!) {
//        print("Access manager error: \(error.localizedDescription)")
//    }
//}
