class Garage {
  int id;
  String name;
  String engine;
  String horsePower;
  String year;
  String colorCode;
  DateTime purchaseDate;
  String wheelName;
  String va;
  String ha;
  DateTime lastOilChange;
  String purchasePrice;
  String image;
  DateTime tuvDate;

  Garage({
    required this.id,
    required this.tuvDate,
    required this.image,
    required this.name,
    required this.engine,
    required this.horsePower,
    required this.year,
    required this.colorCode,
    required this.purchaseDate,
    required this.wheelName,
    required this.va,
    required this.ha,
    required this.lastOilChange,
    required this.purchasePrice,
  });

  factory Garage.fromMap(Map json) => Garage(
        id: json["id"],
        image: json["image"].toString(),
        name: json["name"].toString(),
        engine: json["engine"].toString(),
        horsePower: json["horsePower"].toString(),
        year: json["year"].toString(),
        colorCode: json["colorCode"].toString(),
        purchaseDate: DateTime.fromMillisecondsSinceEpoch(json["purchaseDate"]),
        wheelName: json["wheelName"].toString(),
        va: json["va"].toString(),
        ha: json["ha"].toString(),
        lastOilChange:
            DateTime.fromMillisecondsSinceEpoch(json["lastOilChange"]),
        purchasePrice: json["purchasePrice"].toString(),
        tuvDate: DateTime.fromMillisecondsSinceEpoch(json["tuvDate"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "name": name,
        "engine": engine,
        "horsePower": horsePower,
        "year": year,
        "colorCode": colorCode,
        "purchaseDate": purchaseDate.millisecondsSinceEpoch,
        "wheelName": wheelName,
        "va": va,
        "ha": ha,
        "lastOilChange": lastOilChange.millisecondsSinceEpoch,
        "purchasePrice": purchasePrice,
        "tuvDate": tuvDate.millisecondsSinceEpoch,
      };
}
