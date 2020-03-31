# Required Enum Case

Enums conforming to a specified protocol must implement a specific case(s).

* **Identifier:** required_enum_case
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** No protocols configured.  In config add 'required_enum_case' to 'opt_in_rules' and config using :

'required_enum_case:
  {Protocol Name}:
    {Case Name}:{warning|error}
    {Case Name}:{warning|error}


## Non Triggering Examples

```swift
enum MyNetworkResponse: String, NetworkResponsable {
    case success, error, notConnected
}
```

```swift
enum MyNetworkResponse: String, NetworkResponsable {
    case success, error, notConnected(error: Error)
}
```

```swift
enum MyNetworkResponse: String, NetworkResponsable {
    case success
    case error
    case notConnected
}
```

```swift
enum MyNetworkResponse: String, NetworkResponsable {
    case success
    case error
    case notConnected(error: Error)
}
```

## Triggering Examples

```swift
enum MyNetworkResponse: String, NetworkResponsable {
    case success, error
}
```

```swift
enum MyNetworkResponse: String, NetworkResponsable {
    case success, error
}
```

```swift
enum MyNetworkResponse: String, NetworkResponsable {
    case success
    case error
}
```

```swift
enum MyNetworkResponse: String, NetworkResponsable {
    case success
    case error
}
```