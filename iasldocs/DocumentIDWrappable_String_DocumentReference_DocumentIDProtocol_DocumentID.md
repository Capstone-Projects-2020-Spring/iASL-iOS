# DocumentIDWrappable.String.DocumentReference.DocumentIDProtocol.DocumentID

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

A value that is populated in Codable objects with the `DocumentReference`
of the current document by the Firestore.Decoder when a document is read.

``` swift
@propertyWrapper public struct DocumentID<Value: DocumentIDWrappable & Codable & Equatable>: DocumentIDProtocol, Codable, Equatable
```

If the field name used for this type conflicts with a read document field,
an error is thrown. For example, if a custom object has a field `firstName`
annotated with `@DocumentID`, and there is a property from the document
named `firstName` as well, an error is thrown when you try to read the
document.

When writing a Codable object containing an `@DocumentID` annotated field,
its value is ignored. This allows you to read a document from one path and
write it into another without adjusting the value here.

NOTE: Trying to encode/decode this type using encoders/decoders other than
Firestore.Encoder leads to an error.

</dd>
</dl>

## Inheritance

`Codable`, `DocumentIDProtocol`, `Equatable`

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
public init(from documentReference: DocumentReference?) throws
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

## \==(lhs:rhs:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public static func ==(lhs: DocumentID<Value>, rhs: DocumentID<Value>) -> Bool
```

</dd>
</dl>
