import UIKit

///Holds the information for each cell of a chat table view
class ChatTableCell: UITableViewCell {
    //static let TWCUserLabelTag = 200
    //static let TWCDateLabelTag = 201
    //static let TWCMessageLabelTag = 202
    
    ///name of the user in this chat cell
    var userLabel: UILabel!
    ///content of the message in this chat cell
    var messageLabel: UILabel!
    ///date of the message sent in this chat cell
    var dateLabel: UILabel!
    
    /**
     Sets the values of this cell.
     
     - Parameter user: name of the user
     - Parameter message: content of the message
     - Parameter date: date of the message
     */
    func setUser(user:String!, message:String!, date:String!) {
        userLabel.text = user
        messageLabel.text = message
        dateLabel.text = date
    }
    
    ///sets the values on the view controller
    override func awakeFromNib() {
        userLabel = viewWithTag(ChatTableCell.TWCUserLabelTag) as? UILabel
        messageLabel = viewWithTag(ChatTableCell.TWCMessageLabelTag) as? UILabel
        dateLabel = viewWithTag(ChatTableCell.TWCDateLabelTag) as? UILabel
    }
}
