import 'package:flutter/material.dart';
import 'modal_style.dart';

/// Modal is the fullscreen window displayed behind the tooltip.
/// It's used to focus the user attention to the tooltip.
class Modal extends StatelessWidget {
  final bool visible;
  final ElTooltipModalStyle style;
  final VoidCallback? onTap;

  const Modal({
    required this.onTap,
    required this.style,
    this.visible = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          color: style.color.withOpacity(style.opacity),
        ),
      );
    } else {
      return Container();
    }
  }
}
