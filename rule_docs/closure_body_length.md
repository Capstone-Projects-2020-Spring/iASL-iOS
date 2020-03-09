# Closure Body Length

Closure bodies should not span too many lines.

* **Identifier:** closure_body_length
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** metrics
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 4.2.0
* **Default configuration:** warning: 20, error: 100

## Non Triggering Examples

```swift
foo.bar { $0 }
```

```swift
foo.bar { toto in
}
```

```swift
foo.bar { toto in
	let a = 0
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	
	
	
	
	
	
	
	
	
	
}
```

```swift
foo.bar { toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
}
```

```swift
foo.bar { toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	
	
	
	
	
	
	
	
	
	
}
```

```swift
foo.bar({ toto in
})
```

```swift
foo.bar({ toto in
	let a = 0
})
```

```swift
foo.bar({ toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
})
```

```swift
foo.bar(label: { toto in
})
```

```swift
foo.bar(label: { toto in
	let a = 0
})
```

```swift
foo.bar(label: { toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
})
```

```swift
foo.bar(label: { toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
}, anotherLabel: { toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
})
```

```swift
foo.bar(label: { toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
}) { toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
}
```

```swift
let foo: Bar = { toto in
	let bar = Bar()
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	return bar
}()
```

## Triggering Examples

```swift
foo.bar ↓{ toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
}
```

```swift
foo.bar ↓{ toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	// toto
	
	
	
	
	
	
	
	
	
	
}
```

```swift
foo.bar(↓{ toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
})
```

```swift
foo.bar(label: ↓{ toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
})
```

```swift
foo.bar(label: ↓{ toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
}, anotherLabel: ↓{ toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
})
```

```swift
foo.bar(label: ↓{ toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
}) ↓{ toto in
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
}
```

```swift
let foo: Bar = ↓{ toto in
	let bar = Bar()
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	let a = 0
	return bar
}()
```