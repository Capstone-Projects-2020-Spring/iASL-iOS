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

# ChatUserCell

This class is for creating a custom cell in the table view of our main messaging feature screen. It handles the design of all the pieces that make up our custom cell and hanldes some logic for handling which information goes where.

``` swift
class ChatUserCell: UITableViewCell
```

## Inheritance

`UITableViewCell`

## Initializers

### `init(style:reuseIdentifier:)`

Init function that is called whenever this class is used. This calls the main set up functions for the constraints and the subviews

``` swift
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
```

### `init?(coder:)`

Required init function in case of fatal error

``` swift
required init?(coder: NSCoder)
```

## Properties

### `nameLabel`

This is a closure for the label that holds the name of the chatter

``` swift
let nameLabel: UILabel
```

### `mostRecentMessageLabel`

This is a closure for the label that holds the text of the most recent message sent in the chat

``` swift
let mostRecentMessageLabel: UILabel
```

### `timestampLabel`

This is a closure for the timestamp label that holds the time that the most recently sent message was sent

``` swift
let timestampLabel: UILabel
```

### `message`

In the table view, this sets the message and does the work for getting the name of the user and the message

``` swift
var message: Message?
```

## Methods

### `setNameLabel(_:)`

Sets the name label to the name gotten by the message variable

``` swift
fileprivate func setNameLabel(_ id: String)
```

### `setMostRecentMessageLabel(_:)`

Sets the most recent message label gotten by the message variable

``` swift
fileprivate func setMostRecentMessageLabel(_ messageText: String)
```

### `setTimestampLabel(_:)`

Sets the timestamp label gotten by the message variable

``` swift
fileprivate func setTimestampLabel(_ milliseconds: Double)
```

### `layoutSubviews()`

Function for laying out the subviews

``` swift
override func layoutSubviews()
```

### `setupNameLabel()`

Adds the name label to the subview and defines where in the subveiw it will be placed

``` swift
func setupNameLabel()
```

### `setupMessageLabel()`

Adds the most recent message label to the subview and defines where in the subveiw it will be placed

``` swift
func setupMessageLabel()
```

### `setupTimestampLabel()`

Adds the timestamp label to the subview and defines where in the subveiw it will be placed

``` swift
func setupTimestampLabel()
```
# AddChatVC

This class handles the ability for the user to choose a partner to chat with.

``` swift
class AddChatVC: UIViewController
```

## Inheritance

`UITableViewDataSource`, `UITableViewDelegate`, `UIViewController`

## Properties

### `cellId`

Variable that holds the cell ID constant

``` swift
let cellId
```

### `usersConstant`

Variable that holds the "users" constant for Firebase

``` swift
let usersConstant: String
```

### `users`

An array of users

``` swift
var users
```

### `remoteConversations`

Reference variable so we can transition into chatVC via remote conversations

``` swift
var remoteConversations: RemoteConversationVC?
```

### `topBar`

Variable for a uiview for the top bar of the screen

``` swift
let topBar
```

### `topLabel`

Variable for the top label that holds the name of the view controller

``` swift
let topLabel
```

### `backButton`

Button for users to go back to the previous view controller

``` swift
let backButton
```

### `tableView`

Variable for the table view that holds all of the users' names

``` swift
let tableView
```

### `preferredStatusBarStyle`

Change the color of the status bar

``` swift
var preferredStatusBarStyle: UIStatusBarStyle
```

## Methods

### `viewDidLoad()`

View did load function that calls all of the setup functions

``` swift
override func viewDidLoad()
```

### `getUsers()`

Gets all of the users from the database and stores them in an array of Users

``` swift
func getUsers()
```

### `tableView(_:numberOfRowsInSection:)`

Returns the size of the users array so that the table view knows how many rows to load

``` swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```

### `tableView(_:cellForRowAt:)`

Determines what data gets loaded in each row of the table view, returns a table view cell with that data

``` swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
```

### `tableView(_:didSelectRowAt:)`

Handles what happens when a user taps on a specific cell in the table view

``` swift
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
```

### `tableViewSetup()`

Sets up the table view and defines its constraints

``` swift
func tableViewSetup()
```

### `topBarSetup()`

Sets up the top bar view and defines its constraints

``` swift
func topBarSetup()
```

