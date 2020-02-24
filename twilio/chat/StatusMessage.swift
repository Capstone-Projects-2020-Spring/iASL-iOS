import UIKit
import UIKit

///holds the status of the member
enum TWCMemberStatus {
    case Joined
    case Left
}

///holds variables and metadata for status message
class StatusMessage: TCHMessage {
    ///type of member
    var member: TCHMember! = nil
    ///members status
    var status: TWCMemberStatus! = nil
    ///timestamp of message
    var _timestamp: String = ""
    
    ///gets or sets timestamp
     var timestamp: String {
        get {
            return _timestamp
        }
        set(newTimestamp) {
            _timestamp = newTimestamp
        }
    }
    
    /**
     Initializes status message.
     
     - Parameter member: type of member
     - Parameter status: status of member
     */
    init(member: TCHMember, status: TWCMemberStatus) {
        super.init()
        self.member = member
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
		dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone?
        timestamp = dateFormatter.string(from: NSDate() as Date)
        self.status = status
    }
    
    
}
