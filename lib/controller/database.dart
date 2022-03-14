// ? we will use sqflite database
// ? this is will use sql database to store, read, update, delete
// ? our data

import 'package:flutter/material.dart';
import 'package:mycar/model/garage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

import '../model/document.dart';
import '../model/part.dart';

class MyDB {
  late Database myDB;

  Future<void> start() async {
    try {
      myDB = await openDatabase(
        'myDBUpdated.db',
        version: 2,
        onCreate: (Database db, int version) async {
          debugPrint("creating new db");
          await db.execute(
            'CREATE TABLE Garage(id INTEGER PRIMARY KEY AUTOINCREMENT , image TEXT,name STRING, engine STRING, colorCode STRING, horsePower STRING, year STRING, purchaseDate INTEGER, wheelName STRING, va STRING, ha STRING, lastOilChange INTEGER, purchasePrice STRING, tuvDate INTEGER)',
          );
          await db.execute(
            'CREATE TABLE Document(id INTEGER PRIMARY KEY AUTOINCREMENT , name STRING, garageId INTEGER, image STRING)',
          );
          await db.execute(
            'CREATE TABLE Part(id INTEGER PRIMARY KEY AUTOINCREMENT , name STRING, garageId INTEGER, price REAL)',
          );
        },
      );
    } catch (e) {
      debugPrint('error in starting database, $e');
      Get.showSnackbar(
        const GetSnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          title: "Error",
          titleText: Text(
            'Error in starting database',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  // ? read data

  void readData() async {
    List<Map> list = await myDB.query(
      'Garage',
    );

    debugPrint(list.toString());

    Garage vario = Garage.fromMap(list[0]);

    debugPrint(
      vario.name,
    );
  }

  // ! used this just to delete an entry

  // void close() {
  //   debugPrint("deleting value");
  //   myDB.delete(
  //     'Garage',
  //     where: "id",
  //   );
  // }

  void updateImage(imgURL) {
    debugPrint("img url to stored in db length is ${imgURL.length}");

    myDB.update(
      'Garage',
      {
        'image': imgURL,
      },
      where: "id = 1",
    );
  }

  Future<String> getImgURL() async {
    List<Map> list = await myDB.query(
      'Garage',
    );

    debugPrint(
        "img url to sent to the main screen length is ${list[0]['image'].length}");
    return list[0]['image'];
  }

  // * add garage

  Future<void> addGarage(Garage toAdd) async {
    debugPrint("adding value to the garage table.");
    await myDB.insert(
      'Garage',
      {
        'name': toAdd.name,
        'engine': toAdd.engine,
        'colorCode': toAdd.colorCode,
        'horsePower': toAdd.horsePower,
        'year': toAdd.year,
        'purchaseDate': toAdd.purchaseDate.millisecondsSinceEpoch,
        'wheelName': toAdd.wheelName,
        'va': toAdd.va,
        'ha': toAdd.ha,
        'lastOilChange': toAdd.lastOilChange.millisecondsSinceEpoch,
        'purchasePrice': toAdd.purchasePrice,
        'image': toAdd.image,
        'tuvDate': toAdd.tuvDate.millisecondsSinceEpoch,
      },
    );
  }

  // * get garages

  Future<List<Garage>> getAllGarages() async {
    List<Map> list = await myDB.query(
      'Garage',
    );

    debugPrint("got all garages - length is ${list.length}");

    List<Garage> garages = [];

    for (var i = 0; i < list.length; i++) {
      garages.add(Garage.fromMap(list[i]));
    }

    return garages;
  }

  // * add part to the garage

  Future<void> addPart(Part toAdd) async {
    debugPrint("adding value to the garage table.");
    await myDB.insert(
      'Part',
      {
        'name': toAdd.name,
        'garageId': toAdd.garageId,
        'price': toAdd.price,
      },
    );
    debugPrint("part added!");
  }

  // * get parts of the garage

  Future<List<Part>> getParts(int garageId) async {
    List<Map> list = await myDB.query(
      'Part',
      where: "garageId = $garageId",
    );

    debugPrint("got all parts - length is ${list.length}");

    List<Part> parts = [];

    for (var i = 0; i < list.length; i++) {
      parts.add(
        Part.fromMap(
          list[i],
        ),
      );
    }

    return parts;
  }

  // * delete part from the garage

  Future<void> removePart({required Part part}) async {
    debugPrint("deleting part from the garage table.");
    await myDB.delete(
      'Part',
      where: "garageId = ${part.garageId} AND id = ${part.id}",
    );
    debugPrint("part deleted!");
  }

  // * add document to the garage

  Future<void> addDocument(Document toAdd) async {
    debugPrint("adding value to the garage table.");
    await myDB.insert(
      'Document',
      {
        'name': toAdd.name,
        'garageId': toAdd.garageId,
        'image': toAdd.image,
      },
    );
    debugPrint("document added!");
  }

  // * get documents of the garage

  Future<List<Document>> getDocuments(int garageId) async {
    List<Map> list = await myDB.query(
      'Document',
      where: "garageId = $garageId",
    );

    debugPrint("got all documents - length is ${list.length}");

    List<Document> documents = [];

    for (int i = 0; i < list.length; i++) {
      documents.add(
        Document.fromMap(
          list[i],
        ),
      );
    }

    return documents;
  }

  // * delete document from the garage

  Future<void> removeDocument({required Document document}) async {
    debugPrint("deleting document from the garage table.");
    await myDB.delete(
      'Document',
      where: "garageId = ${document.garageId} AND id = ${document.id}",
    );
    debugPrint("document deleted!");
  }

  // * add garage image
  Future<void> addGarageImage(
      {required String image, required String garageId}) async {
    debugPrint("adding value to the garage table.");
    await myDB.update('Garage', {"image": image},
        where: 'id = ?', whereArgs: [garageId]);

    debugPrint("image added!");
  }

  // * update garage

  Future<void> updateGarage({required Garage toUpdate}) async {
    debugPrint("updating value to the garage table.");
    await myDB.update(
      'Garage',
      {
        'name': toUpdate.name,
        'engine': toUpdate.engine,
        'colorCode': toUpdate.colorCode,
        'horsePower': toUpdate.horsePower,
        'year': toUpdate.year,
        'purchaseDate': toUpdate.purchaseDate.millisecondsSinceEpoch,
        'wheelName': toUpdate.wheelName,
        'va': toUpdate.va,
        'ha': toUpdate.ha,
        'lastOilChange': toUpdate.lastOilChange.millisecondsSinceEpoch,
        'purchasePrice': toUpdate.purchasePrice,
        'tuvDate': toUpdate.tuvDate.millisecondsSinceEpoch,
      },
      where: "id = ${toUpdate.id}",
    );
    debugPrint("garage updated!");
  }

  // delete garage

  Future<void> deleteGarage({required Garage garage}) async {
    debugPrint("deleting garage from the garage table.");
    await myDB.delete(
      'Garage',
      where: "id = ${garage.id}",
    );
    debugPrint("garage deleted!");
  }
}
