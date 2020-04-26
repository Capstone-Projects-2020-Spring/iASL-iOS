# MessageTests

``` swift
class MessageTests: XCTestCase
```

## Inheritance

`XCTestCase`

## Properties

### `partner`

``` swift
let partner
```

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
override func tearDown()
```

### `testChatPartnerIsReceiver()`

Will check if the chat partner is the receiver. Output is equal chat partner IDs

``` swift
func testChatPartnerIsReceiver()
```

### `testChatPartnerIsSender()`

Will check if the chat partner is the sender. Output is equal chat partner IDs

``` swift
func testChatPartnerIsSender()
```
