import '../database/varriable.dart';

class CategoryModel {
  late int categoryId;
  late String categoryName;
  CategoryModel({required this.categoryId, required this.categoryName});
  Map<String, dynamic> toJson() {
    return {fcategoryId: categoryId, fcategoryName: categoryName};
  }

  CategoryModel.fromJson(Map<String, dynamic> res)
      : categoryId = res[fcategoryId],
        categoryName = res[fcategoryName];
}
