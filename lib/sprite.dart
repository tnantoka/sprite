library sprite;

import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Sprite extends StatefulWidget {
  const Sprite({
    super.key,
    this.imagePath,
    this.image,
    required this.amount,
    this.scale = 1,
    this.stepTime = 200,
  });

  final String? imagePath;
  final ui.Image? image;
  final int amount;
  final int scale;
  final int stepTime;

  @override
  State<Sprite> createState() => _SpriteState();
}

class _SpriteState extends State<Sprite> {
  ui.Image? _image;
  Timer? _animationTimer;
  int _index = 0;

  @override
  void initState() {
    super.initState();

    _setImage();

    _animationTimer = Timer.periodic(
      Duration(milliseconds: widget.stepTime),
      (_) {
        setState(() {
          _index = (_index + 1) % widget.amount;
        });
      },
    );
  }

  @override
  void didUpdateWidget(covariant Sprite oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.imagePath != widget.imagePath ||
        oldWidget.image != widget.image) {
      _setImage();
    }
  }

  _setImage() {
    if (widget.image != null) {
      _image = widget.image;
    } else if (widget.imagePath != null) {
      _loadImage();
    }
  }

  void _loadImage() async {
    final data = await rootBundle.load(widget.imagePath!);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    _image = frame.image;
    setState(() {});
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      return const SizedBox.shrink();
    }

    return CustomPaint(
      painter: _SpriteAnimationPainter(
        image: _image!,
        amount: widget.amount,
        scale: widget.scale,
        index: _index,
      ),
      size: Size(
        _image!.width / widget.amount * widget.scale,
        _image!.height * widget.scale.toDouble(),
      ),
    );
  }
}

class _SpriteAnimationPainter extends CustomPainter {
  _SpriteAnimationPainter({
    required this.image,
    required this.amount,
    required this.scale,
    required this.index,
  });

  final ui.Image image;
  final int amount;
  final int scale;
  final int index;

  @override
  void paint(Canvas canvas, Size size) {
    final srcWidth = image.width / amount;
    final srcHeight = image.height.toDouble();
    final srcRect = Rect.fromLTWH(index * srcWidth, 0, srcWidth, srcHeight);
    final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(image, srcRect, dstRect, Paint());
  }

  @override
  bool shouldRepaint(_SpriteAnimationPainter oldDelegate) {
    return image != oldDelegate.image || index != oldDelegate.index;
  }
}
