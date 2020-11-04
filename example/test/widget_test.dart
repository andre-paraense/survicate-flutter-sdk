import 'package:flutter_test/flutter_test.dart';

import 'package:survicate_flutter_sdk_example/main.dart';

void main() {
  testWidgets('Verify building and triggering a frame', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
  });
}
