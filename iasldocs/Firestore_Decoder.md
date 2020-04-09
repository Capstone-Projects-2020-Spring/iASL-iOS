# Firestore.Decoder

``` swift
public struct Decoder
```

## Initializers

## init()

``` swift
public init()
```

## Methods

## decode(\_:from:in:)

Returns an instance of specified type from a Firestore document.

``` swift
public func decode<T: Decodable>(_: T.Type, from container: [String: Any], in document: DocumentReference? = nil) throws -> T
```

If exists in `container`, Firestore specific types are recognized, and
passed through to `Decodable` implementations. This means types below
in `container` are directly supported:

### Parameters

  - container: A Map keyed of String representing a Firestore document.
  - document: A reference to the Firestore Document that is being decoded.

### Returns

An instance of specified type by the first parameter.
