import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../viewmodels/note_viewmodel.dart';

class NoteEditView extends StatefulWidget {
  final Note? note;

  NoteEditView({this.note});

  @override
  _NoteEditViewState createState() => _NoteEditViewState();
}

class _NoteEditViewState extends State<NoteEditView> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<NoteViewModel>(context, listen: false).deleteNote(widget.note!.id);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.note == null) {
                  final newNote = Note(
                    id: DateTime.now().toString(),
                    title: _titleController.text,
                    content: _contentController.text,
                  );
                  Provider.of<NoteViewModel>(context, listen: false).addNote(newNote);
                } else {
                  final updatedNote = Note(
                    id: widget.note!.id,
                    title: _titleController.text,
                    content: _contentController.text,
                  );
                  Provider.of<NoteViewModel>(context, listen: false).updateNote(updatedNote);
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
