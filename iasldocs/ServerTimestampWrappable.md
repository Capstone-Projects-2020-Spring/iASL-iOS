# ServerTimestampWrappable

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

A type that can initialize itself from a Firestore Timestamp, which makes
it suitable for use with the `@ServerTimestamp` property wrapper.

``` swift
public protocol ServerTimestampWrappable
```

Firestore includes extensions that make `Timestamp`, `Date`, and `NSDate`
conform to `ServerTimestampWrappable`.

</dd>
</dl>

## Requirements

## wrap(\_:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

Creates a new instance by converting from the given `Timestamp`.

``` swift
static func wrap(_ timestamp: Timestamp) throws -> Self
```

### Parameters

  - timestamp: The timestamp from which to convert.

</dd>
</dl>

## unwrap(\_:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

Converts this value into a Firestore `Timestamp`.

``` swift
static func unwrap(_ value: Self) throws -> Timestamp
```

### Returns

A `Timestamp` representation of this value.

</dd>
</dl>

## wrap(\_:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public static func wrap(_ timestamp: Timestamp) throws -> Self
```

</dd>
</dl>

## unwrap(\_:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public static func unwrap(_ value: Self) throws -> Timestamp
```

</dd>
</dl>

## wrap(\_:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public static func wrap(_ timestamp: Timestamp) throws -> Self
```

</dd>
</dl>

## unwrap(\_:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public static func unwrap(_ value: NSDate) throws -> Timestamp
```

</dd>
</dl>

## wrap(\_:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public static func wrap(_ timestamp: Timestamp) throws -> Self
```

</dd>
</dl>

## unwrap(\_:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public static func unwrap(_ value: Timestamp) throws -> Timestamp
```

</dd>
</dl>

## ServerTimestamp

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
