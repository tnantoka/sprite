/// Animated widget with sprite sheet image.
library sprite;

import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'animation_painter.dart';

class Sprite extends StatefulWidget {
  const Sprite({
    super.key,
    this.imagePath,
    this.image,
    required this.size,
    required this.amount,
    this.scale = 1.0,
    this.stepTime = 300,
    this.axis = Axis.horizontal,
    this.paused = false,
    this.offsetX = 0,
    this.offsetY = 0,
    this.flipX = false,
    this.flipY = false,
  }) : assert(imagePath != null || image != null);

  /// Path to sprite sheet image. required if [image] is null.
  final String? imagePath;

  /// Sprite sheet image. required if [imagePath] is null.
  final ui.Image? image;

  /// Scale for resinzing sprite.
  final double scale;

  /// Time between animation steps.
  final int stepTime;

  /// Size of single sprite.
  final Size size;

  /// Axis of animation in sprite sheet.
  final Axis axis;

  /// Is animation paused.
  final bool paused;

  /// X offset of start sprite in sprite sheet.
  final int offsetX;

  /// Y offset of start sprite in sprite sheet.
  final int offsetY;

  /// Amount of sprites in sprite sheet.
  final int amount;

  /// Flip animation horizontally.
  final bool flipX;

  /// Flip animation vertically.
  final bool flipY;

  @override
  State<Sprite> createState() => _SpriteState();
}

class _SpriteState extends State<Sprite> {
  int _index = 0;
  Timer? _animationTimer;
  ui.Image? _loadedImage;

  ui.Image? get _image => widget.image ?? _loadedImage;

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void didUpdateWidget(covariant Sprite oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.stepTime != widget.stepTime ||
        oldWidget.paused != widget.paused) {
      _setTimer();
    }

    if (oldWidget.imagePath != widget.imagePath) {
      _loadImage();
    }
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
      painter: AnimationPainter(
        image: _image!,
        sourceSize: widget.size,
        scale: widget.scale,
        index: _index,
        axis: widget.axis,
        offsetX: widget.offsetX,
        offsetY: widget.offsetY,
        flipX: widget.flipX,
        flipY: widget.flipY,
      ),
      size: widget.size * widget.scale,
    );
  }

  _init() async {
    await _loadImage();
    await _setTimer();
  }

  _loadImage() async {
    if (widget.image != null) {
      return;
    }

    final data = await rootBundle.load(widget.imagePath!);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    setState(() {
      _loadedImage = frame.image;
    });
  }

  _setTimer() {
    _animationTimer?.cancel();

    if (widget.paused) {
      return;
    }

    _animationTimer = Timer.periodic(
      Duration(milliseconds: widget.stepTime),
      (_) {
        if (widget.paused || _image == null) {
          return;
        }

        setState(() {
          _index = (_index + 1) % widget.amount;
        });
      },
    );
  }
}