### `backButtonSetup()`

Sets up the back button view and defines its constraints

``` swift
func backButtonSetup()
```

### `backButtonTapped()`

Handles what happens when the back button is tapped

``` swift
@objc func backButtonTapped()
```

### `topLabelSetup()`

Sets up the top label view and defines its constraints

``` swift
func topLabelSetup()
```

### `viewWillAppear(_:)`

Change the color of the status bar

``` swift
override func viewWillAppear(_ animated: Bool)
```

# Note

This will hold each note that is saved in Firebase

``` swift
class Note: NSObject
```

## Inheritance

`NSObject`

## Properties

### `id`

Unique ID of the note

``` swift
var id: String?
```

### `title`

Title of the specific note

``` swift
var title: String?
```

### `text`

Text of the specific note

``` swift
var text: String?
```

### `timestamp`

The exact time the note was saved

``` swift
var timestamp: NSNumber?
```

### `ownerId`

Unique ID of the user who created this note

``` swift
var ownerId: String?
```

# LoginVC

This view controller is for the login screen that a user will see when they first open the app. The user should be able to enter their name, email, and password if they have not registered before or just their email and password if they are a returning user.

``` swift
class LoginVC: UIViewController, UITextFieldDelegate
```

## Inheritance

`UITextFieldDelegate`, `UIViewController`

## Properties

### `isRegisterButton`

Boolean that determines if we are on the login screen or the register screen

``` swift
var isRegisterButton: Bool
```

### `isFirstOpen`

``` swift
var isFirstOpen
```

### `usersStringConstant`

Constant that holds the "users" node for Firebase

``` swift
let usersStringConstant: String
```

### `welcomeScreenConfig`

``` swift
var welcomeScreenConfig
```

### `keychain`

Keychain that holds the users password and email so that users do not have to sign in every time they open the app

``` swift
let keychain
```

### `inputsContainerViewHeightAnchor`

Creates a reference to the input container height anchor to be altered later

``` swift
var inputsContainerViewHeightAnchor: NSLayoutConstraint?
```

### `nameTextFieldHeightAnchor`

Creates a reference to the name text field

``` swift
var nameTextFieldHeightAnchor: NSLayoutConstraint?
```

### `emailTextFieldHeightAnchor`

Creates a reference to the email text field

``` swift
var emailTextFieldHeightAnchor: NSLayoutConstraint?
```

### `passwordTextFieldHeightAnchor`

Creates a reference to the password text field

``` swift
var passwordTextFieldHeightAnchor: NSLayoutConstraint?
```

### `skipButton`

Button for skipping the login screen

``` swift
let skipButton: UIButton
```

### `keychainToggle`

Toggle for turning on and off the keychain feature

``` swift
let keychainToggle: UISwitch
```

### `keychainToggleLabel`

The label that informs the user about the toggle feature

``` swift
var keychainToggleLabel: UILabel
```

### `logoContainerView`

Container that is holding the logo

``` swift
let logoContainerView: UIView
```

### `nameTextField`

The textfield where the user can enter their name when they are registering

``` swift
let nameTextField: UITextField
```

### `emailTextField`

The textfield where the user can enter their email when they are registering

``` swift
let emailTextField: UITextField
```

### `passwordTextField`

The textfield where the user can enter their password when they are registering

``` swift
let passwordTextField: UITextField
```

### `inputContainerView`

Container that holds the three textviews

``` swift
let inputContainerView: UIView
```

### `nameSeparatorView`

creates the orange lines between the name and the email

``` swift
let nameSeparatorView: UIView
```

### `emailSeparatorView`

Creates the orange line between the email and the password

``` swift
let emailSeparatorView: UIView
```

### `logoView`

A logo for the login screen

``` swift
let logoView: UIImageView
```

### `toggleRegisterLoginButton`

The button that changes the view from register mode to login mode

``` swift
let toggleRegisterLoginButton: UIButton
```

### `infoSubmitButton`

When this button is pressed, the information entered will be sent to firebase

``` swift
let infoSubmitButton: UIButton
```

## Methods

### `showWelcomeScreen()`

``` swift
@objc func showWelcomeScreen()
```

### `viewDidAppear(_:)`

``` swift
override func viewDidAppear(_ animated: Bool)
```

