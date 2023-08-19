import 'package:el_tooltip/el_tooltip.dart';
import 'package:el_tooltip/src/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Unit Test for the tooltip (not done)
void main() {
  const key = Key('test');

  testWidgets('Provided key is used', (tester) async {
    await tester.pumpWidget(TestWidget(content: Container(), tooltipKey: key));
    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets('Content is shown after clicking on child', (tester) async {
    const Widget content = Text('Hello world');
    await tester.pumpWidget(const TestWidget(key: key, content: content));
    var button = find.byType(TestTrigger);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.byWidget(content), findsOneWidget);
  });

  testWidgets('Provided color is used', (tester) async {
    const Widget content = Text('Hello world');
    await tester.pumpWidget(const TestWidget(
      key: key,
      content: content,
      color: Colors.red,
    ));
    var button = find.byType(TestTrigger);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.byWidget(content), findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Bubble && widget.color == Colors.red),
        findsOneWidget);
  });
}

class TestWidget extends StatelessWidget {
  final Widget content;
  final Color color;
  final Key? tooltipKey;

  const TestWidget({
    required this.content,
    this.color = Colors.white,
    this.tooltipKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElTooltip(
            color: color,
            key: tooltipKey,
            content: content,
            child: const TestTrigger(),
          ),
        ),
      ),
    );
  }
}

class TestTrigger extends StatelessWidget {
  const TestTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Clica');
  }
}
