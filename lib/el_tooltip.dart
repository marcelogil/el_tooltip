library el_tooltip;

import 'package:el_tooltip/src/el_tooltip_overlay.dart';
import 'package:flutter/material.dart';

import 'src/bubble.dart';
import 'src/element_box.dart';
import 'src/enum/el_tooltip_position.dart';
import 'src/modal.dart';
import 'src/modal_configuration.dart';
import 'src/position_manager.dart';
import 'src/tooltip_elements_display.dart';

export 'src/enum/el_tooltip_position.dart';
export 'src/modal_configuration.dart';

/// Widget that displays a tooltip
/// It takes a widget as the trigger and a widget as the content
class ElTooltip extends StatefulWidget {
  const ElTooltip({
    required this.content,
    required this.child,
    this.color = Colors.white,
    this.distance = 10.0,
    this.padding = const EdgeInsets.all(14.0),
    this.position = ElTooltipPosition.topCenter,
    this.radius = 8.0,
    this.showModal = true,
    this.showArrow = true,
    this.showChildAboveOverlay = true,
    this.modalConfiguration = const ModalConfiguration(),
    this.timeout = Duration.zero,
    this.appearAnimationDuration = Duration.zero,
    this.disappearAnimationDuration = Duration.zero,
    super.key,
  });

  /// [child] Widget that will trigger the tooltip to appear.
  final Widget child;

  /// [color] Background color of the tooltip and the arrow.
  final Color color;

  /// [content] Widget that appears inside the tooltip.
  final Widget content;

  /// [distance] Space between the tooltip and the trigger.
  final double distance;

  /// [padding] Space inside the tooltip - around the content.
  final EdgeInsetsGeometry padding;

  /// [position] Desired tooltip position in relationship to the trigger.
  /// The default value it topCenter.
  final ElTooltipPosition position;

  /// [radius] Border radius around the tooltip.
  final double radius;

  /// [showModal] Shows a dark layer behind the tooltip.
  final bool showModal;

  /// [showArrow] Shows an arrow pointing to the trigger.
  final bool showArrow;

  /// [showChildAboveOverlay] Shows the child above the overlay.
  final bool showChildAboveOverlay;

  /// [timeout] Timeout until the tooltip disappears automatically
  /// The default value is 0 (zero) which means it never disappears.
  final Duration timeout;

  /// [modalConfiguration] Configures the [Modal] widget
  /// Only used if [showModal] is true
  final ModalConfiguration modalConfiguration;

  /// [appearAnimationDuration] Duration of the appear animation of the modal
  /// The default value is 0 which means it doesn't animate
  final Duration appearAnimationDuration;

  /// [disappearAnimationDuration] Duration of the disappear animation of the modal
  /// The default value is 0 which means it doesn't animate
  final Duration disappearAnimationDuration;

  @override
  State<ElTooltip> createState() => _ElTooltipState();
}

/// _ElTooltipState extends ElTooltip class
class _ElTooltipState extends State<ElTooltip> with WidgetsBindingObserver {
  final ElementBox _arrowBox = ElementBox(h: 10.0, w: 16.0);
  ElementBox _overlayBox = ElementBox(h: 0.0, w: 0.0);
  OverlayEntry? _overlayEntry;
  OverlayEntry? _overlayEntryHidden;
  final GlobalKey _widgetKey = GlobalKey();

  /// Automatically hide the overlay when the screen dimension changes
  /// or when the user scrolls. This is done to avoid displacement.
  @override
  void didChangeMetrics() {
    _hideOverlay();
  }

  /// Dispose the observer
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Init state and trigger the hidden overlay to measure its size
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _loadHiddenOverlay(context));
    WidgetsBinding.instance.addObserver(this);
  }

  ElementBox get _screenSize => _getScreenSize();

  ElementBox get _triggerBox => _getTriggerSize();

  /// Measures the hidden tooltip after it's loaded with _loadHiddenOverlay(_)
  void _getHiddenOverlaySize(context) {
    RenderBox box = _widgetKey.currentContext?.findRenderObject() as RenderBox;
    if (mounted) {
      setState(() {
        _overlayBox = ElementBox(
          w: box.size.width,
          h: box.size.height,
        );
        _overlayEntryHidden?.remove();
      });
    }
  }

  /// Loads the tooltip without opacity to measure the rendered size
  void _loadHiddenOverlay(_) {
    OverlayState? overlayStateHidden = Overlay.of(context);
    _overlayEntryHidden = OverlayEntry(
      builder: (context) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => _getHiddenOverlaySize(context));
        return Opacity(
          opacity: 0,
          child: Center(
            child: Bubble(
              key: _widgetKey,
              triggerBox: _triggerBox,
              padding: widget.padding,
              child: widget.content,
            ),
          ),
        );
      },
    );

    if (_overlayEntryHidden != null) {
      overlayStateHidden.insert(_overlayEntryHidden!);
    }
  }

  /// Measures the size of the trigger widget
  ElementBox _getTriggerSize() {
    if (mounted) {
      final renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      return ElementBox(
        w: renderBox.size.width,
        h: renderBox.size.height,
        x: offset.dx,
        y: offset.dy,
      );
    }
    _hideOverlay();
    return ElementBox(w: 0, h: 0, x: 0, y: 0);
  }

  /// Measures the size of the screen to calculate possible overflow
  ElementBox _getScreenSize() {
    return ElementBox(
      w: MediaQuery.of(context).size.width,
      h: MediaQuery.of(context).size.height,
    );
  }

  /// Hides or shows the tooltip
  void _toggleOverlay(BuildContext context) =>
      _overlayEntry != null ? _hideOverlay() : _showOverlay(context);

  /// Loads the tooltip into view
  void _showOverlay(BuildContext context) async {
    final overlayState = Overlay.of(context);

    /// By calling [PositionManager.load()] we get returned the position
    /// of the tooltip, the arrow and the trigger.
    ToolTipElementsDisplay toolTipElementsDisplay = PositionManager(
      arrowBox: _arrowBox,
      overlayBox: _overlayBox,
      triggerBox: _triggerBox,
      screenSize: _screenSize,
      distance: widget.distance,
      radius: widget.radius,
    ).load(preferredPosition: widget.position);

    _overlayEntry = OverlayEntry(
      builder: (context) => ElTooltipOverlay(
        toolTipElementsDisplay: toolTipElementsDisplay,
        color: widget.color,
        content: widget.content,
        hideOverlay: _hideOverlay,
        triggerBox: _triggerBox,
        arrowBox: _arrowBox,
        modalConfiguration: widget.modalConfiguration,
        padding: widget.padding,
        showArrow: widget.showArrow,
        showChildAboveOverlay: widget.showChildAboveOverlay,
        showModal: widget.showModal,
        appearAnimationDuration: widget.appearAnimationDuration,
        disappearAnimationDuration: widget.disappearAnimationDuration,
        child: widget.child,
      ),
    );

    if (_overlayEntry != null) {
      overlayState.insert(_overlayEntry!);
    }

    // Add timeout for the tooltip to disapear after a few seconds
    if (widget.timeout > Duration.zero) {
      await Future.delayed(widget.timeout).whenComplete(_hideOverlay);
    }
  }

  /// Method to hide the tooltip
  void _hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleOverlay(context),
      child: widget.child,
    );
  }
}
