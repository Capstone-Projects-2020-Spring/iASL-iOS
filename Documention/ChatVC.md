# ChatVC

This class is used to show an individual chat between two users. It shows the title bar at the top with the chat partner's name, it has alll the messages between the two users, and it demonstrates our iASL keyboard in use.

``` swift
class ChatVC: UIViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
```

## Inheritance

`UICollectionViewDataSource`, `UICollectionViewDelegateFlowLayout`, `UITextViewDelegate`, `UIViewController`

## Properties

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

### `observeMessages()`

Observes messages from Firebase and loads them into an array of type Message to be used by the collectionview. Has logic for determining which messages were from the sender and which were from the receiver

``` swift
func observeMessages()
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
