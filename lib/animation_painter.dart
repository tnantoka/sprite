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
    required this.flipX,
    required this.flipY,
  });

  final ui.Image image;
  final Size sourceSize;
  final double scale;
  final int index;
  final Axis axis;
  final int offsetX;
  final int offsetY;
  final bool flipX;
  final bool flipY;

  @override
  void paint(Canvas canvas, Size size) {
    final srcRect = Rect.fromLTWH(
      ((axis == Axis.horizontal ? index : 0) + offsetX) * sourceSize.width,
      ((axis == Axis.horizontal ? 0 : index) + offsetY) * sourceSize.height,
      sourceSize.width,
      sourceSize.height,
    );
    final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.translate(
      flipX ? size.width : 0,
      flipY ? size.height : 0,
    );
    canvas.scale(
      flipX ? -1 : 1,
      flipY ? -1 : 1,
    );
    canvas.drawImageRect(image, srcRect, dstRect, Paint());
  }

  @override
  bool shouldRepaint(AnimationPainter oldDelegate) {
    return image != oldDelegate.image || index != oldDelegate.index;
  }
}
