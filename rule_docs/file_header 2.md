# File Header

Header comments should be consistent with project patterns. The SWIFTLINT_CURRENT_FILENAME placeholder can optionally be used in the required and forbidden patterns. It will be replaced by the real file name.

* **Identifier:** file_header
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, required_string: None, required_pattern: None, forbidden_string: None, forbidden_pattern: None

## Non Triggering Examples

```swift
let foo = "Copyright"
```

```swift
let foo = 2 // Copyright
```

```swift
let foo = 2
 // Copyright
```

## Triggering Examples

```swift
// ↓Copyright

```

```swift
//
// ↓Copyright
```

```swift
//
//  FileHeaderRule.swift
//  SwiftLint
//
//  Created by Marcelo Fabri on 27/11/16.
//  ↓Copyright © 2016 Realm. All rights reserved.
//
```