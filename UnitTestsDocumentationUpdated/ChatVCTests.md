# ChatVCTests

``` swift
class ChatVCTests: XCTestCase
```

## Inheritance

`XCTestCase`

## Properties

### `email`

``` swift
let email
```

### `password`

``` swift
let password
```

### `uid`

``` swift
let uid
```

### `remote`

``` swift
var remote: RemoteConversationVC?
```

### `login`

``` swift
var login: LoginVC?
```

### `message`

``` swift
var message: Message?
```

## Methods

### `setUp()`

``` swift
override func setUp()
```

### `tearDown()`

``` swift
override class func tearDown()
```

### `testObserveMessagesSucceeds()`

Checks if the observe message function is successful in calling by looking for a boolean representing success as a result

``` swift
func testObserveMessagesSucceeds()
```

### `testObserveMessagesFails()`

Checks if the observe message function fails as a result of the user not being signed in by looking for a boolean representing success as a result

``` swift
func testObserveMessagesFails()
```
