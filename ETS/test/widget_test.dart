import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart'; // Pastikan ini diimpor dengan benar!
import 'package:flutter_application_1/screens/home_screen.dart'; // Import HomeScreen if it exists in this file.

void main() {
  testWidgets('MyApp has a title', (WidgetTester tester) async {
    // Build MyApp and trigger a frame.
    await tester.pumpWidget(const LibraryApp());

    // Verify that MyApp contains the title.
    expect(find.text('Library App'), findsOneWidget);
    

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
