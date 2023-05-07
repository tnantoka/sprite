# Sprite

Animated sprite widget but not for game.

## Features

- Create animated widgets from sprite sheet images with customizable options

## Live Demo

https://sprite.tnantoka.com/

![](https://github.com/tnantoka/sprite/raw/main/demo/sprite.gif)

## Usage

```yaml
dependencies:
  flutter:
    sdk: flutter
  sprite: ^0.0.1
```

```dart
import 'package:sprite/sprite.dart';

Sprite(
  imagePath: 'assets/images/spritesheet1.png',
  size: Size(64, 64),
  amount: 3,
)
```

See [example](/example) for more details.

## Author

[@tnantoka](https://twitter.com/tnantoka)
