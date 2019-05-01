import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsHistory extends StatefulWidget {
  QuestionsHistory({Key key}) : super(key: key);

  _QuestionsHistoryState createState() => _QuestionsHistoryState();
}

class _QuestionsHistoryState extends State<QuestionsHistory> {
  @override
  void initState() {
    super.initState();
    loadQuestionsHistory();
  }

  loadQuestionsHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String questionsHistory = prefs.getString('questionsHistory');
    print(questionsHistory);
  }

  @override
  Widget build(BuildContext context) => Container(
        child: Container(),
      );
}
