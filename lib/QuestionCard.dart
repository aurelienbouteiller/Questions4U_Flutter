import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:questions_4_u/Answer.dart';
import 'package:questions_4_u/Question.dart';
import 'package:flare_flutter/flare_actor.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key key,
    @required this.unescape,
    @required this.questionInfo,
    @required this.answers,
  }) : super(key: key);

  final HtmlUnescape unescape;
  final Question questionInfo;
  final List<String> answers;

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool answered = false;
  void onAnswerPress(answer) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var flareFilename = this.widget.questionInfo.correctAnswer == answer
              ? "goodAnswer"
              : "wrongAnswer";
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
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                widget.unescape.convert(widget.questionInfo.question),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Column(
            children: List.generate(
                widget.answers.length,
                (index) => Answer(
                    answer: widget.answers[index],
                    questionInfo: widget.questionInfo,
                    isCorrectAnswer: widget.questionInfo.correctAnswer ==
                        widget.answers[index],
                    onPress: () => onAnswerPress(widget.answers[index]),
                    answered: this.answered)),
          ),
        ],
      ),
    );
  }
}
