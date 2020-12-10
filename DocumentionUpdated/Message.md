# Message

This class stores information on an indivudal message from our messaging feature. Whenever a message is sent or received, it is stored in this class, typically as an array. The messages information is retrieved from Firebase and stored here when needed.

``` swift
class Message: NSObject
```

## Inheritance

`NSObject`

## Properties

### `receiverId`

This is the unique ID of the person who is receiving the message

``` swift
var receiverId: String?
```

### `senderId`

Unique ID of the person who is sending the message

``` swift
var senderId: String?
```

### `text`

The actual text of this specific message

``` swift
var text: String?
```

### `timestamp`

This is the exact time that the message was sent

``` swift
var timestamp: NSNumber?
```

## Methods

### `chatPartnerId()`

This function returns the ID of the person who is not the current user and who is the person the current user is chatting with

``` swift
func chatPartnerId() -> String?
```
