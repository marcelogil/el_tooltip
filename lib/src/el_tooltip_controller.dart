import 'package:el_tooltip/src/enum/el_tooltip_status.dart';
import 'package:flutter/material.dart';

typedef ShowElTooltip = Future<void> Function();
typedef HideElTooltip = Future<void> Function();

class ElTooltipController extends ValueNotifier<ElTooltipStatus> {
  ElTooltipController()
      : show = _defaultThrow,
        hide = _defaultThrow,
        super(ElTooltipStatus.hidden);

  late ShowElTooltip show;
  late HideElTooltip hide;

  static Future<void> _defaultThrow() {
    throw StateError('Attach the controller to an El Tooltip Widget');
  }

  @mustCallSuper
  void attach({required ShowElTooltip show, required HideElTooltip hide}) {
    this.show = show;
    this.hide = hide;
  }
}
