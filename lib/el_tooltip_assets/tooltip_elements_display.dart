import 'package:flutter/material.dart';
import 'element_box.dart';
import 'enum/el_tooltip_position.dart';

class ToolTipElementsDisplay {
  final ElementBox bubble;
  final ElementBox arrow;
  final ElTooltipPosition position;
  final BorderRadiusGeometry? radius;

  ToolTipElementsDisplay({
    required this.bubble,
    required this.arrow,
    required this.position,
    this.radius,
  });
}
