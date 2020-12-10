# RemoteConversationVC

This class is responsible for the main messaging screen. It holds the table view of all of the users's conversations as well as ways for users to create new conversations and delete old ones.

``` swift
class RemoteConversationVC: UIViewController, UITableViewDataSource, UITableViewDelegate
```

## Inheritance

`UITableViewDataSource`, `UITableViewDelegate`, `UIViewController`

## Properties

### `refreshControl`

Variable for the pull to refresh mode in the table view

``` swift
let refreshControl
```

### `messages`

This is where all the messages will go

``` swift
var messages
```

### `messagesDictionary`

For organizing messages by name and most recent

``` swift
var messagesDictionary
```

### `messagesToDelete`

Holds the messages we need to delete when a conversation is deleted

``` swift
var messagesToDelete
```

### `partnerToDelete`

ID of the chat partner to delete

``` swift
var partnerToDelete
```

### `keychain`

Keychain reference for when we need to clear the keychain if someone logs out

``` swift
let keychain
```

### `topBar`

Variable for the top bar of the view

``` swift
let topBar
```

### `topLabel`

Variable for the label that holds the 'Chat" name

``` swift
let topLabel
```

### `backButton`

Back button variable for going to previous view controller

``` swift
let backButton
```

### `tableView`

Variable for the table view that holds the list of chats

``` swift
let tableView
```

### `logoutButton`

Variable closure for the logout button

``` swift
let logoutButton: UIButton
```

### `addChatButton`

Variable closure for the button used to add a chat

``` swift
let addChatButton: UIButton
```

### `preferredStatusBarStyle`

Change the color of the status bar

``` swift
var preferredStatusBarStyle: UIStatusBarStyle
```

## Methods

### `viewDidLoad()`

View did load function that calls all the important set up functions

``` swift
override func viewDidLoad()
```

### `refreshTableViewOnPull()`

Called when the user pulls to refresh the table

``` swift
@objc func refreshTableViewOnPull()
```

### `observeUserMessages()`

Function for observing messages added to the Firebase database. Puts them in an array of type Messages to be used by the table view.

``` swift
func observeUserMessages()
```

### `observeDeleteMessages(chatPartner:senderId:receiverId:)`

Called when we need to figure out what messages and which conversation needs to be deleted

``` swift
func observeDeleteMessages(chatPartner: String, senderId: String, receiverId: String)
```

### `tableView(_:numberOfRowsInSection:)`

Returns the size of the messages array so it knows how many table view cells to make

``` swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```

### `tableView(_:heightForRowAt:)`

Returns the height for each row of the table view

``` swift
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
```

### `tableView(_:estimatedHeightForRowAt:)`

Returns the estimated height for each row of the table view

``` swift
func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
```

### `tableView(_:cellForRowAt:)`

For each cell in the table view, returns a custom cell with a message particular message

``` swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
```

### `tableView(_:didSelectRowAt:)`

Handles what happens when a certain cell is selected

``` swift
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
```

### `tableView(_:commit:forRowAt:)`

Used for deleting a particular row in the table view

``` swift
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
```

### `handleDeleteNote()`

Handles the deleting of the note

``` swift
func handleDeleteNote()
```

### `handleDeleteNoteAreYouSure(indexPath:)`

Asks the users in an alert if they would like to proceed with deleting their conversation

``` swift
func handleDeleteNoteAreYouSure(indexPath: IndexPath)
```

### `showChatVCForUser(user:)`

Shows the chat VC when the user taps on the table view

``` swift
func showChatVCForUser(user: User)
```

### `showChatVC(name:)`

Shows the chat VC when the user taps on the table view

``` swift
func showChatVC(name: String)
```

### `viewWillAppear(_:)`

Change the color of the status bar

``` swift
override func viewWillAppear(_ animated: Bool)
```

### `tableViewSetup()`

Sets up the table view and defines its constraints

``` swift
func tableViewSetup()
```

### `topBarSetup()`

Sets up the top bar and defiens its constraints

``` swift
func topBarSetup()
```

### `backButtonSetup()`

Sets up the back button and defines its constraints

``` swift
func backButtonSetup()
```

### `backButtonTapped()`

Handles what happens when the back button is tapped

``` swift
@objc func backButtonTapped()
```

### `topLabelSetup()`

Sets up the top label and defines its constraints

``` swift
func topLabelSetup()
```

### `handleAddChat()`

Add a user to a current conversation

``` swift
@objc func handleAddChat()
```

### `handleLogout()`

Handles the logout button, so it logs the user out of firebae and presents the login controller

``` swift
@objc func handleLogout()
```

### `logoutButtonSetup()`

Sets the anchors and adds the button to the top bar

``` swift
func logoutButtonSetup()
```

### `addChatButtonSetup()`

Adds the add chat button to the subveiw and defines its constraints

``` swift
func addChatButtonSetup()
```
