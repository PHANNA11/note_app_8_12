import 'package:note_app/view/note_app/database/varriable.dart';

class NoteModel {
  late int id;
  late String title;
  late String body;
  late String date;
  NoteModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.date});
  Map<String, dynamic> toMap() {
    return {noteId: id, noteBody: body, noteTitle: title, noteDate: date};
  }

  factory NoteModel.fromMap(Map<String, dynamic> res) {
    return NoteModel(
        id: res[noteId],
        title: res[noteTitle],
        body: res[noteBody],
        date: res[noteDate]);
  }
}
