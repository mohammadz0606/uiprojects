final class HomeModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  const HomeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "imageUrl": imageUrl,
    };
  }

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      imageUrl: json["imageUrl"],
    );
  }

}
