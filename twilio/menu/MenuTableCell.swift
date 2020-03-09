import UIKit

/**
 Manages some menu behavior and design aspects.
 */
class MenuTableCell: UITableViewCell {
    ///temporary UILabel
    var label: UILabel!

    ///gets the channel name and sets it to the label
    var channelName: String {
        get {
            return label?.text ?? String()
        }
        set(name) {
            label.text = name
        }
    }

    ///sets the background color of whatever string gets selected
    var selectedBackgroundColor: UIColor {
        return UIColor(red: 0.969, green: 0.902, blue: 0.894, alpha: 1)
    }

    ///returns the color of a highlighted label
    var labelHighlightedTextColor: UIColor {
        return UIColor(red: 0.22, green: 0.024, blue: 0.016, alpha: 1)
    }

    ///returns the color of the label
    var labelTextColor: UIColor {
        return UIColor(red: 0.973, green: 0.557, blue: 0.502, alpha: 1)
    }

    ///once called, sets the label as the highlighted text color and the text color
    override func awakeFromNib() {
        label = viewWithTag(200) as? UILabel
        label.highlightedTextColor = labelHighlightedTextColor
        label.textColor = labelTextColor
    }

    /**
     Handles what happens when something is selected. Sets the appropriate background color.
     
     - Parameter selected: true or false to determine if something was selected
     - Parameter animated: true or false to determine if something should be animated
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = selectedBackgroundColor
        }
    }

    /**
    Handles what happens when something is highlighted. Sets the appropriate background color.
    
    - Parameter highlighted: true or false to determine if something was highlighted
    - Parameter animated: true or false to determine if something should be animated
    */
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            contentView.backgroundColor = selectedBackgroundColor
        }
    }
}
