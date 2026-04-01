class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({
    this.userId = 0,
    this.id = 0,
    this.title = "",
    this.body = "",
  });

  factory Post.fromMap(Map<String, dynamic> json) => Post(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> get toMap => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}