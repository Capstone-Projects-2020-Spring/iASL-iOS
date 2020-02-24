import UIKit
//import SlackTextViewController
import TwilioChatClient
///Handles the main chat
class MainChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //static let TWCChatCellIdentifier = "ChatTableCell"
    //static let TWCChatStatusCellIdentifier = "ChatStatusTableCell"
    
    //static let TWCOpenGeneralChannelSegue = "OpenGeneralChat"
    //static let TWCLabelTag = 200
    
//    var _channel:TCHChannel!
//    var channel:TCHChannel! {
//        get {
//            return _channel
//        }
//        set(channel) {
//            _channel = channel
//            title = _channel.friendlyName
//            _channel.delegate = self
//
//            if _channel == ChannelManager.sharedManager.generalChannel {
//                navigationItem.rightBarButtonItem = nil
//            }
//
//            joinChannel()
//        }
//    }
    
    ///a set of messages
    var messages:Set<TCHMessage> = Set<TCHMessage>()
    ///list of sorted messages
    var sortedMessages:[TCHMessage]!
    
    ///button for revealing content
    @IBOutlet weak var revealButtonItem: UIBarButtonItem!
    ///button to be pressed for actions to be initiated
    @IBOutlet weak var actionButtonItem: UIBarButtonItem!
    
    ///once view controller loads, it sets up the main chat
    override func viewDidLoad() {
        super.viewDidLoad()
		// FIXME: Need implementation
 /*
        if (revealViewController() != nil) {
            revealButtonItem.target = revealViewController()
            revealButtonItem.action = #selector(SWRevealViewController.revealToggle(_:))
            navigationController?.navigationBar.addGestureRecognizer(revealViewController().panGestureRecognizer())
            revealViewController().rearViewRevealOverdraw = 0
        }
        
        bounces = true
        shakeToClearEnabled = true
        isKeyboardPanningEnabled = true
        shouldScrollToBottomAfterKeyboardShows = false
        isInverted = true
        
        let cellNib = UINib(nibName: MainChatViewController.TWCChatCellIdentifier, bundle: nil)
        tableView!.register(cellNib, forCellReuseIdentifier:MainChatViewController.TWCChatCellIdentifier)
        
        let cellStatusNib = UINib(nibName: MainChatViewController.TWCChatStatusCellIdentifier, bundle: nil)
        tableView!.register(cellStatusNib, forCellReuseIdentifier:MainChatViewController.TWCChatStatusCellIdentifier)
        
        textInputbar.autoHideRightButton = true
        textInputbar.maxCharCount = 256
        textInputbar.counterStyle = .split
        textInputbar.counterPosition = .top
        
        let font = UIFont(name:"Avenir-Light", size:14)
        textView.font = font
        
        rightButton.setTitleColor(UIColor(red:0.973, green:0.557, blue:0.502, alpha:1), for: .normal)
        
        if let font = UIFont(name:"Avenir-Heavy", size:17) {
            navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font]
        }
        
        tableView!.allowsSelection = false
        tableView!.estimatedRowHeight = 70
        tableView!.rowHeight = UITableViewAutomaticDimension
        tableView!.separatorStyle = .none
        
        if channel == nil {
            channel = ChannelManager.sharedManager.generalChannel
        }
*/
    }
    
    ///lays out subviews of text input bar
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // required for iOS 11
		// FIXME: Need implementation
		/*
        textInputbar.bringSubview(toFront: textInputbar.textView)
        textInputbar.bringSubview(toFront: textInputbar.leftButton)
        textInputbar.bringSubview(toFront: textInputbar.rightButton)
        */
    }
    
    ///scrolls to bottom when top view disappears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToBottom()
    }
    
    ///returns the number of sections for the table view
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    ///returns the length of the table view
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: NSInteger) -> Int {
        return messages.count
    }
    
    /**
     Sets up the table view for the chat. This is where messages are held, in cells.
     
     - Parameter tableView: table view to be set with messages
     - Parameter cellForRowAt: index of the particular cell
     
     - Returns: a table view cell
     */
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        
        let message = sortedMessages[indexPath.row]
        
        if let statusMessage = message as? StatusMessage {
            cell = getStatusCellForTableView(tableView: tableView, forIndexPath:indexPath, message:statusMessage)
        }
        else {
            cell = getChatCellForTableView(tableView: tableView, forIndexPath:indexPath, message:message)
        }
        
        cell.transform = tableView.transform
        return cell
    }
    
    /**
     This gets a particular cell for a chat and sets the user to that chat.
     
     - Parameter tabelView: table view for the cells to go
     - Parameter forIndexPath: index path of the partiucar cell
     - Parameter message: message of the cell
     
     - Returns: a table view cell with the message, timestamp for the message, and the user set
     */
    func getChatCellForTableView(tableView: UITableView, forIndexPath indexPath:IndexPath, message: TCHMessage) -> UITableViewCell {
		// FIXME: Need customCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: MainChatViewController.TWCChatCellIdentifier, for:indexPath as IndexPath)
        /*
        let chatCell: ChatTableCell = cell as! ChatTableCell
        let date = NSDate.dateWithISO8601String(dateString: message.timestamp ?? "")
        let timestamp = DateTodayFormatter().stringFromDate(date: date)
        
        chatCell.setUser(user: message.author ?? "[Unknown author]", message: message.body, date: timestamp ?? "[Unknown date]")
        */
		return UITableViewCell(frame: .zero)
    }
    
    /**
     Gets the cell and determines the status for a particular cell.
     
     - Parameter tableView: table view for the cells to go
     - Parameter forIndexPath: index path of a certain cell
     - Parameter message: status of the member
     
     - Returns: a cell with the label set with the user's status
     */
    func getStatusCellForTableView(tableView: UITableView, forIndexPath indexPath:IndexPath, message: StatusMessage) -> UITableViewCell {
		// FIXME: Need implementation
		/*
        let cell = tableView.dequeueReusableCell(withIdentifier: MainChatViewController.TWCChatStatusCellIdentifier, for:indexPath as IndexPath)
        
        let label = cell.viewWithTag(MainChatViewController.TWCLabelTag) as! UILabel
        let memberStatus = (message.status! == .Joined) ? "joined" : "left"
        label.text = "User \(message.member.identity ?? "[Unknown user]") has \(memberStatus)"
        return cell
*/
		return UITableViewCell(frame: .zero)
    }
    
    ///Lets the user join a channel and loads the channels messages
    func joinChannel() {
		// FIXME: Need implementation
		/*
        setViewOnHold(onHold: true)
        
        if channel.status != .joined {
            channel.join { result in
                print("Channel Joined")
            }
            return
        }
        
        loadMessages()
        setViewOnHold(onHold: false)
*/
    }
    
    ///Disable user input and show activity indicator
    func setViewOnHold(onHold: Bool) {
		// FIXME: Need implementation
       /*
		self.isTextInputbarHidden = onHold;
        UIApplication.shared.isNetworkActivityIndicatorVisible = onHold;
*/
    }
    
    ///sends a message when pressed
	func didPressRightButton(_ sender: Any!) {
       // FIXME: Need implementation
		/*
		textView.refreshFirstResponder()
        sendMessage(inputMessage: textView.text)
        super.didPressRightButton(sender)
*/
    }
    
    // MARK: - Chat Service
    
    /**
     Handles sending a message.
     
     - Parameter inputMessage: String of the message content
     */
    func sendMessage(inputMessage: String) {
		// FIXME: Need implementation
       /* let messageOptions = TCHMessageOptions().withBody(inputMessage)
        channel.messages?.sendMessage(with: messageOptions, completion: nil)*/
    }
    
    /**
     Adds messages to table view.
     
     - Parameter newMessages: a list of messages to be added
     */
    func addMessages(newMessages:Set<TCHMessage>) {
        messages =  messages.union(newMessages)
        sortMessages()
        DispatchQueue.main.async {
			// FIXME: Need implementation
//            self.tableView!.reloadData()
            if self.messages.count > 0 {
                self.scrollToBottom()
            }
        }
    }
    
    ///sorts messages by time
    func sortMessages() {
	   // FIXME: Need implementation
		/*
		sortedMessages = messages.sorted { (a, b) -> Bool in
            (a.timestamp ?? "") > (b.timestamp ?? "")
        }
*/
    }
    
    ///loads all messages
    func loadMessages() {
		// FIXME: Need implementation
		/*
        messages.removeAll()
        if channel.synchronizationStatus == .all {
            channel.messages?.getLastWithCount(100) { (result, items) in
                self.addMessages(newMessages: Set(items!))
            }
        }
*/
    }
    
    ///scrolls to bottom of chat
    func scrollToBottom() {
		// FIXME: Need implementation
		/*
        if messages.count > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            tableView!.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
*/
    }
    
    ///leaves channel when user logs out of channel, switches over to new view controller
    func leaveChannel() {
		// FIXME: Need implementation
		/*
        channel.leave { result in
            if (result.isSuccessful()) {
                let menuViewController = self.revealViewController().rearViewController as! MenuViewController
                menuViewController.deselectSelectedChannel()
                self.revealViewController().rearViewController.performSegue(withIdentifier: MainChatViewController.TWCOpenGeneralChannelSegue, sender: nil)
            }
        }
*/
    }
    
    // MARK: - Actions
    
    ///when pressed, leaves channel for user
    @IBAction func actionButtonTouched(_ sender: UIBarButtonItem) {
        leaveChannel()
    }
    
    ///reveals a new view controller
    @IBAction func revealButtonTouched(_ sender: AnyObject) {
		// FIXME: Need implementation
       // revealViewController().revealToggle(animated: true)
    }
}

