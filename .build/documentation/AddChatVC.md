# AddChatVC

``` swift
class AddChatVC: UIViewController
```

## Inheritance

`UIViewController`

## Properties

### `cellId`

``` swift
let cellId
```

### `usersConstant`

``` swift
let usersConstant: String
```

### `users`

``` swift
var users
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

### `remoteConversations`

reference variable so we can transition into chatVC via remote conversations

``` swift
var remoteConversations: RemoteConversationVC?
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

### `getUsers()`

gets all of the users from the database

``` swift
func getUsers()
```

### `tableView(_:numberOfRowsInSection:)`

``` swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```

### `tableView(_:cellForRowAt:)`

``` swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
```

### `tableView(_:didSelectRowAt:)`

``` swift
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
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
