import 'package:flutter/material.dart';
import 'package:notly/services/crud/notes_service.dart';
import 'package:notly/utilities/dialogs/delete_dialog.dart';

typedef DeleteNoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final DeleteNoteCallback oneDeleteNote;

  const NotesListView({
    super.key,
    required this.notes,
    required this.oneDeleteNote,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                oneDeleteNote(note);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
