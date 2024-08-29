import 'package:flutter/material.dart';

class SpecialClipper extends CustomClipper<RRect> {
  @override
  getClip(Size size) =>
      RRect.fromLTRBR(0, 0, size.width, size.height, const Radius.circular(12));

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
