import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:questions_4_u/CategoriesCountData.dart';
import 'package:questions_4_u/CategoriesData.dart';
import 'package:questions_4_u/CategoriesModal.dart';
import 'package:questions_4_u/components/Category.dart';
import 'package:questions_4_u/models/CategoryCountModel.dart';
import 'package:questions_4_u/models/CategoryModel.dart';
import 'package:questions_4_u/screens/QuestionScreen.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesScreen> {
  List<CategoryModel> categories = new List();
  Map<String, CategoryCountModel> categoriesCount;
  CategoriesModal modal = CategoriesModal();
  String error;
  void initState() {
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    final categoriesFuture = get('https://opentdb.com/api_category.php');
    final categoriesCountFuture =
        get("https://opentdb.com/api_count_global.php");
    final responses =
        await Future.wait([categoriesFuture, categoriesCountFuture]);
    final categoriesResponse = responses.elementAt(0);
    final categoriesCountResponse = responses.elementAt(1);

    if (categoriesResponse.statusCode == 200 &&
        categoriesCountResponse.statusCode == 200) {
      CategoriesData categoriesData =
          CategoriesData.fromJson(json.decode(categoriesResponse.body));
      final jsonDecoded = json.decode(categoriesCountResponse.body);
      CategoriesCountData categoriesCountData =
          CategoriesCountData.fromJson(jsonDecoded);

      this.setState(() {
        categories = categoriesData.triviaCategories;
        categoriesCount = categoriesCountData.categoriesCount;
      });
    } else {
      this.setState(() {
        error = "Une erreur s'est produite";
      });
    }
  }

  onCategoryPress(var category) {
    modal.mainBottomSheet(context, (difficulty) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestionScreen(
                categoryId: category.id,
                categoryName: category.name,
                difficulty: difficulty)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: this.categories == null
            ? this.error != null
                ? Center(
                    child: Text(this.error),
                  )
                : Center(child: CircularProgressIndicator())
            : Container(
                color: Color(0XFF6495ED),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(categories.length, (index) {
                    CategoryModel category = this.categories[index];
                    CategoryCountModel categoryCount =
                        this.categoriesCount[category.id.toString()];
                    return Category(
                        onTap: onCategoryPress,
                        category: category,
                        questionsNumber: categoryCount.questionsNumber);
                  }),
                )));
  }
}
