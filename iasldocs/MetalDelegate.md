# MetalDelegate

A delegate that uses the `Metal` framework for performing TensorFlow Lite graph operations with
GPU acceleration.

``` swift
public final class MetalDelegate: Delegate
```

> Important: This is an experimental interface that is subject to change.

## Inheritance

[`Delegate`](Delegate)

## Enumeration Cases

## none

The thread does not wait for the work to complete. Useful when the output of the work is used
with the GPU pipeline.

``` swift
case none
```

## passive

The thread waits until the work is complete.

``` swift
case passive
```

## active

The thread waits for the work to complete with minimal latency, which may require additional
CPU resources.

``` swift
case active
```

## aggressive

The thread waits for the work while trying to prevent the GPU from going into sleep mode.

``` swift
case aggressive
```

## Initializers

## init(options:)

Creates a new instance configured with the given `options`.

``` swift
public init(options: Options = Options())
```

### Parameters

  - options: Configurations for the delegate. The default is a new instance of `MetalDelegate.Options` with the default configuration values.

## init()

Creates a new instance with the default values.

``` swift
public init()
```

## Properties

## options

The configuration options for the `MetalDelegate`.

``` swift
let options: Options
```

## cDelegate

``` swift
var cDelegate: CDelegate
```

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