### `welcomeScreenSetup()`

``` swift
fileprivate func welcomeScreenSetup()
```

### `switchChanged()`

Called when the toggle switch is toggled

``` swift
@objc func switchChanged()
```

### `viewDidLoad()`

View did load function that calls the important setup functions

``` swift
override func viewDidLoad()
```

### `handleLeaveLogin()`

Called when this view controller needs to disappear and the main view controller needs to load

``` swift
func handleLeaveLogin()
```

### `handleSkipButton()`

Handles what happens with the skip button is pressed

``` swift
@objc func handleSkipButton()
```

### `hideKeyboard()`

This gets called when the register or login button is pressed

``` swift
func hideKeyboard()
```

### `hideKeyboardOnTap()`

When the user taps anywhere else on the screen, it hides the keyboard

``` swift
@objc func hideKeyboardOnTap()
```

### `keyboardWillChange(notification:)`

Called when the keyboard is about to change

``` swift
@objc func keyboardWillChange(notification: Notification)
```

### `toggleRegisterLoginButtonPressed()`

Handles the toggle button for the register and login button

``` swift
@objc func toggleRegisterLoginButtonPressed()
```

### `infoSubmitButtonPressed()`

When this is pressed, the info should be sent to Firebase and the keyboard should disappear, and the view should disappear

``` swift
@objc func infoSubmitButtonPressed()
```

### `handleRegister()`

Handles what happens when the user decides to register an account

``` swift
func handleRegister()
```

### `handleSaveKeychain(email:password:)`

Handles the saving of the user's email and password into keychain

``` swift
func handleSaveKeychain(email: String, password: String)
```

### `handleLogin()`

Handles what happens when the user logins in with an existing account

``` swift
func handleLogin()
```

### `setupInputContainerView()`

Sets up the constraints for the input container

``` swift
func setupInputContainerView()
```

### `setupNameTextFieldConstraints()`

Sets up the constraints of the name text field

``` swift
func setupNameTextFieldConstraints()
```

### `setupEmailTextFieldConstraints()`

Sets up the constraints of the email text field

``` swift
func setupEmailTextFieldConstraints()
```

### `setupPasswordTextFieldConstraints()`

Sets up the constraints of the password text field

``` swift
func setupPasswordTextFieldConstraints()
```

### `setupNameSeparatorViewConstraints()`

Sets up the constraints of the top orange separator

``` swift
func setupNameSeparatorViewConstraints()
```

### `setupEmailSeparatorViewConstraints()`

Sets up the constraints of the bottom orange separator

``` swift
func setupEmailSeparatorViewConstraints()
```

### `setupCameraView()`

Sets up the constraints of the Logo view

``` swift
func setupCameraView()
```

### `setupKeychainToggleLabel()`

Sets up the keychain toggle label and defines its constraints

``` swift
func setupKeychainToggleLabel()
```

### `setupKeychainToggle()`

Sets up the keychain toggle and defines its constraints

``` swift
func setupKeychainToggle()
```

### `setupSkipButton()`

Sets up the skip button and defines its constraints

``` swift
func setupSkipButton()
```

### `setupToggleRegisterLoginButton()`

Sets up the constraints of the toggle button

``` swift
func setupToggleRegisterLoginButton()
```

### `setupInfoSubmitButton()`

Sets up the constraints of the submit button

``` swift
func setupInfoSubmitButton()
```

# CreateNoteVC

This class is responsible for giving users the ability to create new notes and edit old ones.

``` swift
class CreateNoteVC: UIViewController
```

## Inheritance

`UITextFieldDelegate`, `UITextViewDelegate`, `UIViewController`

## Properties

### `note`

This is the note that will be set from the NotesVC

``` swift
var note: Note?
```

### `noteToUpdateKey`

This is where the note to be updated can be found in firebase

``` swift
var noteToUpdateKey: String?
```

### `notesConstant`

Variable for the constant "notes" for Firebase

``` swift
let notesConstant: String
```

### `userNotesConstant`

Variable for the constant "user-notes" for Firebase

``` swift
let userNotesConstant: String
```

### `backButton`

Variable for the back button to go to the previous veiw controller

``` swift
let backButton
```

### `textView`

Variable for the textview for the text of the note

``` swift
let textView
```

### `noteTitle`

