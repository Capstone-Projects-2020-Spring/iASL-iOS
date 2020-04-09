# Configuration.Paws.Color

Define the colour of the Paws

``` swift
public enum Color
```

  - randomized: random colour for each paw

<!-- end list -->

  - constant: same colour for the paws

## Enumeration Cases

## randomized

``` swift
case randomized
```

## constant

``` swift
case constant(: UIColor)
```

## randomized

``` swift
case randomized
```

## constant

``` swift
case constant(: UIColor)
```

## Initializers

## init(colour:brightness:maxShown:)

``` swift
public init(colour: Color = .randomized, brightness: CGFloat = 0.5, maxShown: Int = 15)
```

## init(colour:brightness:maxShown:)

``` swift
public init(colour: Color = .randomized, brightness: CGFloat = 0.5, maxShown: Int = 15)
```

## Properties

## color

``` swift
let color: Color
```

## brightness

``` swift
let brightness: CGFloat
```

## maxShown

``` swift
let maxShown: Int
```

## color

``` swift
let color: Color
```

## brightness

``` swift
let brightness: CGFloat
```

## maxShown

``` swift
let maxShown: Int
```
