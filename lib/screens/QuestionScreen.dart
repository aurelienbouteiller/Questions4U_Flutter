import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import "package:html_unescape/html_unescape.dart";
import 'package:flare_flutter/flare_actor.dart';
import 'package:questions_4_u/Question.dart';
import 'package:questions_4_u/QuestionCard.dart';
import 'package:questions_4_u/models/QuestionHistoryModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionScreen extends StatefulWidget {
  final Widget child;
  final int categoryId;
  final String categoryName;
  final String difficulty;

  QuestionScreen(
      {Key key,
      this.categoryId,
      this.categoryName,
      this.difficulty,
      this.child})
      : super(key: key);

  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final unescape = HtmlUnescape();
  final answers = List();
  bool questionLoading = true;
  bool reloadQuestionLoading = false;
  bool answered = false;
  Question questionInfo;

  @override
  void initState() {
    super.initState();
    this.loadQuestionInfo(widget.categoryId, widget.difficulty, false);
  }

  void loadQuestionInfo(categoryId, difficulty, reload) async {
    this.setState(() {
      if (reload == true) {
        this.reloadQuestionLoading = true;
        this.answered = false;
      }
      this.questionLoading = true;
    });
    final response = await get(
        'https://opentdb.com/api.php?amount=1&category=$categoryId&difficulty=$difficulty');
    if (response.statusCode == 200) {
      final QuestionData questionData =
          QuestionData.fromJson(json.decode(response.body));
      this.setState(() {
        this.questionLoading = false;
        this.reloadQuestionLoading = false;
        this.questionInfo = questionData.results[0];
      });
    } else {
      throw Exception('Failed to load question info');
    }
  }

  void onAnswerPress(answer) async {
    final bool isCorrectAnswer = this.questionInfo.correctAnswer == answer;
    var questionsHistory = <QuestionHistoryModel>[];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String questionsHistoryJSON = prefs.getString('questionsHistory');
    print("JSON: $questionsHistoryJSON");
    if (questionsHistoryJSON != null) {
      final List questionsHistorySaved = jsonDecode(questionsHistoryJSON);
      questionsHistory = questionsHistorySaved.map<QuestionHistoryModel>((elt) => QuestionHistoryModel.fromJson(elt)).toList();
      print("newList: $questionsHistory, ${questionsHistory.runtimeType}");
    }

    QuestionHistoryModel questionHistory = QuestionHistoryModel(
        question: this.questionInfo.question,
        isCorrectAnswer: isCorrectAnswer,
        answer: this.questionInfo.correctAnswer);
    questionsHistory.add(questionHistory);
    String questionHistoryEncoded = jsonEncode(questionsHistory);
    await prefs.setString('questionsHistory', questionHistoryEncoded);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          var flareFilename = isCorrectAnswer ? "goodAnswer" : "wrongAnswer";
          return Center(
            child: Container(
              height: 200,
              width: 200,
              child: FlareActor("assets/$flareFilename.flr",
                  alignment: Alignment.center,
                  animation: "Checked",
                  shouldClip: false),
            ),
          );
        });
    this.setState(() {
      this.answered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Question time")),
        body: Container(
          color: Color(0XFF6495ED),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Text(
                      widget.categoryName,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: this.questionLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        child: Center(
                        child: QuestionCard(
                            unescape: unescape,
                            questionInfo: questionInfo,
                            onAnswerPress: this.onAnswerPress,
                            answered: this.answered,
                            answers: ([this.questionInfo.correctAnswer]
                                  ..addAll(this.questionInfo.incorrectAnswers))
                                .toList()
                                  ..sort()),
                      )),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => this.loadQuestionInfo(
                          this.widget.categoryId, this.widget.difficulty, true),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1)),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: this.reloadQuestionLoading
                                          ? CircularProgressIndicator()
                                          : Icon(
                                              Icons.refresh,
                                              size: 30,
                                            )),
                                  Text(
                                    "NEW QUESTION",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