Variable for the textfield that holds the title of the note

``` swift
let noteTitle
```

### `saveButton`

Save button for saving notes

``` swift
let saveButton: UIButton
```

## Methods

### `viewDidLoad()`

View did load function that calls all of the setup functions

``` swift
override func viewDidLoad()
```

### `loadNote()`

If the note already exists, loads the contents into the VC. if it does not exist, set placeholders

``` swift
func loadNote()
```

### `handleNewNote()`

Handles what happens when a new note is made

``` swift
func handleNewNote()
```

### `handleUpdateNote()`

Need to be able to overwrite an existing note

``` swift
func handleUpdateNote()
```

### `setupSaveNoteButton()`

Handles the constraints and set up of the save button

``` swift
func setupSaveNoteButton()
```

### `handleSaveNote()`

Handles what happens when a note is saved

``` swift
@objc func handleSaveNote()
```

### `toggleSaveButtonEnabled()`

Sets the save button to enabled and makes the color normal

``` swift
func toggleSaveButtonEnabled()
```

### `toggleSaveButtonDisabled()`

Sets the save button to disabled and makes the color of the bottom dim

``` swift
func toggleSaveButtonDisabled()
```

### `backButtonSetup()`

Set up for the back button and defines its constraints

``` swift
func backButtonSetup()
```

### `backButtonTapped()`

What happens when the back button is tapped, dismisses the view controller

``` swift
@objc func backButtonTapped()
```

### `noteTitleSetup()`

Sets up the note title and defines its constraints

``` swift
func noteTitleSetup()
```

### `textViewSetup()`

Sets up the main text view and defines its constraints

``` swift
func textViewSetup()
```

### `textViewDidChange(_:)`

If the text changed in the view controller, toggle the save button

``` swift
func textViewDidChange(_ textView: UITextView)
```

# User

This is used to hold the id, the name, and the email of a user. This could be the current signed in user or this could be used as a list of users. User information is pulled from Firebase and stored in this class.

``` swift
class User: NSObject
```

## Inheritance

`NSObject`

## Properties

### `id`

Unique id of the user as a string

``` swift
var id: String?
```

### `name`

Name of the user as a string

``` swift
var name: String?
```

### `email`

Email of the user as a string

``` swift
var email: String?
```

# NotesVC

This class is responsible for the main notes screen. It holds the table view of all of the users's notes as well as ways for users to create new notes and delete old ones.

``` swift
class NotesVC: UIViewController, UITableViewDataSource, UITableViewDelegate
```

## Inheritance

`UITableViewDataSource`, `UITableViewDelegate`, `UIViewController`

## Properties

### `notes`

Array of all the notes of the current user

``` swift
var notes
```

### `userNotesConstant`

Constant for the 'user-notes' node in Firebase

``` swift
let userNotesConstant: String
```

### `refreshControl`

Variable for handling the pull to refresh for the table view

``` swift
let refreshControl
```

### `topBar`

Variable for the top bar

``` swift
let topBar
```

### `topLabel`

Variable for the top label which holds the name of the feature

``` swift
let topLabel
```

### `backButton`

Variable for the back button for when the user wants to go back to the previous view controller

``` swift
let backButton
```

### `tableView`

Table view variable for holding all of the users notes

``` swift
let tableView: UITableView
```

### `createNoteButton`

Button for creating a new note

``` swift
let createNoteButton
```

### `supportedInterfaceOrientations`

Determines which interface orientations are supported

``` swift
var supportedInterfaceOrientations: UIInterfaceOrientationMask
```

### `preferredStatusBarStyle`

Change the color of the status bar

``` swift
var preferredStatusBarStyle: UIStatusBarStyle
```

## Methods

### `viewDidLoad()`

Function that gets called initially and loads all of the setup functions

``` swift
override func viewDidLoad()
```

### `refreshTableViewOnPull()`

Handles what happens when the user pulls on the table view to refresh

``` swift
@objc func refreshTableViewOnPull()
```

### `viewWillDisappear(_:)`

What happens when the view is about to disappear.

``` swift
override func viewWillDisappear(_ animated: Bool)
```

### `viewDidAppear(_:)`

This is what happens when the view did appear

``` swift
override func viewDidAppear(_ animated: Bool)
```

