import 'package:flutter/material.dart';

class Dimensions {
  Dimensions._();

  static const _base = 4.0;

  /// 4
  static const xxxxs = _base;

  /// 8
  static const xxxs = 2 * _base;

  /// 12
  static const xxs = 3 * _base;

  /// 16
  static const xs = 4 * _base;

  /// 20
  static const sm = 5 * _base;

  /// 24
  static const md = 6 * _base;

  /// 28
  static const xmd = 7 * _base;

  /// 32
  static const lg = 8 * _base;

  /// 36
  static const xlg = 9 * _base;

  /// 40
  static const xl = 10 * _base;

  /// 44
  static const xxlg = 11 * _base;

  /// 48
  static const xxl = 12 * _base;

  /// 56
  static const xxxl = 14 * _base;

  /// 64
  static const xxxxl = 16 * _base;
}

/// 4
Widget xxxxsSpacer() => _spacer(Dimensions.xxxxs);

/// 8
Widget xxxsSpacer() => _spacer(Dimensions.xxxs);

/// 12
Widget xxsSpacer() => _spacer(Dimensions.xxs);

/// 16
Widget xsSpacer() => _spacer(Dimensions.xs);

/// 20
Widget smSpacer() => _spacer(Dimensions.sm);

/// 24
Widget mdSpacer() => _spacer(Dimensions.md);

/// 28
Widget xmdSpacer() => _spacer(Dimensions.xmd);

/// 32
Widget lgSpacer() => _spacer(Dimensions.lg);

/// 36
Widget xlgSpacer() => _spacer(Dimensions.xlg);

/// 40
Widget xlSpacer() => _spacer(Dimensions.xl);

/// 48
Widget xxlSpacer() => _spacer(Dimensions.xxl);

/// 56
Widget xxxlSpacer() => _spacer(Dimensions.xxxl);

/// 64
Widget xxxxlSpacer() => _spacer(Dimensions.xxxxl);

Widget _spacer(double size) => SizedBox(height: size, width: size);