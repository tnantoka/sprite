library sprite;

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class AnimationPainter extends CustomPainter {
  AnimationPainter({
    required this.image,
    required this.sourceSize,
    required this.scale,
    required this.index,
    required this.axis,
    required this.offsetX,
    required this.offsetY,
  });

  final ui.Image image;
  final Size sourceSize;
  final int scale;
  final int index;
  final Axis axis;
  final int offsetX;
  final int offsetY;

  @override
  void paint(Canvas canvas, Size size) {
    final srcRect = Rect.fromLTWH(
      ((axis == Axis.horizontal ? index : 0) + offsetX) * sourceSize.width,
      ((axis == Axis.horizontal ? 0 : index) + offsetY) * sourceSize.height,
      sourceSize.width,
      sourceSize.height,
    );
    final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(image, srcRect, dstRect, Paint());
  }

  @override
  bool shouldRepaint(AnimationPainter oldDelegate) {
    return image != oldDelegate.image || index != oldDelegate.index;
  }
}
