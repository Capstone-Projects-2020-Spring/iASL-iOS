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
