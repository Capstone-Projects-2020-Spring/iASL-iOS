# Tensor.Tensor.DataType.Tensor.Shape

The shape of a `Tensor`.

``` swift
public struct Shape: Equatable, Hashable
```

## Inheritance

`Equatable`, `Hashable`

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
