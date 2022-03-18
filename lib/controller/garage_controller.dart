import 'package:get/get.dart';
import 'package:mycar/controller/database.dart';
import 'package:mycar/model/document.dart';
import 'package:mycar/model/part.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/garage.dart';
import '../model/note.dart';
import '../model/wheel.dart';
import '../view/home.dart';

class GarageController extends GetxController {
  late SharedPreferences pref;

  var currentGarages = [].obs;
  var selectedGarageIndex = 0.obs;
  var db = MyDB();

  List<Part> parts = [];
  List<Part> notes = [];
  List<Part> wheels = [];
  var docs = [].obs;

  @override
  void onInit() {
    super.onInit();

    initPrefs();
  }

  Future<void> initDB() async {
    await db.start();
  }

  initPrefs() async {
    pref = await SharedPreferences.getInstance();

    selectedGarageIndex.value = pref.getInt('selectedGarageIndex') ?? 0;

    if (pref.getInt('selectedGarageIndex') == 0) {
      pref.setInt('selectedGarageIndex', 0);
    }
  }

  Future<void> getAllGarages() async {
    currentGarages.value = await db.getAllGarages();
  }

  // on garage change

  void changeGarage({required int selectedIndex}) async {
    selectedGarageIndex.value = selectedIndex;

    pref.setInt('selectedGarageIndex', selectedIndex);
  }

  // add parts in garage

  Future<void> addParts({required Part part}) async {
    await db.addPart(part);
  }

  // get all the parts in garage
  Future<void> getParts() async {
    parts = await db.getParts(
      currentGarages[selectedGarageIndex.value].id,
    );
  }

  // remove part in a garage

  Future<void> removePart({required Part part}) async {
    parts.remove(part);
    await db.removePart(part: part);
  }


  // add notes in garage

  Future<void> addNotes({required Note note}) async {
    await db.addNote(note);
  }

  // get all the notes in garage
 // Future<void> getNotes() async {
  //  notes = await db.getNotes(
   //   currentGarages[selectedGarageIndex.value].id,
  //;
  //}

  // remove notes in a garage

  Future<void> removeNote({required Note note}) async {
    notes.remove(note);
    await db.removeNote(note: note);
  }


  // get all documents in garage

  Future<void> getDocuments() async {
    docs.value = await db.getDocuments(
      currentGarages[selectedGarageIndex.value].id,
    );
  }

  // remove a document from garage

  Future<void> removeDocument({required Document document}) async {
    docs.remove(document);
    await db.removeDocument(document: document);
  }

  // add a new document to garage

  Future<void> addDocument({required Document document}) async {
    docs.add(document);
    await db.addDocument(
      document,
    );
  }

  // add garage image
  Future<void> addGarageImage({required String image}) async {
    await db.addGarageImage(
      garageId: currentGarages[selectedGarageIndex.value].id.toString(),
      image: image,
    );
  }

  // update garage
  Future<void> updateGarage({required Garage garage}) async {
    await db.updateGarage(toUpdate: garage);
  }

  // delete a garage
  Future<void> deleteGarage({required Garage garage}) async {
    currentGarages.remove(garage);
    selectedGarageIndex.value = 0;
    pref = await SharedPreferences.getInstance();

    pref.setInt('selectedGarageIndex', 0);

    await db.deleteGarage(garage: garage);
    Get.to(
      () => const HomeScreen(),
      transition: Transition.fadeIn,
    );
  }
}
