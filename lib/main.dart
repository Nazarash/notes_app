import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/note_viewmodel.dart';
import 'views/note_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteViewModel(),
      child: MaterialApp(
        title: 'My Notes App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NoteListView(),
      ),
    );
  }
}
