import 'package:el_tooltip/el_tooltip.dart';
import 'package:el_tooltip/src/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';

/// Unit Test for the tooltip (not done)
void main() {
  const key = Key('test');

  testWidgets('Provided key is used', (tester) async {
    await tester.pumpWidget(
        ElTooltip(key: key, content: Container(), child: Container()));
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
  const TestWidget({
    required this.content,
    this.color = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElTooltip(
            color: color,
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
