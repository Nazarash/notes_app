import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/note_viewmodel.dart';
import '../models/note.dart';
import 'note_edit_view.dart';

class NoteListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
      ),
      body: Consumer<NoteViewModel>(
        builder: (context, noteViewModel, child) {
          return ListView.builder(
            itemCount: noteViewModel.notes.length,
            itemBuilder: (context, index) {
              final note = noteViewModel.notes[index];
              return ListTile(
                title: Text(note.title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteEditView(note: note),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditView(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
