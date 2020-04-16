# QuantizationParameters

Parameters that determine the mapping of quantized values to real values. Quantized values can
be mapped to float values using the following conversion:
`realValue = scale * (quantizedValue - zeroPoint)`.

``` swift
public struct QuantizationParameters: Equatable, Hashable
```

## Inheritance

`Equatable`, `Hashable`

## Properties

## scale

The difference between real values corresponding to consecutive quantized values differing by

``` swift
let scale: Float
```

1.  For example, the range of quantized values for `UInt8` data type is \[0, 255\].

## zeroPoint

The quantized value that corresponds to the real 0 value.

``` swift
let zeroPoint: Int
```
