library el_tooltip;

import 'package:flutter/material.dart';
import 'el_tooltip_assets/arrow.dart';
import 'el_tooltip_assets/bubble.dart';
import 'el_tooltip_assets/element_box.dart';
import 'el_tooltip_assets/enum/el_tooltip_position.dart';
import 'el_tooltip_assets/modal.dart';
import 'el_tooltip_assets/position_manager.dart';
import 'el_tooltip_assets/tooltip_elements_display.dart';

export 'el_tooltip_assets/enum/el_tooltip_position.dart';

/// Widget that displays a tooltip
/// It takes a widget as the trigger and a widget as the content
class ElTooltip extends StatefulWidget {
  final Widget content;
  final Widget trigger;
  final Color color;
  final double distance;
  final double padding;
  final ElTooltipPosition position;
  final double radius;
  final bool showModal;
  final int timeout;

  const ElTooltip({
    required this.content,
    required this.trigger,
    this.color = Colors.white,
    this.distance = 10.0,
    this.padding = 14.0,
    this.position = ElTooltipPosition.topCenter,
    this.radius = 8.0,
    this.showModal = true,
    this.timeout = 0,
    super.key,
  });
  @override
  State<ElTooltip> createState() => _ElTooltipState();
}

class _ElTooltipState extends State<ElTooltip> with WidgetsBindingObserver {
  final GlobalKey _widgetKey = GlobalKey();
  OverlayEntry? _overlayEntryHidden;
  OverlayEntry? _overlayEntry;
  ElementBox get _screenSize => _getScreenSize();
  ElementBox get _triggerBox => _getTriggerSize();
  ElementBox _overlayBox = ElementBox(h: 0.0, w: 0.0);
  final ElementBox _arrowBox = ElementBox(h: 10.0, w: 16.0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _loadHiddenOverlay(context));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _hideOverlay();
  }

  /// Measures the hidden tooltip after it's loaded with _loadHiddenOverlay(_)
  void _getHiddenOverlaySize(context) {
    RenderBox box = _widgetKey.currentContext?.findRenderObject() as RenderBox;
    setState(() {
      _overlayBox = ElementBox(
        w: box.size.width,
        h: box.size.height,
      );
      _overlayEntryHidden?.remove();
    });
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
    overlayStateHidden?.insert(_overlayEntryHidden!);
  }

  /// Measures the size of the trigger widget
  ElementBox _getTriggerSize() {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    return ElementBox(
      w: renderBox.size.width,
      h: renderBox.size.height,
      x: offset.dx,
      y: offset.dy,
    );
  }

  /// Measures the size of the screen to calculate possible overflow
  ElementBox _getScreenSize() {
    return ElementBox(
      w: MediaQuery.of(context).size.width,
      h: MediaQuery.of(context).size.height,
    );
  }

  /// Loads the tooltip into view
  void _showOverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);

    ToolTipElementsDisplay toolTipElementsDisplay = PositionManager(
      arrowBox: _arrowBox,
      overlayBox: _overlayBox,
      triggerBox: _triggerBox,
      screenSize: _screenSize,
      distance: widget.distance,
      radius: widget.radius,
    ).load(preferredPosition: widget.position);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Modal(
              color: Colors.black87,
              opacity: 0.7,
              visible: widget.showModal,
              onTap: () {
                _hideOverlay();
              },
            ),
            Positioned(
              top: toolTipElementsDisplay.bubble.y,
              left: toolTipElementsDisplay.bubble.x,
              child: Bubble(
                triggerBox: _triggerBox,
                padding: widget.padding,
                radius: toolTipElementsDisplay.radius,
                color: widget.color,
                child: widget.content,
              ),
            ),
            Positioned(
              top: toolTipElementsDisplay.arrow.y,
              left: toolTipElementsDisplay.arrow.x,
              child: Arrow(
                color: widget.color,
                position: toolTipElementsDisplay.position,
                width: _arrowBox.w,
                height: _arrowBox.h,
              ),
            ),
            Positioned(
              top: _triggerBox.y,
              left: _triggerBox.x,
              child: GestureDetector(
                onTap: () {
                  _overlayEntry != null
                      ? _hideOverlay()
                      : _showOverlay(context);
                },
                child: widget.trigger,
              ),
            ),
          ],
        );
      },
    );

    overlayState?.insert(_overlayEntry!);

    if (widget.timeout > 0) {
      await Future.delayed(Duration(seconds: widget.timeout))
          .whenComplete(() => _hideOverlay());
    }
  }

  void _hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _overlayEntry != null ? _hideOverlay() : _showOverlay(context);
      },
      child: widget.trigger,
    );
  }
}
