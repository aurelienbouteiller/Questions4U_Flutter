import 'package:questions_4_u/models/CategoryCountModel.dart';

class CategoriesCountData {
  Map<String, CategoryCountModel> categoriesCount;

  CategoriesCountData({this.categoriesCount});

  CategoriesCountData.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categoriesCount = Map<String, CategoryCountModel>();
      json['categories'].forEach((String f, dynamic v) {
        categoriesCount[f] = CategoryCountModel.fromJson(f, v);
      });
    }
  }
}
