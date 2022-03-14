class Document {
  String image;
  int id;
  String name;
  int garageId;

  Document({
    required this.id,
    required this.garageId,
    required this.image,
    required this.name,
  });

  static Document fromMap(Map<dynamic, dynamic> json) {
    return Document(
      id: json["id"],
      garageId: json["garageId"],
      image: json["image"].toString(),
      name: json["name"].toString(),
    );
  }
}
