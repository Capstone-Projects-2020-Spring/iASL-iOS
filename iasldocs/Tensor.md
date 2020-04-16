# Tensor

An input or output tensor in a TensorFlow Lite graph.

``` swift
public struct Tensor: Equatable, Hashable
```

## Inheritance

`Equatable`, `Hashable`

## Enumeration Cases

## bool

A boolean.

``` swift
case bool
```

## uInt8

An 8-bit unsigned integer.

``` swift
case uInt8
```

## int16

A 16-bit signed integer.

``` swift
case int16
```

## int32

A 32-bit signed integer.

``` swift
case int32
```

## int64

A 64-bit signed integer.

``` swift
case int64
```

## float16

A 16-bit half precision floating point.

``` swift
case float16
```

## float32

A 32-bit single precision floating point.

``` swift
case float32
```

## Initializers

## init(\_:)

Creates a new instance with the given array of dimensions.

``` swift
public init(_ dimensions: [Int])
```

### Parameters

  - dimensions: Dimensions for the `Tensor`.

## init(\_:)

Creates a new instance with the given elements representing the dimensions.

``` swift
public init(_ elements: Int)
```

### Parameters

  - elements: Dimensions for the `Tensor`.

## init(arrayLiteral:)

Creates a new instance with the given array literal representing the dimensions.

``` swift
public init(arrayLiteral: Int)
```

### Parameters

  - arrayLiteral: Dimensions for the `Tensor`.

## Properties

## name

The name of the `Tensor`.

``` swift
let name: String
```

## dataType

The data type of the `Tensor`.

``` swift
let dataType: DataType
```

## shape

The shape of the `Tensor`.

``` swift
let shape: Shape
```

## data

The data in the input or output `Tensor`.

``` swift
let data: Data
```

## quantizationParameters

The quantization parameters for the `Tensor` if using a quantized model.

``` swift
let quantizationParameters: QuantizationParameters?
```

## rank

The number of dimensions of the `Tensor`.

``` swift
let rank: Int
```

## dimensions

An array of dimensions for the `Tensor`.

``` swift
let dimensions: [Int]
```
