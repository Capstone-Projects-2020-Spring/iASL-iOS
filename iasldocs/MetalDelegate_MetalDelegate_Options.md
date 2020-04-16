# MetalDelegate.MetalDelegate.Options

Options for configuring the `MetalDelegate`.

``` swift
public struct Options: Equatable, Hashable
```

## Inheritance

`Equatable`, `Hashable`

## Initializers

## init()

Creates a new instance with the default values.

``` swift
public init()
```

## Properties

## allowsPrecisionLoss

Indicates whether the GPU delegate allows precision loss, such as allowing `Float16`
precision for a `Float32` computation. The default is `false`.

``` swift
var allowsPrecisionLoss = false
```

## waitType

A type indicating how the current thread should wait for work on the GPU to complete. The
default is `passive`.

``` swift
var waitType: ThreadWaitType = .passive
```