//extension MainChatViewController : TCHChannelDelegate {
//    func chatClient(_ client: TwilioChatClient, channel: TCHChannel, messageAdded message: TCHMessage) {
//        if !messages.contains(message) {
//            addMessages(newMessages: [message])
//        }
//    }
//
//    func chatClient(_ client: TwilioChatClient, channel: TCHChannel, memberJoined member: TCHMember) {
//        addMessages(newMessages: [StatusMessage(member:member, status:.Joined)])
//    }
//    
//    func chatClient(_ client: TwilioChatClient, channel: TCHChannel, memberLeft member: TCHMember) {
//        addMessages(newMessages: [StatusMessage(member:member, status:.Left)])
//    }
//
//    func chatClient(_ client: TwilioChatClient, channelDeleted channel: TCHChannel) {
//        DispatchQueue.main.async {
//            if channel == self.channel {
//                self.revealViewController().rearViewController
//                    .performSegue(withIdentifier: MainChatViewController.TWCOpenGeneralChannelSegue, sender: nil)
//            }
//        }
//    }
//
//    func chatClient(_ client: TwilioChatClient,
//                    channel: TCHChannel,
//                    synchronizationStatusUpdated status: TCHChannelSynchronizationStatus) {
//        if status == .all {
//            loadMessages()
//            DispatchQueue.main.async {
//                self.tableView?.reloadData()
//                self.setViewOnHold(onHold: false)
//            }
//        }
//    }
//}
