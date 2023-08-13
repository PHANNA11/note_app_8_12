import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:note_app/view/note_app/widget/formfield_widget.dart';

import '../database/note_connection.dart';
import '../model/note_model.dart';

class AddUpdateNoteScreen extends StatefulWidget {
  const AddUpdateNoteScreen({super.key});

  @override
  State<AddUpdateNoteScreen> createState() => _AddUpdateNoteScreenState();
}

class _AddUpdateNoteScreenState extends State<AddUpdateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
      ),
      body: Column(
        children: [
          FromFieldWidget(
            label: 'Title',
            hinText: 'Title',
            controller: titleController,
          ),
          FromFieldWidget(
            label: 'Body',
            hinText: 'Description',
            controller: bodyController,
          ),
          FromFieldWidget(
            readOnly: true,
            label: 'Date',
            hinText: 'Select date',
            controller: dateController,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await NoteDatabase()
              .insertNote(NoteModel(
                  id: DateTime.now().microsecondsSinceEpoch,
                  title: titleController.text,
                  body: bodyController.text,
                  date: dateController.text))
              .whenComplete(() => Navigator.pop(context));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