### `observeUserNotes()`

Function for observing notes from firebase (used to gather list of notes for user to see in their list of notes)

``` swift
func observeUserNotes()
```

### `handleDeleteNote(noteId:)`

Handles what happens when a note is to be deleted

``` swift
func handleDeleteNote(noteId: String)
```

### `handleDeleteNoteAreYouSure(noteId:indexPath:)`

Presents an alert to the user with optinons if they tried to delete a note. They can proceed with deletion or cancel it

``` swift
func handleDeleteNoteAreYouSure(noteId: String, indexPath: IndexPath)
```

### `tableView(_:numberOfRowsInSection:)`

Counts the number of items in a table view based on the size of the notes array

``` swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```

### `tableView(_:cellForRowAt:)`

Each cell in the table view gets handled here

``` swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
```

### `tableView(_:commit:forRowAt:)`

Checks if the note is trying to be deleted at a certain row in the table view

``` swift
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
```

### `tableView(_:heightForRowAt:)`

Returns the height of each row in the table view

``` swift
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
```

### `tableView(_:estimatedHeightForRowAt:)`

Returns the estimated height of each row in the table view

``` swift
func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
```

### `tableView(_:didSelectRowAt:)`

Selecting a specific row in the table view

``` swift
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
```

### `showNoteFromTableView(note:)`

When a user clicks on a note in the table view, this will get called and will send the user to the note creation/editing view controller

``` swift
func showNoteFromTableView(note: Note)
```

### `viewWillAppear(_:)`

Change the color of the status bar

``` swift
override func viewWillAppear(_ animated: Bool)
```

### `tableViewSetup()`

Set up the table view with constraints

``` swift
func tableViewSetup()
```

### `topBarSetup()`

Setting up the top bar with constraints

``` swift
func topBarSetup()
```

### `backButtonSetup()`

Sets up the back button and defines its constraints

``` swift
func backButtonSetup()
```

### `createNoteButtonSetup()`

Sets up the create note button and defines its constraints

``` swift
func createNoteButtonSetup()
```

### `createNoteButtonTapped()`

Handles the create note button being tapped

``` swift
@objc func createNoteButtonTapped()
```

### `backButtonTapped()`

Handles the back button being tapped

``` swift
@objc func backButtonTapped()
```

### `topLabelSetup()`

Sets up the top label for the name of the view controller and defines its constraints

``` swift
func topLabelSetup()
```

# ChatTableViewCell

``` swift
class ChatTableViewCell: UITableViewCell
```

## Inheritance

`UITableViewCell`

## Properties

### `sentMessageBox`

``` swift
let sentMessageBox
```

### `receivedMessageBox`

``` swift
let receivedMessageBox
```

## Methods

### `awakeFromNib()`

``` swift
override func awakeFromNib()
```

### `setSelected(_:animated:)`

``` swift
override func setSelected(_ selected: Bool, animated: Bool)
```

### `sentMessageBoxSetup()`

``` swift
func sentMessageBoxSetup()
```

# Message

This class stores information on an indivudal message from our messaging feature. Whenever a message is sent or received, it is stored in this class, typically as an array. The messages information is retrieved from Firebase and stored here when needed.

``` swift
class Message: NSObject
```

## Inheritance

`NSObject`

## Properties

### `receiverId`

This is the unique ID of the person who is receiving the message

``` swift
var receiverId: String?
```

### `senderId`

Unique ID of the person who is sending the message

``` swift
var senderId: String?
```

### `text`

The actual text of this specific message

``` swift
var text: String?
```

### `timestamp`

This is the exact time that the message was sent

``` swift
var timestamp: NSNumber?
```

## Methods

### `chatPartnerId()`

This function returns the ID of the person who is not the current user and who is the person the current user is chatting with

``` swift
func chatPartnerId() -> String?
```
# NotesTableViewCell

This class is a custom table view cell for the table view in our notes feature. It handles the constraints for each subview and also helps with some logic in setting the note information in its proper place.

``` swift
class NotesTableViewCell: UITableViewCell
```

## Inheritance

`UITableViewCell`

## Initializers

### `init(style:reuseIdentifier:)`

Function called every time this table view cell is used. It is being used to call the setup function for the subviews of this table view cell.

``` swift
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
```

### `init?(coder:)`

