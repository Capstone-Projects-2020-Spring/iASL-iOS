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
