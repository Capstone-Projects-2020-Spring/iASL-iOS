import UIKit


/**
 Handles user login and logout of database.
 */
class SessionManager {
    ///Holds key for username, to be used to get into specified database
    static let UsernameKey: String = "username"
    ///Holds key to determine if user is logged in or logged out
    static let IsLoggedInKey: String = "loggedIn"
    ///Manages defaults for users
    static let defaults = UserDefaults.standard
    
    /**
     Uses defaults to login user to database.
     
     - Parameter username: A string that holds the username of the user
     */
    class func loginWithUsername(username:String) {
        defaults.set(username, forKey: UsernameKey)
        defaults.set(true, forKey: IsLoggedInKey)
        
        defaults.synchronize()
    }
    
    /**
     Uses defaults to log user out of database.
     */
    class func logout() {
        defaults.set("", forKey: UsernameKey)
        defaults.set(false, forKey: IsLoggedInKey)
        defaults.synchronize()
    }
    
    /**
     Determines if user is already logged into database.
     
     - Returns: A true or false value to determine if the user is logged in already.
     */
    class func isLoggedIn() -> Bool {
        let isLoggedIn = defaults.bool(forKey: IsLoggedInKey)
        if (isLoggedIn) {
            return true
        }
        return false
    }
    
    /**
     Gets the username of the user.
     
     - Returns: A string of the users username.
     */
    class func getUsername() -> String {
        if let username = defaults.object(forKey: UsernameKey) as? String {
            return username
        }
        return ""
    }
}