Required function for checking if there was a fatal error

``` swift
required init?(coder: NSCoder)
```

## Properties

### `note`

This is of type Note from our custom swift class and it helps with the logic of setting the note information in each table view cell. It sets the title, the text, and the time.

``` swift
var note: Note?
```

### `titleLabel`

A closure for the note title label

``` swift
let titleLabel: UILabel
```

### `noteLabel`

A closure for the label for the text of a note

``` swift
let noteLabel: UILabel
```

### `timestampLabel`

A closure for the label for the time a note was created

``` swift
let timestampLabel: UILabel
```

## Methods

### `setNoteLabel(_:)`

Sets the note label from the note variable

``` swift
fileprivate func setNoteLabel(_ noteText: String)
```

### `setTimestampLabel(_:)`

Sets the timestamp label from the note variable

``` swift
fileprivate func setTimestampLabel(_ milliseconds: Double)
```

### `layoutSubviews()`

Function for laying out the subviews

``` swift
override func layoutSubviews()
```

### `setupTitleLabel()`

Adds the title label to the subview and defines the constraints of the title label

``` swift
func setupTitleLabel()
```

### `setupNoteLabel()`

Adds the note label to the subview and defines the constraints of the note label

``` swift
func setupNoteLabel()
```

### `setupTimestampLabel()`

Adds the timestamp label to the subview and defines the constraints of the timestamp label

``` swift
func setupTimestampLabel()
```
# ChatVC

This class is used to show an individual chat between two users. It shows the title bar at the top with the chat partner's name, it has alll the messages between the two users, and it demonstrates our iASL keyboard in use.

``` swift
class ChatVC: UIViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
```

## Inheritance

`UICollectionViewDataSource`, `UICollectionViewDelegateFlowLayout`, `UITextViewDelegate`, `UIViewController`

## Properties

### `loginVC`

``` swift
var loginVC: LoginVC?
```

### `messagesConstant`

A constant for the "messages" node in Firebase

``` swift
let messagesConstant: String
```

### `cellId`

Constant for the cellId in the collectionview

``` swift
let cellId
```

### `chatPartner`

Chat Partner of Type User from our swift classes. Used to get the name of the chat partner for the top bar

``` swift
var chatPartner: User?
```

### `messages`

Array of type Message from our swift classes that holds all of the messages observed from Firebase

``` swift
var messages
```

### `composedMessage`

This is the message that is typed in the input box by the user

``` swift
let composedMessage
```

### `topBar`

This is the top bar that holds the user's name and has our navigation back button

``` swift
let topBar
```

### `topLabel`

The label that holds the name of the chat partner

``` swift
let topLabel
```

### `backButton`

The button for going back to the previous view, which is the list of active chats

``` swift
let backButton
```

### `sendButton`

Button to be clicked by the user to send a message

``` swift
let sendButton
```

### `keyboardButton`

Button used to switch between the iASL keyboard and the standard Apple Keyboard

``` swift
let keyboardButton
```

### `collectionView`

This is the collection view that holds all of the messages sent between two users

``` swift
let collectionView: UICollectionView
```

### `preferredStatusBarStyle`

Change the color of the status bar

``` swift
var preferredStatusBarStyle: UIStatusBarStyle
```

## Methods

### `viewDidLoad()`

Function called when the view loads. Used to setup all of the important structural parts of the view controller.

``` swift
override func viewDidLoad()
```

### `keyboardWillShow(notification:)`

Called when the keyboard is about to show

``` swift
@objc func keyboardWillShow(notification: NSNotification)
```

### `keyboardWillHide(notification:)`

Called when the keyboard is abouot to hide

``` swift
@objc func keyboardWillHide(notification: NSNotification)
```

### `test()`

``` swift
func test() -> Bool
```

### `observeMessages()`

Observes messages from Firebase and loads them into an array of type Message to be used by the collectionview. Has logic for determining which messages were from the sender and which were from the receiver

``` swift
func observeMessages() -> Bool
```

### `collectionViewSetup()`

Adds the collection view to the subview and defines the important aspects of the collection view

``` swift
func collectionViewSetup()
```

### `collectionView(_:numberOfItemsInSection:)`

Returns the number of messages so the collection view knows how many cells to load

``` swift
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
```

