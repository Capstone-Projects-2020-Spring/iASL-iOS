# RemoteConversationVC

``` swift
class RemoteConversationVC: UIViewController, UITableViewDataSource, UITableViewDelegate
```

## Inheritance

`UITableViewDataSource`, `UITableViewDelegate`, `UIViewController`

## Properties

### `people`

``` swift
var people
```

### `refreshControl`

``` swift
let refreshControl
```

### `messages`

``` swift
var messages
```

### `messagesDictionary`

``` swift
var messagesDictionary
```

### `messagesToDelete`

``` swift
var messagesToDelete
```

### `partnerToDelete`

``` swift
var partnerToDelete
```

### `keychain`

``` swift
let keychain
```

### `topBar`

``` swift
let topBar
```

### `topLabel`

``` swift
let topLabel
```

### `backButton`

``` swift
let backButton
```

### `tableView`

``` swift
let tableView
```

### `liveButton`

``` swift
let liveButton
```

### `logoutButton`

``` swift
let logoutButton: UIButton
```

### `addChatButton`

``` swift
let addChatButton: UIButton
```

### `preferredStatusBarStyle`

``` swift
var preferredStatusBarStyle: UIStatusBarStyle
```

## Methods

### `viewDidLoad()`

``` swift
override func viewDidLoad()
```

### `refreshTableViewOnPull()`

``` swift
@objc func refreshTableViewOnPull()
```

### `observeUserMessages()`

``` swift
func observeUserMessages()
```

### `observeDeleteMessages(chatPartner:senderId:receiverId:)`

called when we need to figure out what needs to be deleted

``` swift
func observeDeleteMessages(chatPartner: String, senderId: String, receiverId: String)
```

### `handleAddChat()`

Add a user to a current conversation

``` swift
@objc func handleAddChat()
```

### `handleLogout()`

handles the logout button, so it logs the user out of firebae and presents the login controller

``` swift
@objc func handleLogout()
```

### `logoutButtonSetup()`

sets the anchors and adds the button to the top bar

``` swift
func logoutButtonSetup()
```

### `addChatButtonSetup()`

``` swift
func addChatButtonSetup()
```

### `tableView(_:numberOfRowsInSection:)`

``` swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```

### `tableView(_:heightForRowAt:)`

``` swift
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
```

### `tableView(_:estimatedHeightForRowAt:)`

``` swift
func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
```

### `tableView(_:cellForRowAt:)`

``` swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
```

### `tableView(_:didSelectRowAt:)`

``` swift
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
```

### `tableView(_:commit:forRowAt:)`

used for deleting a particular row in the table view

``` swift
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
```

### `handleDeleteNote()`

handles the deleting of the note

``` swift
func handleDeleteNote()
```

### `handleDeleteNoteAreYouSure(indexPath:)`

asks the users in an alert if they would like to proceed with deleting their conversation

``` swift
func handleDeleteNoteAreYouSure(indexPath: IndexPath)
```

### `showChatVCForUser(user:)`

``` swift
func showChatVCForUser(user: User)
```

### `showChatVC(name:)`

``` swift
func showChatVC(name: String)
```

### `viewWillAppear(_:)`

``` swift
override func viewWillAppear(_ animated: Bool)
```

### `tableViewSetup()`

``` swift
func tableViewSetup()
```

### `topBarSetup()`

``` swift
func topBarSetup()
```

### `backButtonSetup()`

``` swift
func backButtonSetup()
```

### `backButtonTapped()`

``` swift
@objc func backButtonTapped()
```

### `topLabelSetup()`

``` swift
func topLabelSetup()
```
