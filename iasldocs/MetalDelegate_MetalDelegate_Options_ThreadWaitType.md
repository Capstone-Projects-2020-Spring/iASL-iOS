# MetalDelegate.MetalDelegate.Options.ThreadWaitType

A type indicating how the current thread should wait for work scheduled on the GPU to complete.

``` swift
public enum ThreadWaitType
```

## Inheritance

`Equatable`, `Hashable`

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
