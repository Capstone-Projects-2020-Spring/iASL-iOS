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
