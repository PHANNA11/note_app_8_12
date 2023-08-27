import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:note_app/view/note_app/database/category_connection.dart';
import 'package:note_app/view/note_app/widget/formfield_widget.dart';
import 'package:note_app/view/note_app/widget/refresh_widget.dart';

import '../model/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
    textController.text = 'Unnamed folder';
    getCategoryData();
  }

  @override
  void initState() {
    // TODO: implement initState
    getCategoryData();
    super.initState();
  }

  final textController = TextEditingController(text: 'Unnamed folder');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: RefreshWidget(
        onRefresh: refreshCategoryData,
        child: ListView.builder(
            itemCount: categorys.length + 1,
            itemBuilder: (context, index) {
              return index + 1 == categorys.length + 1
                  ? buildCategoryAddCard()
                  : buildCategoryItem(category: categorys[index]);
            }),
      ).buildAndroid(context),
    );
  }

  Widget buildCategoryItem({CategoryModel? category}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(4),
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category!.categoryName.toString(),
                style: const TextStyle(fontSize: 18),
              ),
              const Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  '44',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white24,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryNonItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(4),
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'All',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '7',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryAddCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => buildAddCardDialog(),
          );
        },
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CircleAvatar(
                  maxRadius: 15,
                  backgroundColor: Colors.amber,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'New folder',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddCardDialog() {
    return AlertDialog(
      title: const Center(child: Text('New folder')),
      content: Container(
        height: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        child: FromFieldWidget(
          label: 'Input',
          hinText: 'folder name',
          controller: textController,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 20, color: Colors.red),
            )),
        TextButton(
            onPressed: () async {
              await CategoryDatabase()
                  .insertCategory(CategoryModel(
                      categoryId: DateTime.now().microsecondsSinceEpoch,
                      categoryName: textController.text))
                  .whenComplete(() {
                setState(() {
                  refreshCategoryData();
                });
                Navigator.pop(context);
              });
            },
            child: const Text(
              'Ok',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ))
      ],
    );
  }
}
