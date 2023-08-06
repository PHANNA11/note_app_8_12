import 'package:flutter/material.dart';
import 'package:note_app/view/note_app/model/note_model.dart';

class NoteWidget {
  Widget noteCard(NoteModel note) => Padding(
        padding: const EdgeInsets.all(8.0),
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
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          note.body,
                          style: TextStyle(
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
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white24,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ),
      );
}
