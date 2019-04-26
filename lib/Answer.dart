import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'Question.dart';

final unescape = HtmlUnescape();

class Answer extends StatefulWidget {
  const Answer(
      {Key key,
      @required this.answer,
      @required this.questionInfo,
      @required this.onPress,
      @required this.isCorrectAnswer,
      @required this.answered})
      : super(key: key);

  final String answer;
  final Question questionInfo;
  final Function onPress;
  final bool isCorrectAnswer;
  final bool answered;

  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: (widget.answered && widget.isCorrectAnswer) ||
                    (this.showAnswer == true)
                ? widget.isCorrectAnswer ? Colors.green[700] : Colors.red[700]
                : Colors.white,
            border: Border.all(color: Colors.grey, width: 1)),
        margin: EdgeInsets.all(10),
        child: FlatButton(
          child: Text(
            unescape.convert(widget.answer),
            style: TextStyle(
                fontSize: 16,
                color: (widget.answered && widget.isCorrectAnswer) ||
                        (this.showAnswer == true)
                    ? Colors.white
                    : Colors.black),
          ),
          onPressed: widget.answered
              ? null
              : () {
                  this.setState(() {
                    this.showAnswer = true;
                  });
                  widget.onPress();
                },
        ));
  }
}
