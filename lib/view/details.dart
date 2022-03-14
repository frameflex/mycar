import 'package:flutter/material.dart';
import 'package:mycar/controller/garage_controller.dart';
import 'package:mycar/view/widgets/custom_bottom_bar.dart';
import 'package:mycar/view/widgets/delete_garage.dart';
import 'package:mycar/view/widgets/details_car_widget.dart';
import 'package:mycar/view/widgets/details_save.dart';
import 'package:mycar/view/widgets/garage_button.dart';
import 'package:mycar/view/widgets/input_field_row.dart';
import 'package:get/get.dart';
import 'package:mycar/view/widgets/show_parts.dart';

import '../model/garage.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late double deviceHeight, deviceWidth;
  GarageController garageController = Get.find<GarageController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController horsePowerController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController purchaseDateController = TextEditingController();
  TextEditingController wheelNameController = TextEditingController();
  TextEditingController vaController = TextEditingController();
  TextEditingController haController = TextEditingController();
  TextEditingController lastOilChangeController = TextEditingController();
  TextEditingController tuvDateController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  late Garage garage;
  double partsPrice = 0;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    setDisplayingGarage();
  }

  void setDisplayingGarage() async {
    partsPrice = 0;
    await garageController.getAllGarages();
    garage = garageController
        .currentGarages[garageController.selectedGarageIndex.value];

    await garageController.getParts();

    for (int i = 0; i < garageController.parts.length; i++) {
      partsPrice += garageController.parts[i].price;
      debugPrint(garageController.parts[i].name);
    }

    setState(() {
      isLoading = false;
    });
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
    setDisplayingGarage();
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
    return Scaffold(
      bottomNavigationBar: const CustomBottomBar(
        selectedIndex: 2,
      ),
      body: Column(
        children: [
          SizedBox(
            height: deviceHeight * 0.05,
          ),
          Row(
            children: [
              GarageButton(
                garageController: garageController,
                onChange: changeLoading,
                showAdd: false,
                onAdd: () {},
                deviceHeight: deviceHeight,
                deviceWidth: deviceWidth,
              ),
              const Spacer(),
              DetailSave(
                controller: garageController,
                colorController: colorController,
                engineController: engineController,
                haController: haController,
                horsePowerController: horsePowerController,
                lastOilChangeController: lastOilChangeController,
                nameController: nameController,
                purchaseDateController: purchaseDateController,
                purchasePriceController: purchasePriceController,
                tuvDateController: tuvDateController,
                vaController: vaController,
                wheelNameController: wheelNameController,
                yearController: yearController,
              ),
              SizedBox(
                width: deviceWidth * .05,
              ),
            ],
          ),
          SizedBox(
            height: deviceHeight * 0.015,
          ),
          DetailsCarWidget(
            deviceHeight: deviceHeight,
            deviceWidth: deviceWidth,
            controller: garageController,
          ),
          const Divider(
            height: 2,
            color: Colors.black,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    hintText: garage.name,
                    keyboardType: TextInputType.name,
                    title: "Name",
                    controller: nameController,
                  ),
                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    hintText: garage.engine,
                    keyboardType: TextInputType.name,
                    title: "Engine",
                    controller: engineController,
                  ),
                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    hintText: "${garage.horsePower} PS",
                    keyboardType: TextInputType.name,
                    title: "Horsepower",
                    controller: horsePowerController,
                  ),
                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    hintText: garage.year,
                    keyboardType: TextInputType.name,
                    title: "Model year",
                    controller: yearController,
                  ),
                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    hintText: garage.colorCode,
                    keyboardType: TextInputType.name,
                    title: "Color code",
                    controller: colorController,
                  ),
                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    hintText: garage.wheelName,
                    keyboardType: TextInputType.name,
                    title: "Wheel name",
                    controller: wheelNameController,
                  ),
                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    hintText: garage.va,
                    keyboardType: TextInputType.name,
                    title: "VA",
                    controller: vaController,
                  ),
                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    hintText: garage.ha,
                    keyboardType: TextInputType.name,
                    title: "HA",
                    controller: haController,
                  ),
                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    hintText:
                        "${garage.lastOilChange.day}/${garage.lastOilChange.month}/${garage.lastOilChange.year}",
                    keyboardType: TextInputType.name,
                    title: "Last oil change",
                    controller: lastOilChangeController,
                    isDate: true,
                  ),
                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    keyboardType: TextInputType.name,
                    isDate: true,
                    hintText:
                        "${garage.tuvDate.day}/${garage.tuvDate.month}/${garage.tuvDate.year}",
                    title: "next Inspection",
                    controller: tuvDateController,
                  ),

                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    hintText: "${garage.purchasePrice}\t\t\$",
                    keyboardType: TextInputType.number,
                    title: "Purchase Price",
                    controller: purchasePriceController,
                  ),
                  InputFieldRow(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    hintText:
                        "${garage.purchaseDate.day}/${garage.purchaseDate.month}/${garage.purchaseDate.year}",
                    keyboardType: TextInputType.number,
                    title: "Purchase Date",
                    controller: purchaseDateController,
                    isDate: true,
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.9,
                    child: Row(
                      children: [
                        Text(
                          "Part Cost",
                          style: TextStyle(
                            fontSize: deviceHeight * 0.02,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "$partsPrice\t\$",
                          style: TextStyle(
                            fontSize: deviceHeight * 0.02,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.9,
                    child: Row(
                      children: [
                        Text(
                          "Total Cost",
                          style: TextStyle(
                            fontSize: deviceHeight * 0.02,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "$partsPrice\t\$",
                          style: TextStyle(
                            fontSize: deviceHeight * 0.02,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ShowParts(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    garageController: garageController,
                  ),
                  DeleteGarage(
                    controller: garageController,
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
