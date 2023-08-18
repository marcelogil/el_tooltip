import 'package:el_tooltip/src/enum/el_tooltip_status.dart';
import 'package:flutter/material.dart';

typedef ShowElTooltip = Future<void> Function();
typedef HideElTooltip = Future<void> Function();

class ElTooltipController extends ValueNotifier<ElTooltipStatus> {
  ElTooltipController()
      : _show = _defaultThrow,
        _hide = _defaultThrow,
        super(ElTooltipStatus.hidden);

  Future<void> show() async {
    await _show();
    value = ElTooltipStatus.showing;
    notifyListeners();
  }

  Future<void> hide() async {
    await _hide();
    value = ElTooltipStatus.hidden;
    notifyListeners();
  }

  late ShowElTooltip _show;
  late HideElTooltip _hide;

  static Future<void> _defaultThrow() {
    throw StateError('Attach the controller to an El Tooltip Widget');
  }

  @mustCallSuper
  void attach({required ShowElTooltip show, required HideElTooltip hide}) {
    _show = show;
    _hide = hide;
  }
}
