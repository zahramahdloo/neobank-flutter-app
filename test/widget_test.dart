import 'package:flutter_test/flutter_test.dart';
import 'package:neo_bank/main.dart';

void main() {
  testWidgets('NeoBank debug smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NeoBankApp());

    expect(find.text('NeoBank debug works'), findsOneWidget);
  });
}
