# ExplicitNull.ExplicitNull.ExplicitNull.ExplicitNull.Swift4ExplicitNull

<dl>
<dt><code>compiler(>=5.1)</code></dt>
<dd>

A compatibility version of `ExplicitNull` that does not use property
wrappers, suitable for use in older versions of Swift.

``` swift
@available(swift, deprecated: 5.1) public enum Swift4ExplicitNull<Wrapped>
```

Wraps an `Optional` field in a `Codable` object such that when the field
has a `nil` value it will encode to a null value in Firestore. Normally,
optional fields are omitted from the encoded document.

This is useful for ensuring a field is present in a Firestore document,
even when there is no associated value.

</dd>
</dl>
