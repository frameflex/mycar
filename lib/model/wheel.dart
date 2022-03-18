class Wheel {
  String name; //model name
  String brand; //brand name
  String etFront; //Einpresstiefe vorn
  String etBack; //Einpresstiefe hinten
  String lk; // Lochkreis
  String sizeFront; //Zoll Größe vorn
  String sizeBack; //Zoll Größe hinten
//  String tireSizeFront; //Reifen größe vorn
//  String tireName;
//  String tireSizeBack;//Reifen größe hinten

 double price;
  int id;
  //* this should be an int, but I have
  //* realized it very late.
  String garageId;

  Wheel({
    required this.garageId,
    required this.id,
    required this.price,
    required this.name,
    required this.brand,
    required this.etFront,
    required this.etBack,
    required this.lk,
    required this.sizeFront,
    required this.sizeBack,

  });

  factory Wheel.fromMap(Map<dynamic, dynamic> map) {
    return Wheel(
      name: map['name'].toString(),
      brand: map['brand'].toString(),
      etFront: map['etFront'].toString(),
      etBack: map['etBack'].toString(),
      lk: map['Lk'].toString(),
      sizeFront: map['sizeFront'].toString(),
      sizeBack: map['sizeBack'].toString(),


      price: map['price'],
      id: map['id'],
      garageId: map['garageId'].toString(),
    );
  }
}
