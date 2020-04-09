# Interpreter

A TensorFlow Lite interpreter that performs inference from a given model.

``` swift
public final class Interpreter
```

## Nested Type Aliases

## InterpreterOptions

A type alias for `Interpreter.Options` to support backwards compatiblity with the deprecated
`InterpreterOptions` struct.

``` swift
@available(*, deprecated, renamed: "Interpreter.Options") public typealias InterpreterOptions = Interpreter.Options
```

## Initializers

## init(modelPath:options:delegates:)

Creates a new instance with the given values.

``` swift
public init(modelPath: String, options: Options? = nil, delegates: [Delegate]? = nil) throws
```

### Parameters

  - modelPath: The local file path to a TensorFlow Lite model.
  - options: Configurations for the `Interpreter`. The default is `nil` indicating that the `Interpreter` will determine the configuration options.
  - delegate: `Array` of `Delegate`s for the `Interpreter` to use to peform graph operations. The default is `nil`.

### Throws

An error if the model could not be loaded or the interpreter could not be created.

## init()

Creates a new instance with the default values.

``` swift
public init()
```

## Properties

## options

The configuration options for the `Interpreter`.

``` swift
let options: Options?
```

## delegates

An `Array` of `Delegate`s for the `Interpreter` to use to perform graph operations.

``` swift
let delegates: [Delegate]?
```

## inputTensorCount

The total number of input `Tensor`s associated with the model.

``` swift
var inputTensorCount: Int
```

## outputTensorCount

The total number of output `Tensor`s associated with the model.

``` swift
var outputTensorCount: Int
```

## threadCount

The maximum number of CPU threads that the interpreter should run on. The default is `nil`
indicating that the `Interpreter` will decide the number of threads to use.

``` swift
var threadCount: Int? = nil
```

## Methods

## invoke()

Invokes the interpreter to perform inference from the loaded graph.

``` swift
public func invoke() throws
```

### Throws

An error if the model was not ready because the tensors were not allocated.

## input(at:)

Returns the input `Tensor` at the given index.

``` swift
public func input(at index: Int) throws -> Tensor
```

### Parameters

  - index: The index for the input `Tensor`.

### Throws

An error if the index is invalid or the tensors have not been allocated.

### Returns

The input `Tensor` at the given index.

## output(at:)

Returns the output `Tensor` at the given index.

``` swift
public func output(at index: Int) throws -> Tensor
```

### Parameters

  - index: The index for the output `Tensor`.

### Throws

An error if the index is invalid, tensors haven't been allocated, or interpreter has not been invoked for models that dynamically compute output tensors based on the values of its input tensors.

### Returns

The output `Tensor` at the given index.

## resizeInput(at:to:)

Resizes the input `Tensor` at the given index to the specified `Tensor.Shape`.

``` swift
public func resizeInput(at index: Int, to shape: Tensor.Shape) throws
```

> Note: After resizing an input tensor, the client **must** explicitly call `allocateTensors()` before attempting to access the resized tensor data or invoking the interpreter to perform inference.

### Parameters

  - index: The index for the input `Tensor`.
  - shape: The shape to resize the input `Tensor` to.

### Throws

An error if the input tensor at the given index could not be resized.

## copy(\_:toInputAt:)

Copies the given data to the input `Tensor` at the given index.

``` swift
@discardableResult public func copy(_ data: Data, toInputAt index: Int) throws -> Tensor
```

### Parameters

  - data: The data to be copied to the input `Tensor`'s data buffer.
  - index: The index for the input `Tensor`.

### Throws

An error if the `data.count` does not match the input tensor's `data.count` or if the given index is invalid.

### Returns

The input `Tensor` with the copied data.

## allocateTensors()

Allocates memory for all input `Tensor`s based on their `Tensor.Shape`s.

``` swift
public func allocateTensors() throws
```

> Note: This is a relatively expensive operation and should only be called after creating the interpreter and resizing any input tensors.

### Throws

An error if memory could not be allocated for the input tensors.
