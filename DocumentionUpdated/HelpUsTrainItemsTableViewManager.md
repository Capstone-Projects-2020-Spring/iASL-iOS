# HelpUsTrainItemsTableViewManager

``` swift
private class HelpUsTrainItemsTableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate
```

## Inheritance

`NSObject`, `UITableViewDataSource`, `UITableViewDelegate`

## Properties

### `items`

``` swift
var items: [HelpUsTrainItem]!
```

## Methods

### `tableView(_:numberOfRowsInSection:)`

``` swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```

### `tableView(_:heightForRowAt:)`

``` swift
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
```

### `tableView(_:cellForRowAt:)`

``` swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
```
