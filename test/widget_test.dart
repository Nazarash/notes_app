// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:my_notes_app/main.dart';
import 'package:my_notes_app/viewmodels/note_viewmodel.dart';

void main() {
  testWidgets('Add, edit, and delete a note', (WidgetTester tester) async {
    // Initialize the app
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => NoteViewModel(),
        child: MyApp(),
      ),
    );

    // Verify the main screen shows an empty list
    expect(find.text('My Notes'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);

    // Tap the add note button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify the add note screen is displayed
    expect(find.text('Add Note'), findsOneWidget);

    // Enter title and content
    await tester.enterText(find.byType(TextField).at(0), 'Test Note');
    await tester.enterText(find.byType(TextField).at(1), 'This is a test note.');

    // Save the note
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify the note is added to the list
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('Test Note'), findsOneWidget);

    // Tap the note to edit
    await tester.tap(find.text('Test Note'));
    await tester.pumpAndSettle();

    // Verify the edit note screen is displayed
    expect(find.text('Edit Note'), findsOneWidget);

    // Edit the note
    await tester.enterText(find.byType(TextField).at(0), 'Updated Test Note');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify the note is updated in the list
    expect(find.text('Updated Test Note'), findsOneWidget);
    expect(find.text('Test Note'), findsNothing);

    // Delete the note
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Verify the note is deleted from the list
    expect(find.byType(ListTile), findsNothing);
  });
}
