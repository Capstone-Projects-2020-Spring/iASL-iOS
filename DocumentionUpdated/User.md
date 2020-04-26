# User

This is used to hold the id, the name, and the email of a user. This could be the current signed in user or this could be used as a list of users. User information is pulled from Firebase and stored in this class.

``` swift
class User: NSObject
```

## Inheritance

`NSObject`

## Properties

### `id`

Unique id of the user as a string

``` swift
var id: String?
```

### `name`

Name of the user as a string

``` swift
var name: String?
```

### `email`

Email of the user as a string

``` swift
var email: String?
```
