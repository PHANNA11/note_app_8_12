import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_app/view/note_app/database/note_connection.dart';
import 'package:note_app/view/note_app/model/note_model.dart';
import 'package:note_app/view/note_app/view/add_note_screen.dart';

class NoteWidget {
  Widget noteCard(NoteModel note) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            // dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                onPressed: (context) async {
                  await NoteDatabase().deleteNote(note);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                onPressed: (context) async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddUpdateNoteScreen(note: note),
                      ));
                },
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.edit_document,
                label: 'Edit',
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(4),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            note.body,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white24,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    note.date,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white24,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
