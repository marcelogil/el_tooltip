<p align="center"><img src="https://raw.githubusercontent.com/marcelogil/el_tooltip/main/develop/images/header.png" width="700"/></p>
<h1 align="center"> 
ElTooltip - a smart positioned tooltip
</h1>


## Why el_tooltip?

- 📦 Add widget elements to your tooltip
- ↔️ Chose the prefered position for the tooltip to appear relative to the button
- ↩️ The position changes automagically if the desired one doesn't fit the screen
- ✅ No external dependencies
- ❤️ Customizable layout
- 🛡️ Null safety

## Getting Started

### 🍭 Installation

Add to your `pubspec.yaml`

```yaml
dependencies:
  el_tooltip: <last_version>
```

Import the library and call the Widget ElTooltip() with the required fields `trigger` and `content`


```dart
import 'package:flutter/material.dart';
import 'package:el_tooltip/el_tooltip.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const SafeArea(
      child: Center(
        child: ElTooltip(
          trigger: Icon(Icons.info_outline),
          content: Text('This is a tooltip'),
        ),
      ),
    ),
  ));
}
```

[**Full example**](https://github.com/marcelogil/el_tooltip/blob/main/example/lib/main.dart)

### 🏷️ El Tooltip widget properties

| Properties | Required | Default |  Description |
| ----------------------- | -------- | ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| content   | true  |  | What will appear inside the tooltip. |
| trigger   | true  |  | Widget that represent the button to activate the tooltip (no click method required). |
| color     | false | `Colors.white` | Background color of the bubble and the arrow. |
| distance  | false | `10.0` | Space between the trigger button and the tooltip. |
| padding   | false | `14.0` | Tooltip padding around the content widget. |
| position  | false | `topCenter` | Desired position based on the Enum `ElTooltipPosition`. Can be `topStart`, `topCenter`, `topEnd`, `rightStart`, `rightCenter`,` rightEnd`, `bottomStart`, `bottomCenter`, `bottomEnd`, `leftStart`, `leftCenter`, `leftEnd`, |
| radius    | false | `8.0`  | Border radius of the tooltip. |
| showModal | false | `true` | Displays a fullscreen dark layer behind the tooltip. |
| timeout   | false | `0` (only disappears on click) | How many seconds to wait for the tooltip to disappear. |

### ↔️ El Tooltip available positions

<p align="left"><img src="https://raw.githubusercontent.com/marcelogil/el_tooltip/main/develop/images/placement.png" width="700"/></p>


El tooltip header image was created using <a href="https://www.freepik.com/free-vector/mexican-element-set_5970756.htm#query=mexican&position=4&from_view=search&track=sph">macrovector</a> illustration on Freepik