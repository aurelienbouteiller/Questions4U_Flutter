class CategoryCountModel {
  int questionsNumber;

  CategoryCountModel({this.questionsNumber});

  CategoryCountModel.fromJson(String categoryId, Map<String, dynamic> json) {
    questionsNumber = json['total_num_of_questions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionsNumber'] = this.questionsNumber;
    return data;
  }
}
