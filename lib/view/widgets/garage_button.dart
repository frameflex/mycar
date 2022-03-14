import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycar/controller/garage_controller.dart';
import 'package:mycar/model/garage.dart';

class GarageButton extends StatefulWidget {
  const GarageButton({
    Key? key,
    required this.deviceHeight,
    required this.deviceWidth,
    this.isInDocument = false,
    this.showAdd = false,
    required this.onAdd,
    required this.onChange,
    required this.garageController,
  }) : super(key: key);
  final double deviceHeight, deviceWidth;
  final bool isInDocument;
  final Function onAdd;
  final bool showAdd;
  final Function onChange;
  final GarageController garageController;
  @override
  _GarageButtonState createState() => _GarageButtonState();
}

class _GarageButtonState extends State<GarageButton> {
  GarageController garageController = Get.find<GarageController>();

  String garageName = '';
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            margin: EdgeInsets.only(
              top: widget.deviceHeight * 0.05,
            ),
            height: widget.deviceHeight * .5,
            width: widget.deviceWidth,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: widget.deviceHeight * .5,
                  width: widget.deviceWidth,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: garageController.currentGarages.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          garageController.changeGarage(
                            selectedIndex: index,
                          );
                          Get.back();
                          widget.onChange();
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 25,
                            left: widget.deviceWidth * .05,
                            right: widget.deviceWidth * .05,
                          ),
                          height: widget.deviceHeight * .1,
                          width: widget.deviceWidth * .9,
                          child: Card(
                            color:
                                (garageController.selectedGarageIndex.value ==
                                        index)
                                    ? Colors.grey
                                    : Colors.black,
                            elevation: 5,
                            child: Center(
                              child: Text(
                                garageController.currentGarages[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (widget.showAdd)
                  Positioned(
                    top: -30,
                    right: 25,
                    child: FloatingActionButton(
                      heroTag: const Key('garageButtonBottomSheet'),
                      backgroundColor: Colors.black,
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: const Text(
                              'New Garage',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: TextField(
                              onChanged: (val) {
                                setState(() {
                                  garageName = val;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Garage Name',
                              ),
                            ),
                            actions: [
                              MaterialButton(
                                child: const Text(
                                  'Done',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () async {
                                  if (garageName.isNotEmpty) {
                                    await garageController.db.addGarage(
                                      Garage(
                                        id: 1,
                                        image: "",
                                        name: garageName,
                                        engine: "engine",
                                        horsePower: "horsePower",
                                        year: "year",
                                        colorCode: "colorCode",
                                        purchaseDate: DateTime.now(),
                                        wheelName: "wheelName",
                                        va: "va",
                                        ha: "ha",
                                        lastOilChange: DateTime.now(),
                                        tuvDate: DateTime.now(),
                                        purchasePrice: "purchasePrice",
                                      ),
                                    );
                                    await garageController.getAllGarages();
                                    await widget.onAdd();
                                    Get.back();
                                    Get.back();
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: widget.deviceWidth * .05,
        ),
        width: widget.deviceWidth * .35,
        height: widget.deviceHeight * .06,
        decoration: BoxDecoration(
          color: (widget.isInDocument)
              ? const Color.fromARGB(255, 49, 45, 45)
              : Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Garage",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: widget.deviceHeight * .022,
            ),
          ),
        ),
      ),
    );
  }
}
