import 'package:flutter/material.dart';

class AppStyle {
  static const size = _Size();

  static const borderRadius = _BorderRadius(size);
  static const padding = _Padding(size);
  static const delimiter = _Delimiter(size);
}

class _Size {
  const _Size();

  final double xs = 4.0;
  final double sm = 8.0;
  final double md = 16.0;
  final double lg = 24.0;
  final double xl = 32.0;
  final double touch = 48.0;
}

class _Padding {
  const _Padding(this.size);

  final _Size size;

  EdgeInsets get xs => EdgeInsets.all(size.xs);
  EdgeInsets get sm => EdgeInsets.all(size.sm);
  EdgeInsets get md => EdgeInsets.all(size.md);
  EdgeInsets get lg => EdgeInsets.all(size.lg);
}

class _BorderRadius {
  const _BorderRadius(this.size);

  final _Size size;

  BorderRadius get xs => BorderRadius.all(Radius.circular(size.sm));
  BorderRadius get sm => BorderRadius.all(Radius.circular(size.md));
  BorderRadius get md => BorderRadius.all(Radius.circular(size.lg));
  BorderRadius get lg => BorderRadius.all(Radius.circular(size.xl));
}

class _Delimiter {
  const _Delimiter(this.size);

  final _Size size;

  SizedBox get xsH => SizedBox(width: size.xs);
  SizedBox get smH => SizedBox(width: size.sm);
  SizedBox get mdH => SizedBox(width: size.md);
  SizedBox get lgH => SizedBox(width: size.lg);
  SizedBox get xlH => SizedBox(width: size.xl);
  SizedBox get touchH => SizedBox(width: size.xl);

  SizedBox get xsV => SizedBox(height: size.xs);
  SizedBox get smV => SizedBox(height: size.sm);
  SizedBox get mdV => SizedBox(height: size.md);
  SizedBox get lgV => SizedBox(height: size.lg);
  SizedBox get xlV => SizedBox(height: size.xl);
  SizedBox get touchV => SizedBox(height: size.xl);
}