### `collectionView(_:cellForItemAt:)`

Defines what happens at each cell in the collection view. This is where our custom collection view cell comes in handy.

``` swift
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
```

### `setupCell(cell:message:)`

This function determines what the chat bubble is going to look like. If it is a sender message, it will be pink and on the right side of the collection view. If it is an incoming message, it will be gray and on the left side of the collection view.

``` swift
func setupCell(cell: ChatMessageCell, message: Message)
```

### `collectionView(_:layout:sizeForItemAt:)`

Determines the height of each cell in the collection view

``` swift
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
```

### `estimateFrameForText(text:)`

Estimates the frame for the text in the cell

``` swift
private func estimateFrameForText(text: String) -> CGRect
```

### `handleSendButton()`

Handles what happens when you send a message

``` swift
@objc func handleSendButton()
```

### `sendButtonSetup()`

Sets up the send button in the subveiw and defines its constraints and important features

``` swift
func sendButtonSetup()
```

### `composedMessageSetup()`

Sets up the composed message text view and defines its constraints and important features

``` swift
func composedMessageSetup()
```

### `topBarSetup()`

Adds the top bar to the subview and defines how it is supposed to look

``` swift
func topBarSetup()
```

### `backButtonSetup()`

Adds the back button to the top bar subview and defines what it looks like

``` swift
func backButtonSetup()
```

### `backButtonTapped()`

Handles what happens when the back button is tapped

``` swift
@objc func backButtonTapped()
```

### `topLabelSetup()`

Adds the top label for the name of the chat partner to the top bar subview and defines what the label looks like

``` swift
func topLabelSetup()
```

### `keybaordButtonSetup()`

``` swift
func keybaordButtonSetup()
```

### `keyboardButtonTapped()`

Handles what happens when the keyboard button is tapped. Handles logic for switching between different keyboards

``` swift
@objc func keyboardButtonTapped()
```

### `handleLoginForTesting(email:password:)`

Handles what happens when the user logins in with an existing account. For signing in during testing

``` swift
func handleLoginForTesting(email: String, password: String)
```

### `viewWillAppear(_:)`

Change the color of the status bar

``` swift
override func viewWillAppear(_ animated: Bool)
```

### `viewWillDisappear(_:)`

<dl>
<dt><code>!targetEnvironment(simulator)</code></dt>
<dd>

``` swift
override func viewWillDisappear(_ animated: Bool)
```

</dd>
</dl>

# ChatMessageCell

This is a custom cell for the collection view we use in the chat view contoller. It creates and handles the bubbles for each message sent and received and their location on the view.

``` swift
class ChatMessageCell: UICollectionViewCell
```

## Inheritance

`UICollectionViewCell`

## Initializers

### `init(frame:)`

This is called each time the collection view cell is used. It is being used to call the set up functions for the message bubbles and the text view that holds the text

``` swift
override init(frame: CGRect)
```

### `init?(coder:)`

Required function for checking if there is a fatal error

``` swift
required init?(coder: NSCoder)
```

## Properties

### `bubbleViewWidthAnchor`

Reference variable for the message bubble view's width anchor. Helpful for later changing the bubble from a pink sender to a gray receiver message.

``` swift
var bubbleViewWidthAnchor: NSLayoutConstraint?
```

### `bubbleViewRightAnchor`

Reference variable for the messaging bubble view's right anchor. Helpful for later changing the bubble from a pink sender to a gray receiver message.

``` swift
var bubbleViewRightAnchor: NSLayoutConstraint?
```

### `bubbleViewLeftAnchor`

Reference variable for the messaging bubble view's left anchor. Helpful for later changing the bubble from a pink sender to a gray receiver message.

``` swift
var bubbleViewLeftAnchor: NSLayoutConstraint?
```

### `textView`

This is the textview that holds the actual text of a message sent or received

``` swift
let textView: UITextView
```

### `bubbleView`

This is a custom view closure that shapes the message bubbles

``` swift
let bubbleView: UIView
```

## Methods

### `bubbleViewSetup()`

Adds the bubble view to the subview and sets the constraints for the bubble view

``` swift
func bubbleViewSetup()
```

### `textViewSetup()`

Adds the text view to the subview and defines the constraints for the text view

``` swift
func textViewSetup()
```
