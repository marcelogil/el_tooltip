import 'package:el_tooltip/el_tooltip.dart';
import 'package:el_tooltip/src/arrow.dart';
import 'package:el_tooltip/src/bubble.dart';
import 'package:el_tooltip/src/element_box.dart';
import 'package:el_tooltip/src/modal.dart';
import 'package:el_tooltip/src/tooltip_elements_display.dart';
import 'package:flutter/material.dart';

class ElTooltipOverlay extends StatefulWidget {
  const ElTooltipOverlay({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14.0),
    this.showModal = true,
    this.showArrow = true,
    this.showChildAboveOverlay = true,
    this.modalConfiguration = const ModalConfiguration(),
    required this.toolTipElementsDisplay,
    required this.color,
    required this.content,
    required this.hideOverlay,
    required this.triggerBox,
    required this.arrowBox,
    required this.appearAnimationDuration,
    required this.disappearAnimationDuration,
  });

  /// [child] Widget that will trigger the tooltip to appear.
  final Widget child;

  /// [color] Background color of the tooltip and the arrow.
  final Color color;

  /// [content] Widget that appears inside the tooltip.
  final Widget content;

  /// [padding] Space inside the tooltip - around the content.
  final EdgeInsetsGeometry padding;

  /// [showModal] Shows a dark layer behind the tooltip.
  final bool showModal;

  /// [showArrow] Shows an arrow pointing to the trigger.
  final bool showArrow;

  /// [showChildAboveOverlay] Shows the child above the overlay.
  final bool showChildAboveOverlay;

  /// [modalConfiguration] Configures the [Modal] widget
  /// Only used if [showModal] is true
  final ModalConfiguration modalConfiguration;

  /// [toolTipElementsDisplay] Contains the position of the tooltip, the arrow and the trigger
  final ToolTipElementsDisplay toolTipElementsDisplay;

  /// [hideOverlay] Function that hides the overlay
  final VoidCallback hideOverlay;

  /// [triggerBox] Box that contains the trigger
  final ElementBox triggerBox;

  /// [arrowBox] Box that contains the arrow
  final ElementBox arrowBox;

  /// [appearAnimationDuration] Duration of the appear animation of the modal
  /// The default value is 0 which means it doesn't animate
  final Duration appearAnimationDuration;

  /// [disappearAnimationDuration] Duration of the disappear animation of the modal
  /// The default value is 0 which means it doesn't animate
  final Duration disappearAnimationDuration;

  @override
  State<ElTooltipOverlay> createState() => ElTooltipOverlayState();
}

class ElTooltipOverlayState extends State<ElTooltipOverlay> {
  bool closing = false;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    show();
  }

  Future<void> show() async {
    setState(() {
      closing = false;
      opacity = 1;
    });
    await Future.delayed(widget.appearAnimationDuration);
  }

  Future<void> hide() async {
    setState(() {
      closing = true;
      opacity = 0;
    });
    await Future.delayed(widget.disappearAnimationDuration);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: closing
          ? widget.disappearAnimationDuration
          : widget.appearAnimationDuration,
      child: Stack(
        children: [
          Modal(
            color: widget.modalConfiguration.color,
            opacity: widget.modalConfiguration.opacity,
            visible: widget.showModal,
            onTap: widget.hideOverlay,
          ),
          Positioned(
            top: widget.toolTipElementsDisplay.bubble.y,
            left: widget.toolTipElementsDisplay.bubble.x,
            child: Bubble(
              triggerBox: widget.triggerBox,
              padding: widget.padding,
              radius: widget.toolTipElementsDisplay.radius,
              color: widget.color,
              child: widget.content,
            ),
          ),
          if (widget.showArrow)
            Positioned(
              top: widget.toolTipElementsDisplay.arrow.y,
              left: widget.toolTipElementsDisplay.arrow.x,
              child: Arrow(
                color: widget.color,
                position: widget.toolTipElementsDisplay.position,
                width: widget.arrowBox.w,
                height: widget.arrowBox.h,
              ),
            ),
          if (widget.showChildAboveOverlay)
            Positioned(
              top: widget.triggerBox.y,
              left: widget.triggerBox.x,
              child: GestureDetector(
                onTap: widget.hideOverlay,
                child: widget.child,
              ),
            ),
        ],
      ),
    );
  }
}
