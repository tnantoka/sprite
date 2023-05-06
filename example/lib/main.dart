import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sprite/sprite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sprite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sprite Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var amount = 2;
  var axis = Axis.horizontal;
  var scale = 1;
  var length = 64.0;
  var offsetX = 0;
  var offsetY = 0;
  var stepTime = 300;
  var image = 1;
  var paused = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = Size(length, length);
    final width = axis == Axis.horizontal ? size.width * amount : size.width;
    final height = axis == Axis.vertical ? size.height * amount : size.height;
    final imagePath = 'assets/images/spritesheet$image.png';

    final code = '''
Sprite(
  imagePath: $imagePath,
  size: $size,
  amount: $amount,
  scale: $scale,
  stepTime: $stepTime,
  axis: $axis,
  paused: $paused,
  offsetX: $offsetX,
  offsetY: $offsetY,
});
    ''';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          children: [
            Sprite(
              imagePath: imagePath,
              scale: scale,
              size: size,
              amount: amount,
              offsetX: offsetX,
              offsetY: offsetY,
              stepTime: stepTime,
              axis: axis,
              paused: paused,
            ),
            Stack(
              children: [
                Image(
                  image: AssetImage(imagePath),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: offsetX * length,
                    top: offsetY * length,
                  ),
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: 200,
              child: Column(
                children: [
                  _imageField(),
                  _amountField(),
                  _axisField(),
                  _scaleField(),
                  _lengthField(),
                  _offsetXField(),
                  _offsetYField(),
                  _stepTimeField(),
                  _pausedField(),
                ],
              ),
            ),
            Text(code),
            IconButton(
              onPressed: () => Clipboard.setData(
                ClipboardData(text: code),
              ),
              icon: const Icon(Icons.copy),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'image',
      ),
      value: image,
      onChanged: (int? value) {
        setState(() {
          image = value!;
        });
      },
      items: [1, 2].map((int value) {
        return DropdownMenuItem(
          value: value,
          child: Text('spriteesheet$value'),
        );
      }).toList(),
    );
  }

  Widget _amountField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'amount',
      ),
      value: amount,
      onChanged: (int? value) {
        setState(() {
          amount = value!;
        });
      },
      items: [1, 2, 3, 4, 5, 6].map((int value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }

  Widget _axisField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'axis',
      ),
      value: axis,
      onChanged: (Axis? value) {
        setState(() {
          axis = value!;
        });
      },
      items: [Axis.horizontal, Axis.vertical].map((Axis value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }

  Widget _scaleField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'scale',
      ),
      value: scale,
      onChanged: (int? value) {
        setState(() {
          scale = value!;
        });
      },
      items: [1, 2, 3].map((int value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }

  Widget _lengthField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'size',
      ),
      value: length,
      onChanged: (double? value) {
        setState(() {
          length = value!;
        });
      },
      items: [64.0, 128.0].map((double value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }

  Widget _offsetXField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'offsetX',
      ),
      value: offsetX,
      onChanged: (int? value) {
        setState(() {
          offsetX = value!;
        });
      },
      items: [0, 1, 2, 3, 4, 5].map((int value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }

  Widget _offsetYField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'offsetY',
      ),
      value: offsetY,
      onChanged: (int? value) {
        setState(() {
          offsetY = value!;
        });
      },
      items: [0, 1, 2, 3, 4, 5].map((int value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }

  Widget _stepTimeField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'stepTime',
      ),
      value: stepTime,
      onChanged: (int? value) {
        setState(() {
          stepTime = value!;
        });
      },
      items: [100, 300, 500, 700, 900].map((int value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }

  Widget _pausedField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'paused',
      ),
      value: paused,
      onChanged: (bool? value) {
        setState(() {
          paused = value!;
        });
      },
      items: [true, false].map((bool value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}
