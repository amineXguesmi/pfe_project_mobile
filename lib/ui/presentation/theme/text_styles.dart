import 'package:flutter/material.dart';

class TextStyles {
  TextStyles._();

  static TextStyle _title0({FontWeight? weight, Color? color}) => TextStyle(
        fontSize: 34,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Colors.black,
        // height: 40 / 34,
      );

  static TextStyle _title1({FontWeight? weight, Color? color}) => TextStyle(
        fontSize: 28,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Colors.black,
        // height: 32 / 28,
      );

  static TextStyle _title2({FontWeight? weight, Color? color}) => TextStyle(
        fontSize: 22,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Colors.black,
        // height: 32 / 22,
      );
  static TextStyle _title3({FontWeight? weight, Color? color}) => TextStyle(
        fontSize: 20,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Colors.black,
        // height: 32 / 22,
      );

  static TextStyle _button({FontWeight? weight, Color? color}) => TextStyle(
        fontSize: 18,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Colors.black,
        //   height: 32 / 18,
      );

  static TextStyle _body1({FontWeight? weight, Color? color}) => TextStyle(
        fontSize: 17,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Colors.black,
        // height: 32 / 17,
      );

  static TextStyle _body0({FontWeight? weight, Color? color}) => TextStyle(
        fontSize: 16,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Colors.black,
        // height: 32 / 17,
      );

  static TextStyle _callout({FontWeight? weight, Color? color}) => TextStyle(
        fontSize: 14,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Colors.black,
        // height: 32 / 15,
      );

  static TextStyle _footNote({FontWeight? weight, Color? color, TextDecoration? decoration}) => TextStyle(
        fontSize: 12,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Colors.black,
        // height: 32 / 13,
      ).copyWith(decoration: decoration);
  static TextStyle _footNote1({FontWeight? weight, Color? color}) => TextStyle(
        fontSize: 13,
        fontWeight: weight ?? FontWeight.bold,
        color: color ?? Colors.black,
        // height: 32 / 13,
      );

  /// FontSize: 34
  static TextStyle title0Light({Color? color}) => _title0(
        weight: FontWeight.w300,
        color: color,
      );

  /// FontSize: 34
  static TextStyle title0Regular({Color? color}) => _title0(
        weight: FontWeight.w400,
        color: color,
      );

  /// FontSize: 34
  static TextStyle title0Medium({Color? color}) => _title0(
        weight: FontWeight.w500,
        color: color,
      );

  /// FontSize: 34
  static TextStyle title0Semibold({Color? color}) => _title0(
        weight: FontWeight.w600,
        color: color,
      );

  /// FontSize: 34
  static TextStyle title0Bold({Color? color}) => _title0(
        weight: FontWeight.w700,
        color: color,
      );

  /// FontSize: 28
  static TextStyle title1Light({Color? color}) => _title1(
        weight: FontWeight.w300,
        color: color,
      );

  /// FontSize: 28
  static TextStyle title1Regular({Color? color}) => _title1(
        weight: FontWeight.w400,
        color: color,
      );

  /// FontSize: 28
  static TextStyle title1Medium({Color? color}) => _title1(
        weight: FontWeight.w500,
        color: color,
      );

  /// FontSize: 28
  static TextStyle title1Semibold({Color? color}) => _title1(
        weight: FontWeight.w600,
        color: color,
      );

  /// FontSize: 28
  static TextStyle title1Bold({Color? color}) => _title1(
        weight: FontWeight.w700,
        color: color,
      );

  /// FontSize: 22
  static TextStyle title2Light({Color? color}) => _title2(
        weight: FontWeight.w300,
        color: color,
      );

  /// FontSize: 22
  static TextStyle title2Regular({Color? color}) => _title2(
        weight: FontWeight.w400,
        color: color,
      );

  /// FontSize: 22
  static TextStyle title2Medium({Color? color}) => _title2(
        weight: FontWeight.w500,
        color: color,
      );

  /// FontSize: 22
  static TextStyle title2Semibold({Color? color}) => _title2(
        weight: FontWeight.w600,
        color: color,
      );

  /// FontSize: 22
  static TextStyle title2Bold({Color? color}) => _title2(
        weight: FontWeight.w700,
        color: color,
      );

  /// Title3
  static TextStyle title3Light({Color? color}) => _title3(
        weight: FontWeight.w300,
        color: color,
      );
  static TextStyle title3Regular({Color? color}) => _title3(
        weight: FontWeight.w400,
        color: color,
      );
  static TextStyle title3Medium({Color? color}) => _title3(
        weight: FontWeight.w500,
        color: color,
      );
  static TextStyle title3Semibold({Color? color}) => _title3(
        weight: FontWeight.w600,
        color: color,
      );
  static TextStyle title3Bold({Color? color}) => _title3(
        weight: FontWeight.w700,
        color: color,
      );

