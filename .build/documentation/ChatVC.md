# ChatVC

``` swift
class ChatVC: UIViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
```

## Inheritance

`UICollectionViewDataSource`, `UICollectionViewDelegateFlowLayout`, `UITextViewDelegate`, `UIViewController`

## Properties

### `composedMessage`

``` swift
let composedMessage
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

### `sendButton`

``` swift
let sendButton
```

### `keyboardButton`

``` swift
let keyboardButton
```

### `messagesConstant`

``` swift
let messagesConstant: String
```

### `chatPartner`

``` swift
var chatPartner: User?
```

### `messages`

``` swift
var messages
```

### `tempMessages`

``` swift
var tempMessages
```

### `tempMessage1`

``` swift
var tempMessage1
```

### `tempMessage2`

``` swift
var tempMessage2
```

### `tempMessage3`

``` swift
var tempMessage3
```

### `tempMessage4`

``` swift
var tempMessage4
```

### `cellId`

``` swift
let cellId
```

### `collectionView`

``` swift
let collectionView: UICollectionView
```

### `preferredStatusBarStyle`

``` swift
var preferredStatusBarStyle: UIStatusBarStyle
```

## Methods

### `loadTempMessage()`

``` swift
func loadTempMessage()
```

### `viewDidLoad()`

``` swift
override func viewDidLoad()
```

### `keyboardWillShow(notification:)`

``` swift
@objc func keyboardWillShow(notification: NSNotification)
```

### `keyboardWillHide(notification:)`

``` swift
@objc func keyboardWillHide(notification: NSNotification)
```

### `observeMessages()`

``` swift
func observeMessages()
```

### `collectionViewSetup()`

``` swift
func collectionViewSetup()
```

### `collectionView(_:numberOfItemsInSection:)`

``` swift
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
```

### `collectionView(_:cellForItemAt:)`

``` swift
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
```

### `setupCell(cell:message:)`

``` swift
func setupCell(cell: ChatMessageCell, message: Message)
```

### `collectionView(_:layout:sizeForItemAt:)`

``` swift
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
```

### `estimateFrameForText(text:)`

``` swift
private func estimateFrameForText(text: String) -> CGRect
```

### `viewWillAppear(_:)`

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

### `handleSendButton()`

handles what happens when you send a message

``` swift
@objc func handleSendButton()
```

### `sendButtonSetup()`

``` swift
func sendButtonSetup()
```

### `composedMessageSetup()`

``` swift
func composedMessageSetup()
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

### `keybaordButtonSetup()`

``` swift
func keybaordButtonSetup()
```

### `keyboardButtonTapped()`

``` swift
@objc func keyboardButtonTapped()
```
