<p align="center"><img src="https://raw.githubusercontent.com/marcelogil/el_tooltip/main/develop/images/header.png" width="700"/></p>
<h1 align="center"> 
ElTooltip - a smart positioned tooltip
</h1>


## Why el_tooltip?

- 📦 Add widget elements to your tooltip
- ↔️ Chose the preferred position for the tooltip to appear relative to the button
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

Import the library and call the Widget ElTooltip() with the required fields `child` and `content`


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
          child: Icon(Icons.info_outline),
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
| child     | true  |  | Widget that represent the button to activate the tooltip (no click method required). |
| color     | false | `Colors.white` | Background color of the bubble and the arrow. |
| distance  | false | `10.0` | Space between the child button and the tooltip. |
| padding   | false | `EdgeInsets.all(14.0)` | Tooltip padding around the content widget. |
| position  | false | `topCenter` | Desired position based on the Enum `ElTooltipPosition`. Can be `topStart`, `topCenter`, `topEnd`, `rightStart`, `rightCenter`,` rightEnd`, `bottomStart`, `bottomCenter`, `bottomEnd`, `leftStart`, `leftCenter`, `leftEnd`, |
| radius    | false | `Radius.circular(8.0)`  | Border radius of the tooltip. |
| showModal | false | `true` | Displays a fullscreen dark layer behind the tooltip. |
| showArrow | false | `true` | Displays the arrow pointing to the child widget. |
| showChildAboveOverlay | false | `true` | Repeats the child above the tooltip overlay. |
| modalConfiguration | false | `ModalConfiguration()` | Configures the modal color and opacity if showModal is true. |
| timeout   | false | `Duration.zero` (only disappears on click) | How many time to wait for the tooltip to disappear. |
| appearAnimationDuration | false | `Duration.zero` (does not animate) | Fade In animation duration. |
| disappearAnimationDuration | false | `Duration.zero` (does not animate) | Fade Out animation duration. |
| controller | false | `null` | `ElTooltipController` to show and hide the tooltip. |


### ↔️ El Tooltip available positions

<p align="left"><img src="https://raw.githubusercontent.com/marcelogil/el_tooltip/main/develop/images/placement.png" width="700"/></p>


El tooltip header image was created using <a href="https://www.freepik.com/free-vector/mexican-element-set_5970756.htm#query=mexican&position=4&from_view=search&track=sph">macrovector</a> illustration on Freepik

## Contributors ✨

Thanks goes to these wonderful people:

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://marcelogil.com"><div style="border-radius:50%; width:100px; height:100px;  overflow: hidden;"><img src="https://avatars.githubusercontent.com/u/3277922?v=4" width="100px;" alt=""/></div><br /><sub><b>Marcelo Gil</b></sub></a><br /><a href="https://github.com/marcelogil/el_tooltip/commits?author=marcelogil" title="Code">💻</a></td>
    <td align="center"><a href="https://phcs971.github.io"><div style="border-radius:50%; width:100px; height:100px;  overflow: hidden;"><img src="https://avatars.githubusercontent.com/u/48731731?v=4" width="100px;" alt=""/></div><br /><sub><b>Matteo Pietro Dazzi</b></sub></a><br /><a href="https://github.com/marcelogil/el_tooltip/commits?author=phcs971" title="Code">💻</a></td>
  </tr>
</table>
