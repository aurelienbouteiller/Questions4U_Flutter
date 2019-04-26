import 'package:flutter/material.dart';

class CategoriesModal {
  mainBottomSheet(BuildContext context, Function onTap) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(context, 'Easy', Icons.cake, () => onTap('easy')),
              _createTile(context, 'Medium', Icons.sentiment_satisfied,
                  () => onTap('medium')),
              _createTile(context, 'Hard', Icons.whatshot, () => onTap('hard')),
            ],
          );
        });
  }

  ListTile _createTile(
      BuildContext context, String name, IconData icon, Function action) {
    return ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(name),
        onTap: () {
          Navigator.pop(context);
          action();
        });
  }
}
