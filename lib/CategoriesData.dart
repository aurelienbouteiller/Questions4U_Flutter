import 'package:questions_4_u/models/CategoryModel.dart';

class CategoriesData {
  List<CategoryModel> triviaCategories;

  CategoriesData({this.triviaCategories});

  CategoriesData.fromJson(Map<String, dynamic> json) {
    if (json['trivia_categories'] != null) {
      triviaCategories = new List<CategoryModel>();
      json['trivia_categories'].forEach((v) {
        triviaCategories.add(new CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.triviaCategories != null) {
      data['trivia_categories'] =
          this.triviaCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
