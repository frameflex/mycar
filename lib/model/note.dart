class Note {
  String name;
  int id;
  // * this should be an int, but I have
  //* realized it very late.
  String garageIdN;

  Note({
    required this.garageIdN,
    required this.id,
    required this.name,
  });

  factory Note.fromMap(Map<dynamic, dynamic> map) {
    return Note(
      name: map['noteName'].toString(),
      id: map['id'],
      garageIdN: map['garageIdN'].toString(),
    );
  }
}
