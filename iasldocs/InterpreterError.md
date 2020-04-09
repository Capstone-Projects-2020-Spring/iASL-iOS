# InterpreterError

Errors thrown by the TensorFlow Lite `Interpreter`.

``` swift
public enum InterpreterError
```

## Inheritance

`CustomStringConvertible`, `Equatable`, `Error`, `Hashable`, `LocalizedError`

## Enumeration Cases

## invalidTensorIndex

``` swift
case invalidTensorIndex(index: Int, maxIndex: Int)
```

## invalidTensorDataCount

``` swift
case invalidTensorDataCount(provided: Int, required: Int)
```

## invalidTensorDataType

``` swift
case invalidTensorDataType
```

## failedToLoadModel

``` swift
case failedToLoadModel
```

## failedToCreateInterpreter

``` swift
case failedToCreateInterpreter
```

## failedToResizeInputTensor

``` swift
case failedToResizeInputTensor(index: Int)
```

## failedToCopyDataToInputTensor

``` swift
case failedToCopyDataToInputTensor
```

## failedToAllocateTensors

``` swift
case failedToAllocateTensors
```

## allocateTensorsRequired

``` swift
case allocateTensorsRequired
```

## invokeInterpreterRequired

``` swift
case invokeInterpreterRequired
```

## tensorFlowLiteError

``` swift
case tensorFlowLiteError(: String)
```

## Properties

## errorDescription

A localized description of the interpreter error.

``` swift
var errorDescription: String?
```

## description

A textual representation of the TensorFlow Lite interpreter error.

``` swift
var description: String
```
