# ServerTimestampWrappable.Date.NSDate.Timestamp.ServerTimestamp

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

A property wrapper that marks an `Optional<Timestamp>` field to be
populated with a server timestamp. If a `Codable` object being written
contains a `nil` for an `@ServerTimestamp`-annotated field, it will be
replaced with `FieldValue.serverTimestamp()` as it is sent.

``` swift
@propertyWrapper public struct ServerTimestamp<Value>: Codable, Equatable where Value: ServerTimestampWrappable & Codable & Equatable
```

Example:

``` 
struct CustomModel {
  @ServerTimestamp var ts: Timestamp?
}
```

Then writing `CustomModel(ts: nil)` will tell server to fill `ts` with
current timestamp.

</dd>
</dl>

## Inheritance

`Codable`, `Equatable`

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

## init(from:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public init(from decoder: Decoder) throws
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

## Methods

## encode(to:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public func encode(to encoder: Encoder) throws
```

</dd>
</dl>
