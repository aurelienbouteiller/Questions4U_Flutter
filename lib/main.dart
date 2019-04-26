import 'package:flutter/material.dart';
import 'package:questions_4_u/screens/CategoriesScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CategoriesScreen(title: 'Categories list'),
    );
  }
}
