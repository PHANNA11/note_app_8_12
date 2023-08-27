import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:note_app/view/note_app/database/note_connection.dart';
import 'package:note_app/view/note_app/model/category_model.dart';
import 'package:note_app/view/note_app/model/note_model.dart';
import 'package:note_app/view/note_app/view/add_note_screen.dart';
import 'package:note_app/view/note_app/view/category_screen.dart';
import 'package:note_app/view/note_app/widget/note_widget.dart';
import 'package:note_app/view/note_app/widget/refresh_widget.dart';

import '../database/category_connection.dart';

class NoteHome extends StatefulWidget {
  const NoteHome({super.key});

  @override
  State<NoteHome> createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHome> {
  final searchController = TextEditingController();
  List<CategoryModel> categorys = [
    CategoryModel(categoryId: 0, categoryName: 'All'),
  ];
  Future<void> getCategoryData() async {
    await CategoryDatabase().getCategory().then((value) {
      setState(() {
        categorys.addAll(value);
      });
    });
  }

  Future<void> refreshCategoryData() async {
    categorys.clear();

    categorys = [
      CategoryModel(categoryId: 0, categoryName: 'All'),
    ];

    getCategoryData();
  }

  List<NoteModel> noteList = [];

  Future<void> getNotes() async {
    await NoteDatabase().getNotes().then((value) {
      setState(() {
        noteList = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Note'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (values) async {
                await NoteDatabase()
                    .searchResult(searchController.text)
                    .then((value) {
                  setState(() {
                    noteList = value;
                  });
                });
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                  hintText: 'search note'),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Flexible(
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    //color: Colors.red,
                    child: ListView.builder(
                      itemCount: categorys.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              categorys[index].categoryName,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(),
                        ));
                  },
                  child: SizedBox(
                    height: 60,
                    width: 70,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.create_new_folder_rounded,
                                size: 35,
                              ))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: RefreshWidget(
                    onRefresh: getNotes,
                    child: ListView.builder(
                        itemCount: noteList.length,
                        itemBuilder: (context, index) =>
                            NoteWidget().noteCard(noteList[index])))
                .buildAndroid(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddUpdateNoteScreen(category: categorys[1]),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
