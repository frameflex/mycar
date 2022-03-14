class Part {
  String name;
  double price;
  int id;
  // * this should be an int, but I have
  //* realized it very late.
  String garageId;

  Part({
    required this.garageId,
    required this.id,
    required this.price,
    required this.name,
  });

  factory Part.fromMap(Map<dynamic, dynamic> map) {
    return Part(
      name: map['name'].toString(),
      price: map['price'],
      id: map['id'],
      garageId: map['garageId'].toString(),
    );
  }
}