  /// Button
  /// FontSize: 18
  static TextStyle buttonLight({Color? color}) => _button(
        weight: FontWeight.w300,
        color: color,
      );

  /// FontSize: 18
  static TextStyle buttonRegular({Color? color}) => _button(
        weight: FontWeight.w400,
        color: color,
      );

  /// FontSize: 18
  static TextStyle buttonMedium({Color? color}) => _button(
        weight: FontWeight.w500,
        color: color,
      );

  /// FontSize: 18
  static TextStyle buttonSemibold({Color? color}) => _button(
        weight: FontWeight.w600,
        color: color,
      );

  /// FontSize: 18
  static TextStyle buttonBold({Color? color}) => _button(
        weight: FontWeight.w700,
        color: color,
      );

  /// FontSize: 16
  static TextStyle body0Light({Color? color}) => _body0(
        weight: FontWeight.w300,
        color: color,
      );

  /// FontSize: 16
  static TextStyle body0Regular({Color? color}) => _body0(
        weight: FontWeight.w400,
        color: color,
      );

  /// FontSize: 16
  static TextStyle body0Medium({Color? color}) => _body0(
        weight: FontWeight.w500,
        color: color,
      );

  /// FontSize: 16
  static TextStyle body0Semibold({Color? color}) => _body0(
        weight: FontWeight.w600,
        color: color,
      );

  /// FontSize: 16
  static TextStyle body0Bold({Color? color}) => _body0(
        weight: FontWeight.w700,
        color: color,
      );

  /// FontSize: 17
  static TextStyle body1Light({Color? color}) => _body1(
        weight: FontWeight.w300,
        color: color,
      );

  /// FontSize: 17
  static TextStyle body1Regular({Color? color}) => _body1(
        weight: FontWeight.w400,
        color: color,
      );

  /// FontSize: 17
  static TextStyle body1Medium({Color? color}) => _body1(
        weight: FontWeight.w500,
        color: color,
      );

  /// FontSize: 17
  static TextStyle body1Semibold({Color? color}) => _body1(
        weight: FontWeight.w600,
        color: color,
      );

  /// FontSize: 17
  static TextStyle body1Bold({Color? color}) => _body1(
        weight: FontWeight.w700,
        color: color,
      );

  /// FontSize: 14
  static TextStyle calloutLight({Color? color}) => _callout(
        weight: FontWeight.w300,
        color: color,
      );

  /// FontSize: 14
  static TextStyle calloutRegular({Color? color}) => _callout(
        weight: FontWeight.w400,
        color: color,
      );

  /// FontSize: 14
  static TextStyle calloutMedium({Color? color}) => _callout(
        weight: FontWeight.w500,
        color: color,
      );

  /// FontSize: 14
  static TextStyle calloutSemibold({Color? color}) => _callout(
        weight: FontWeight.w600,
        color: color,
      );

  /// FontSize: 14
  static TextStyle calloutBold({Color? color}) => _callout(
        weight: FontWeight.w700,
        color: color,
      );

  /// FontSize: 12
  static TextStyle footnoteLight({Color? color}) => _footNote(
        weight: FontWeight.w300,
        color: color,
      );

  /// FontSize: 12
  static TextStyle footnoteRegular({Color? color}) => _footNote(
        weight: FontWeight.w400,
        color: color,
      );

  /// FontSize: 12
  static TextStyle footnoteMedium({Color? color, TextDecoration? decoration}) =>
      _footNote(weight: FontWeight.w500, color: color, decoration: decoration);

  /// FontSize: 12
  static TextStyle footnoteSemibold({Color? color}) => _footNote(
        weight: FontWeight.w600,
        color: color,
      );

  /// FontSize: 12
  static TextStyle footnoteBold({Color? color}) => _footNote(
        weight: FontWeight.w700,
        color: color,
      );

  /// Footnote1
  static TextStyle footnote1Light({Color? color}) => _footNote1(
        weight: FontWeight.w300,
        color: color,
      );
  static TextStyle footnote1Regular({Color? color}) => _footNote1(
        weight: FontWeight.w400,
        color: color,
      );
  static TextStyle footnote1Medium({Color? color}) => _footNote1(
        weight: FontWeight.w500,
        color: color,
      );
  static TextStyle footnote1Semibold({Color? color}) => _footNote1(
        weight: FontWeight.w600,
        color: color,
      );
  static TextStyle footnote1Bold({Color? color}) => _footNote1(
        weight: FontWeight.w700,
        color: color,
      );
}