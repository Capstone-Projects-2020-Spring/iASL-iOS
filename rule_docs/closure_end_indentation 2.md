# Closure End Indentation

Closure end should have the same indentation as the line that started it.

* **Identifier:** closure_end_indentation
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
SignalProducer(values: [1, 2, 3])
   .startWithNext { number in
       print(number)
   }

```

```swift
[1, 2].map { $0 + 1 }

```

```swift
return match(pattern: pattern, with: [.comment]).flatMap { range in
   return Command(string: contents, range: range)
}.flatMap { command in
   return command.expand()
}

```

```swift
foo(foo: bar,
    options: baz) { _ in }

```

```swift
someReallyLongProperty.chainingWithAnotherProperty
   .foo { _ in }
```

```swift
foo(abc, 123)
{ _ in }

```

```swift
function(
    closure: { x in
        print(x)
    },
    anotherClosure: { y in
        print(y)
    })
```

```swift
function(parameter: param,
         closure: { x in
    print(x)
})
```

```swift
function(parameter: param, closure: { x in
        print(x)
    },
    anotherClosure: { y in
        print(y)
    })
```

## Triggering Examples

```swift
SignalProducer(values: [1, 2, 3])
   .startWithNext { number in
       print(number)
↓}

```

```swift
return match(pattern: pattern, with: [.comment]).flatMap { range in
   return Command(string: contents, range: range)
   ↓}.flatMap { command in
   return command.expand()
↓}

```

```swift
function(
    closure: { x in
        print(x)
↓},
    anotherClosure: { y in
        print(y)
↓})
```