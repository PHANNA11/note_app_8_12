import 'package:note_app/view/note_app/database/varriable.dart';

class NoteModel {
  late int id;
  late String title;
  late String body;
  late String date;
  late int categoryId;
  NoteModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.date,
      required this.categoryId});
  Map<String, dynamic> toMap() {
    return {
      noteId: id,
      noteBody: body,
      noteTitle: title,
      noteDate: date,
      fcategoryId: categoryId
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> res) {
    return NoteModel(
        id: res[noteId],
        title: res[noteTitle],
        body: res[noteBody],
        date: res[noteDate],
        categoryId: res[fcategoryId]);
  }
}
