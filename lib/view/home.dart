import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycar/view/wheels.dart';
import 'package:mycar/view/widgets/add_parts.dart';
import 'package:mycar/controller/garage_controller.dart';
import 'package:mycar/model/garage.dart';
import 'package:mycar/view/document_gallery.dart';
import 'package:mycar/view/widgets/custom_bottom_bar.dart';
import 'package:mycar/view/widgets/garage_button.dart';

import 'notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double deviceHeight, deviceWidth;

  Garage currentGarage = Garage(
    tuvDate: DateTime.now(),
    id: 12,
    image: "",
    name: "",
    engine: "engine",
    horsePower: "horsePower",
    year: "year",
    colorCode: "colorCode",
    purchaseDate: DateTime.now(),
    wheelName: "wheelName",
    va: "va",
    ha: "ha",
    lastOilChange: DateTime.now(),
    purchasePrice: "purchasePrice",
  );

  GarageController garageController = Get.put(
    GarageController(),
  );

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initDB().then((value) {
      getAllGarages().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  Future<void> initDB() async {
    await garageController.initDB();
  }

  Future<void> getAllGarages() async {
    debugPrint("in this functions");
    await garageController.getAllGarages();
    if (garageController.currentGarages.isEmpty) {
    } else {
      print("Current index is ${garageController.selectedGarageIndex.value}");

      setState(() {
        currentGarage = garageController
            .currentGarages[garageController.selectedGarageIndex.value];
        isLoading = false;
      });
    }
  }

  void changeLoading() {
    print("executing change loading");
    setState(() {
      isLoading = true;
    });
    getAllGarages();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      );
    }

    return Obx(
      () => Scaffold(
        bottomNavigationBar: (garageController.currentGarages.isEmpty)
            ? const SizedBox()
            : const CustomBottomBar(
                selectedIndex: 1,
              ),
        floatingActionButton: (garageController.currentGarages.isEmpty)
            ? GarageButton(
                garageController: garageController,
                onChange: () {},
                onAdd: getAllGarages,
                showAdd: true,
                deviceHeight: deviceHeight,
                deviceWidth: deviceWidth,
              )
            : const SizedBox(),
        body: (garageController.currentGarages.isEmpty)
            ? SizedBox(
                height: deviceHeight,
                width: deviceWidth,
                child: Center(
                  child: Text(
                    'Add your Car to the Garage',
                    style: TextStyle(
                      fontSize: deviceWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceHeight * .05,
                  ),
                  GarageButton(
                    garageController: garageController,
                    onChange: changeLoading,
                    onAdd: getAllGarages,
                    showAdd: true,
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                  ),
                  SizedBox(
                    height: deviceHeight * .05,
                    width: deviceWidth * .85,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        currentGarage.name,
                        style: TextStyle(
                          fontSize: deviceHeight * .035,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                          fontFamily: 'Open Sans',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  AspectRatio(
                    aspectRatio: 2,
                    child: (currentGarage.image == '')
                        ? const Center(
                            child: Text(
                              "No Image Available",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                        : Image(
                        fit: BoxFit.fitWidth,
                          image: MemoryImage(
                              base64Decode(currentGarage.image),

                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        SizedBox(
                          width: deviceWidth * .12,
                          child: const Image(
                            image: AssetImage('assets/icons/engine_icon.png'),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Engine',
                              style: TextStyle(
                                fontSize: deviceHeight * .02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: deviceWidth * .6,
                              child: Text(
                                currentGarage.engine,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: deviceHeight * .02,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      SizedBox(
                        width: deviceWidth * .11,
                        child: const Image(
                          image: AssetImage('assets/icons/calendar_icon.png'),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentGarage.year,
                            style: TextStyle(
                              fontSize: deviceHeight * .02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${DateTime.now().year - currentGarage.purchaseDate.year} year of ownership',
                            style: TextStyle(
                              fontSize: deviceHeight * .02,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(

                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Row(
                        children: [
                          SizedBox(
                            width: deviceWidth * .08,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                    () => const DocumentsGalleryScreen(),
                                transition: Transition.fadeIn,
                              );
                            },
                            child: Container(
                              height: constraints.maxHeight * .9,
                              width: deviceWidth * .4,

                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(.03),
                                    Colors.black.withOpacity(.2),

                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Documents',
                                    style: TextStyle(
                                      fontSize: deviceHeight * .022,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * .5,
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/icons/documents_black_icon.png',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            // * this function addParts() is defined in the widgets/add_parts.dart file
                            onTap: () =>
                                addParts(
                                  deviceHeight: deviceHeight,
                                  deviceWidth: deviceWidth,
                                  controller: garageController,
                                ),
                            child: Container(
                              height: constraints.maxHeight * .9,
                              width: deviceWidth * .4,
                              decoration: BoxDecoration(

                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(.03),
                                    Colors.black.withOpacity(.2),
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Add Parts',
                                    style: TextStyle(
                                      fontSize: deviceHeight * .022,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * .5,
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/icons/parts_black_icon.png',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: deviceWidth * .08,
                          ),
                        ],
                      );
                    }),
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Row(
                        children: [
                          SizedBox(
                            width: deviceWidth * .08,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                    () => const NoteScreen(),
                                transition: Transition.fadeIn,
                              );
                            },
                            child: Container(
                              height: constraints.maxHeight * .9,
                              width: deviceWidth * .4,

                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(.03),
                                    Colors.black.withOpacity(.2),

                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'To-Do List',
                                    style: TextStyle(
                                      fontSize: deviceHeight * .022,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * .5,
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/icons/ToDo_black_icon.png',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            // * this function addParts() is defined in the widgets/add_parts.dart file
                            onTap: () {
                              Get.to(
                                    () => const WheelsScreen(),

                                transition: Transition.fadeIn,
                              );
                            },
                            child: Container(
                              height: constraints.maxHeight * .9,
                              width: deviceWidth * .4,
                              decoration: BoxDecoration(

                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(.03),
                                    Colors.black.withOpacity(.2),
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Wheels',
                                    style: TextStyle(
                                      fontSize: deviceHeight * .022,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * .5,
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/icons/wheel_black_icon.png',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: deviceWidth * .08,
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
      ),
    );
  }
}
