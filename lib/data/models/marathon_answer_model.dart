class MarathonAnswerModel {
  late String id;
  late String title;
  late String content;
  late String modifiedTime;
  late String modifiedAnswerDate;
  late String answer;
  late String comment;

  MarathonAnswerModel(
    this.id,
    this.title,
    this.content,
    this.modifiedTime,
    this.modifiedAnswerDate,
    this.answer,
    this.comment,
  );

  MarathonAnswerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    modifiedTime = json['modifiedTime'];
    modifiedAnswerDate = json['modifiedAnswerDate'];
    answer = json['answer'];
    comment = json['comment'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'modifiedTime': modifiedTime,
      'modifiedAnswerDate': modifiedAnswerDate,
      'answer': answer,
      'comment': comment,
    };
  }
}
