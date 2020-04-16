# ExplicitNull

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

Wraps an `Optional` field in a `Codable` object such that when the field
has a `nil` value it will encode to a null value in Firestore. Normally,
optional fields are omitted from the encoded document.

``` swift
@propertyWrapper public struct ExplicitNull<Value>
```

This is useful for ensuring a field is present in a Firestore document,
even when there is no associated value.

</dd>
</dl>

## Inheritance

`Decodable`, `Encodable`, `Equatable`

## Initializers

## init(wrappedValue:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public init(wrappedValue value: Value?)
```

</dd>
</dl>

## Properties

## wrappedValue

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
var wrappedValue: Value?
```

</dd>
</dl>
