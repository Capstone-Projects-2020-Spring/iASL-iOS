# NotesVC

``` swift
class NotesVC: UIViewController, UITableViewDataSource, UITableViewDelegate
```

## Inheritance

`UITableViewDataSource`, `UITableViewDelegate`, `UIViewController`

## Properties

### `testNotes`

``` swift
var testNotes
```

### `notes`

``` swift
var notes
```

### `userNotesConstant`

``` swift
let userNotesConstant: String
```

### `refreshControl`

``` swift
let refreshControl
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
let tableView: UITableView
```

### `createNoteButton`

``` swift
let createNoteButton
```

### `supportedInterfaceOrientations`

``` swift
var supportedInterfaceOrientations: UIInterfaceOrientationMask
```

### `preferredStatusBarStyle`

``` swift
var preferredStatusBarStyle: UIStatusBarStyle
```

## Methods

### `setupFakeNotes()`

``` swift
func setupFakeNotes()
```

### `viewDidLoad()`

``` swift
override func viewDidLoad()
```

### `refreshTableViewOnPull()`

``` swift
@objc func refreshTableViewOnPull()
```

### `viewWillDisappear(_:)`

``` swift
override func viewWillDisappear(_ animated: Bool)
```

### `viewDidAppear(_:)`

``` swift
override func viewDidAppear(_ animated: Bool)
```

### `observeUserNotes()`

function for observing notes from firebase (used to gather list of notes for user to see in their list of notes)

``` swift
func observeUserNotes()
```

### `handleDeleteNote(noteId:)`

``` swift
func handleDeleteNote(noteId: String)
```

### `handleDeleteNoteAreYouSure(noteId:indexPath:)`

``` swift
func handleDeleteNoteAreYouSure(noteId: String, indexPath: IndexPath)
```

### `tableView(_:numberOfRowsInSection:)`

counts the number of items in a table view

``` swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```

### `tableView(_:cellForRowAt:)`

each cell in the table view

``` swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
```

### `tableView(_:commit:forRowAt:)`

``` swift
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
```

### `tableView(_:heightForRowAt:)`

``` swift
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
```

### `tableView(_:estimatedHeightForRowAt:)`

``` swift
func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
```

### `tableView(_:didSelectRowAt:)`

selecting a specific row in the table view

``` swift
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
```

### `showNoteFromTableView(note:)`

``` swift
func showNoteFromTableView(note: Note)
```

### `viewWillAppear(_:)`

change the color of the status bar

``` swift
override func viewWillAppear(_ animated: Bool)
```

### `tableViewSetup()`

set up the table view with constraints and such

``` swift
func tableViewSetup()
```

### `topBarSetup()`

setting up the top bar with constraints and such

``` swift
func topBarSetup()
```

### `backButtonSetup()`

set up the back button

``` swift
func backButtonSetup()
```

### `createNoteButtonSetup()`

set up the create note button

``` swift
func createNoteButtonSetup()
```

### `createNoteButtonTapped()`

handles the create note button being tapped

``` swift
@objc func createNoteButtonTapped()
```

### `backButtonTapped()`

handles the back button being tapped

``` swift
@objc func backButtonTapped()
```

### `topLabelSetup()`

sets up the top label for the name of the view controller

``` swift
func topLabelSetup()
```
