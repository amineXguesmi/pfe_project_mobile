import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Ellipse curve painter extends [CustomPainter]
/// {@category Painter}
class CurvePainter extends CustomPainter {
  CurvePainter({
    required this.colors,
    required this.deviceHeight,
    this.direction = Axis.horizontal,
    this.curveStrength = 1.0,
    this.withShadow = true,
    this.reversed = false,
    this.margin = 0.0,
    this.shadowColor = Colors.black,
    this.shadowColorOpacity = 0.3,
    this.shadowBlur = 4,
  });

  /// Static constant to be used for strong curves
  static const double strongCurve = 2.0;

  /// Static constant to be used for normal curves
  static const double normalCurve = 1.0;

  /// List of colors to be used for gradient paint when drawing this shape
  final List<Color> colors;

  /// Device height as double
  /// Used to maintain the same curve independently of the current canvas
  final double deviceHeight;

  /// Gradient direction for painting
  final Axis direction;

  /// A double describing the curve strength.
  /// For consistency purposes please use [strongCurve] or [normalCurve]
  final double curveStrength;

  /// Boolean indicating either the curve has shadow or not
  final bool withShadow;

  /// Boolean indicating if the curve should be reversed or not
  final bool reversed;

  /// Horizontal margin to apply when drawing the curve
  final double margin;

  ///specified color for the shadow
  final Color shadowColor;

  ///specified opacity for the shadow color
  final double shadowColorOpacity;

  ///specified blur for the shadow
  final double shadowBlur;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..shader = ui.Gradient.linear(
        direction == Axis.horizontal ? Offset(0, size.height / 2) : Offset(0, size.height),
        direction == Axis.horizontal ? Offset(size.width, size.height / 2) : const Offset(0, 0),
        colors,
      )
      ..style = PaintingStyle.fill;
    var shadowPaint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, shadowBlur)
      ..color = shadowColor.withOpacity(shadowColorOpacity);

    var path = Path();

    if (reversed) {
      path.moveTo(margin, size.height == 0 ? 0 : deviceHeight * 0.04 * curveStrength);
      path.quadraticBezierTo(
        size.width / 2,
        size.height == 0 ? 0 : -deviceHeight * 0.04 * curveStrength,
        size.width - margin,
        size.height == 0 ? 0 : deviceHeight * 0.04 * curveStrength,
      );
      path.lineTo(size.width - margin, size.height == 0 ? 0 : size.height);
      path.lineTo(margin, size.height == 0 ? 0 : size.height);
    } else {
      path.moveTo(margin, size.height == 0 ? 0 : size.height - deviceHeight * 0.04 * curveStrength);
      path.quadraticBezierTo(
        size.width / 2,
        size.height == 0 ? 0 : size.height + deviceHeight * 0.04 * curveStrength,
        size.width - margin,
        size.height == 0 ? 0 : size.height - deviceHeight * 0.04 * curveStrength,
      );
      path.lineTo(size.width - margin, 0);
      path.lineTo(margin, 0);
    }
    if (withShadow) {
      canvas.drawPath(path, shadowPaint);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
