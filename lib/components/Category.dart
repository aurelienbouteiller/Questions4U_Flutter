import 'package:flutter/material.dart';
import 'package:questions_4_u/models/CategoryModel.dart';

class Category extends StatelessWidget {
  final Function onTap;
  final CategoryModel category;
  final int questionsNumber;

  Category(
      {Key key,
      @required this.category,
      @required this.questionsNumber,
      @required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => this.onTap(category),
        child: Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                this.category.name,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  height: 0,
                  color: Colors.black,
                ),
              ),
              Text(
                "$questionsNumber questions",
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      );
}
