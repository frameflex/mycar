import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycar/controller/garage_controller.dart';
import 'package:mycar/model/part.dart';

void addParts({
  required double deviceHeight,
  required double deviceWidth,
  required GarageController controller,
}) {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: deviceHeight * 0.5,
      width: deviceWidth,
      child: Column(
        children: [
          SizedBox(
            height: 20,
            width: deviceWidth,
          ),
          const Text(
            "Add Parts",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
            width: deviceWidth,
          ),
          SizedBox(
            width: deviceWidth * .9,
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Name",
              ),
            ),
          ),
          SizedBox(
            height: 20,
            width: deviceWidth,
          ),
          SizedBox(
            width: deviceWidth * .9,
            child: TextField(
              controller: _priceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Price",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () async {
              // * create a new entry in parts table
              await controller.addParts(
                part: Part(
                  garageId: controller
                      .currentGarages[controller.selectedGarageIndex.value].id
                      .toString(),
                  id: 0,
                  price: double.parse(_priceController.text),
                  name: _nameController.text,
                ),
              );
              Get.back();
            },
            child: Container(
              height: deviceHeight * .07,
              width: deviceWidth * .9,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "Add Product",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
