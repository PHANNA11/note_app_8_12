import 'dart:developer';
import 'dart:io';
import 'package:note_app/view/note_app/database/varriable.dart';
import 'package:note_app/view/note_app/model/category_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDatabase {
  Future<Database> initializeDatabase() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'categorynotesdb.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $categoryTableName($fcategoryId INTEGER PRIMARY KEY, $fcategoryName TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertCategory(CategoryModel category) async {
    var db = await initializeDatabase();
    await db.insert(categoryTableName, category.toJson());
    log('add category done');
  }

  Future<List<CategoryModel>> getCategory() async {
    var db = await initializeDatabase();
    List<Map<String, dynamic>> result = await db.query(categoryTableName);
    return result.map((e) => CategoryModel.fromJson(e)).toList();
  }

  Future<void> deleteContagory({required int? categoryId}) async {
    var db = await initializeDatabase();
    await db.delete(categoryTableName,
        where: '$fcategoryId=?', whereArgs: [categoryId]);
  }

  Future<void> updateCategory({CategoryModel? categoryModel}) async {
    var db = await initializeDatabase();
    await db.update(categoryTableName, categoryModel!.toJson(),
        where: '$fcategoryId=?', whereArgs: [categoryModel.categoryId]);
  }
}
