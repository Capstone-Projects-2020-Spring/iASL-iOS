# Interpreter.Interpreter.Options

Options for configuring the `Interpreter`.

``` swift
public struct Options: Equatable, Hashable
```

## Inheritance

`Equatable`, `Hashable`

## Nested Type Aliases

## InterpreterOptions

A type alias for `Interpreter.Options` to support backwards compatiblity with the deprecated
`InterpreterOptions` struct.

``` swift
@available(*, deprecated, renamed: "Interpreter.Options") public typealias InterpreterOptions = Interpreter.Options
```

## Initializers

## init()

Creates a new instance with the default values.

``` swift
public init()
```

## Properties

## threadCount

The maximum number of CPU threads that the interpreter should run on. The default is `nil`
indicating that the `Interpreter` will decide the number of threads to use.

``` swift
var threadCount: Int? = nil
```
