class MarathonModel {
  late String id;
  late String title;
  late String content;
  late String modifiedTime;

  MarathonModel(
    this.id,
    this.title,
    this.content,
    this.modifiedTime,
  );

  MarathonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    modifiedTime = json['modifiedTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'modifiedTime': modifiedTime,
    };
  }
}
