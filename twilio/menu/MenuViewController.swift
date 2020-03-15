import UIKit

///Handles the menu and its behavior.
class MenuViewController: UIViewController {

    ///Segue identifier for opening a chat
    static let TWCOpenChannelSegue = "OpenChat"
    ///sets refresh control
    static let TWCRefreshControlXOffset: CGFloat = 120

    ///table view that holds the chat
    @IBOutlet weak var tableView: UITableView!
    ///label that holds the username
    @IBOutlet weak var usernameLabel: UILabel!

    ///variable that holds the refresh control
    var refreshControl: UIRefreshControl!

    ///when the view controller first loads
    override func viewDidLoad() {
        super.viewDidLoad()

        let bgImage = UIImageView(image: UIImage(named: "home-bg"))
        bgImage.frame = self.tableView.frame
        tableView.backgroundView = bgImage

        usernameLabel.text = MessagingManager.sharedManager().userIdentity

        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(MenuViewController.refreshChannels), for: .valueChanged)
        refreshControl.tintColor = UIColor.white

        self.refreshControl.frame.origin.x -= MenuViewController.TWCRefreshControlXOffset
        ChannelManager.sharedManager.delegate = self
        reloadChannelList()
    }

    // MARK: - Internal methods

    /**
     Loads the table view cells.
     
     - Parameter tableView: the table view to be read and populated with cells
     
     - Returns: table view cell
     */
    func loadingCellForTableView(tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "loadingCell")!
    }

    /**
     Sets the channel in each of the cells.
     
     - Parameter tableView: table view for chat
     - Parameter atIndexPath: index of table view cells
     
     - Returns: table view cell
     */
    func channelCellForTableView(tableView: UITableView, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let menuCell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath as IndexPath) as! MenuTableCell

        let channel = ChannelManager.sharedManager.channels![indexPath.row] as! AnyObject

        menuCell.channelName = channel.friendlyName ?? "[Unknown channel name]"
        return menuCell
    }

    ///reloads the table view and sets the refresh control to stop
    func reloadChannelList() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    ///starts refreshing again
    func refreshChannels() {
        refreshControl.beginRefreshing()
        reloadChannelList()
    }

    ///unselects cell in the table view
    func deselectSelectedChannel() {
        let selectedRow = tableView.indexPathForSelectedRow
        if let row = selectedRow {
            tableView.deselectRow(at: row, animated: true)
        }
    }

    // MARK: - Channel

    ///creates a dialogue box for the user to respond to
    func createNewChannelDialog() {
        InputDialogController.showWithTitle(title: "New Channel",
                                            message: "Enter a name for this channel",
                                            placeholder: "Name",
                                            presenter: self) { text in
                                                ChannelManager.sharedManager.createChannelWithName(name: text, completion: { _, _ in
                                                    ChannelManager.sharedManager.populateChannels()
                                                })
        }
    }

    // MARK: Logout

    ///adds an alert action for the user to log out
    func promptLogout() {
        let alert = UIAlertController(title: nil, message: "You are about to Logout", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            self.logOut()
        }

        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }

    ///logs the user out
    func logOut() {
        MessagingManager.sharedManager().logout()
        MessagingManager.sharedManager().presentRootViewController()
    }

    // MARK: - Actions

    ///handles what happens when the user presses the log out button
    @IBAction func logoutButtonTouched(_ sender: UIButton) {
        promptLogout()
    }

    ///handles what happens when the user presses the new channel button
    @IBAction func newChannelButtonTouched(_ sender: UIButton) {
        createNewChannelDialog()
    }

    // MARK: - Navigation

    /**
     Gets the view controller ready to switch to another view controller
     
     - Parameter segue: new storyboard that will be loaded next
     - Parameter sender: where the segue call came from
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MenuViewController.TWCOpenChannelSegue {
            let indexPath = sender as! NSIndexPath
            let channelDescriptor = ChannelManager.sharedManager.channels![indexPath.row] as! TCHChannelDescriptor
            let navigationController = segue.destination as! UINavigationController

            channelDescriptor.channel { _, channel in
                (navigationController.visibleViewController as! MainChatViewController).channel = channel
            }
        }
    }

    // MARK: - Style

    ///changes the background color preference 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let channels = ChannelManager.sharedManager.channels {
            return channels.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell

        if ChannelManager.sharedManager.channels == nil {
            cell = loadingCellForTableView(tableView: tableView)
        } else {
            cell = channelCellForTableView(tableView: tableView, atIndexPath: indexPath as NSIndexPath)
        }

        cell.layoutIfNeeded()
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let channel = ChannelManager.sharedManager.channels?.object(at: indexPath.row) as? TCHChannel {
            return channel != ChannelManager.sharedManager.generalChannel
        }
        return false
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle != .delete {
            return
        }
        if let channel = ChannelManager.sharedManager.channels?.object(at: indexPath.row) as? TCHChannel {
            channel.destroy { result in
                if result.isSuccessful() {
                    tableView.reloadData()
                } else {
                    AlertDialogController.showAlertWithMessage(message: "You can not delete this channel", title: nil, presenter: self)
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate
//extension MenuViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: MenuViewController.TWCOpenChannelSegue, sender: indexPath)
//    }
//}
//
// MARK: - TwilioChatClientDelegate
//extension MenuViewController : TwilioChatClientDelegate {
//    func chatClient(_ client: TwilioChatClient, channelAdded channel: TCHChannel) {
//        tableView.reloadData()
//    }
//
//    func chatClient(_ client: TwilioChatClient, channel: TCHChannel, updated: TCHChannelUpdate) {
//        tableView.reloadData()
//    }
//
//    func chatClient(_ client: TwilioChatClient, channelDeleted channel: TCHChannel) {
//        tableView.reloadData()
//    }
//}
