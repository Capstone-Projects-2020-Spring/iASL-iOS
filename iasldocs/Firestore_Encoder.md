# Firestore.Encoder

``` swift
public struct Encoder
```

## Initializers

## init()

``` swift
public init()
```

## Methods

## encode(\_:)

Returns encoded data that Firestore API recognizes.

``` swift
public func encode<T: Encodable>(_ value: T) throws -> [String: Any]
```

If possible, all types will be converted to compatible types Firestore
can handle. This means certain Firestore specific types will be encoded
as pass-through: this encoder will only pass those types along since that
is what Firestore can handle. The same types will be encoded differently
with other encoders (for example: JSONEncoder).

The Firestore pass-through types are:

### Parameters

  - value: The Encodable object to convert to encoded data.

### Returns

A Map keyed by String representing a document Firestore API can work with.
