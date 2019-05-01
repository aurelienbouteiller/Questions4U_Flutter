class QuestionHistoryModel {
  bool isCorrectAnswer;
  String question;
  String answer;

  QuestionHistoryModel({this.question, this.answer, this.isCorrectAnswer});

  QuestionHistoryModel.fromJson(Map<String, dynamic> json)
      : question = json['question'],
        answer = json['answer'],
        isCorrectAnswer = json['isCorrectAnswer'];

  Map<String, dynamic> toJson() => {
        'question': question,
        'answer': answer,
        'isCorrectAnswer': isCorrectAnswer,
      };
}
