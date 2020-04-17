# CreateNoteVC

``` swift
class CreateNoteVC: UIViewController
```

## Inheritance

`UITextFieldDelegate`, `UITextViewDelegate`, `UIViewController`

## Properties

### `note`

``` swift
var note: Note?
```

### `noteToUpdateKey`

``` swift
var noteToUpdateKey: String?
```

### `notesConstant`

``` swift
let notesConstant: String
```

### `userNotesConstant`

``` swift
let userNotesConstant: String
```

### `backButton`

``` swift
let backButton
```

### `textView`

``` swift
let textView
```

### `noteTitle`

``` swift
let noteTitle
```

### `saveButton`

save button for saving notes

``` swift
let saveButton: UIButton
```

## Methods

### `viewDidLoad()`

``` swift
override func viewDidLoad()
```

### `loadNote()`

if the note already exists, loads the contents into the VC. if it does not exist, set placeholders

``` swift
func loadNote()
```

### `handleSaveNote()`

handles what happens when a note is saved

``` swift
@objc func handleSaveNote()
```

### `handleNewNote()`

handles what happens when a new note is made

``` swift
func handleNewNote()
```

### `handleUpdateNote()`

need to be able to overwrite an existing note

``` swift
func handleUpdateNote()
```

### `setupSaveNoteButton()`

handles the constraints and set up of the save button

``` swift
func setupSaveNoteButton()
```

### `toggleSaveButtonEnabled()`

sets the save button to enabled and makes the color normal

``` swift
func toggleSaveButtonEnabled()
```

### `toggleSaveButtonDisabled()`

sets the save button to disabled and makes the color of the bottom dim

``` swift
func toggleSaveButtonDisabled()
```

### `backButtonSetup()`

set up for the back button

``` swift
func backButtonSetup()
```

### `backButtonTapped()`

what happens when the back button is tapped, dismisses the view controller

``` swift
@objc func backButtonTapped()
```

### `noteTitleSetup()`

sets up the note title

``` swift
func noteTitleSetup()
```

### `textViewSetup()`

sets up the main text view

``` swift
func textViewSetup()
```

### `textViewDidChange(_:)`

if the text changed in the view controller, toggle the save button

``` swift
func textViewDidChange(_ textView: UITextView)
```
