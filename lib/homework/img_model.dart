class ImgModel {
  String id;
  String author;
  int width;
  int height;
  String url;
  String download_url;

  ImgModel({
    required this.id,
    required this.author,
    required this.width,
    required this.url,
    required this.height,
    required this.download_url,
  });

  static ImgModel empty() => ImgModel(
    id: "",
    author: "",
    width: 0,
    height: 0,
    url: "",
    download_url: "",
  );

  factory ImgModel.fromJson(Map<String, dynamic>? document) {
    return ImgModel(
      id: document?['id'] ?? "",
      author: document?['author'] ?? "",
      width: document?['width'] ?? 0,
      height: document?['height'] ?? 0,
      url: document?['url'] ?? "",
      download_url: document?['download_url'] ?? "",
    );
  }
}