# DocumentIDWrappable

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

A type that can initialize itself from a Firestore `DocumentReference`,
which makes it suitable for use with the `@DocumentID` property wrapper.

``` swift
public protocol DocumentIDWrappable
```

Firestore includes extensions that make `String` and `DocumentReference`
conform to `DocumentIDWrappable`.

Note that Firestore ignores fields annotated with `@DocumentID` when writing
so there is no requirement to convert from the wrapped type back to a
`DocumentReference`.

</dd>
</dl>

## Requirements

## wrap(\_:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

Creates a new instance by converting from the given `DocumentReference`.

``` swift
static func wrap(_ documentReference: DocumentReference) throws -> Self
```

</dd>
</dl>

## wrap(\_:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public static func wrap(_ documentReference: DocumentReference) throws -> Self
```

</dd>
</dl>

## wrap(\_:)

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

``` swift
public static func wrap(_ documentReference: DocumentReference) throws -> Self
```

</dd>
</dl>
