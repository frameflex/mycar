import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycar/controller/garage_controller.dart';
import 'package:mycar/model/garage.dart';

import '../details.dart';

class DetailSave extends StatefulWidget {
  const DetailSave({
    Key? key,
    required this.controller,
    required this.colorController,
    required this.engineController,
    required this.haController,
    required this.horsePowerController,
    required this.lastOilChangeController,
    required this.nameController,
    required this.purchaseDateController,
    required this.purchasePriceController,
    required this.tuvDateController,
    required this.vaController,
    required this.wheelNameController,
    required this.yearController,
  }) : super(key: key);
  final GarageController controller;
  final TextEditingController nameController;
  final TextEditingController engineController;
  final TextEditingController horsePowerController;
  final TextEditingController yearController;
  final TextEditingController colorController;
  final TextEditingController purchaseDateController;
  final TextEditingController wheelNameController;
  final TextEditingController vaController;
  final TextEditingController haController;
  final TextEditingController lastOilChangeController;
  final TextEditingController tuvDateController;
  final TextEditingController purchasePriceController;

  @override
  State<DetailSave> createState() => _DetailSaveState();
}

class _DetailSaveState extends State<DetailSave> {
  bool isUpdating = false;
  @override
  Widget build(BuildContext context) {
    if (isUpdating) {
      return FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    return FloatingActionButton(
      onPressed: () async {
        setState(() {
          isUpdating = true;
        });
        Garage updatedGarage = Garage(
          id: widget.controller
              .currentGarages[widget.controller.selectedGarageIndex.value].id,
          name: widget.nameController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .name
              : widget.nameController.text,
          engine: widget.engineController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .engine
              : widget.engineController.text,
          horsePower: widget.horsePowerController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .horsePower
              : widget.horsePowerController.text,
          year: widget.yearController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .year
              : widget.yearController.text,
          colorCode: widget.colorController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .colorCode
              : widget.colorController.text,
          purchaseDate: widget.purchaseDateController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .purchaseDate
              : DateTime.parse(widget.purchaseDateController.text),
          wheelName: widget.wheelNameController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .wheelName
              : widget.wheelNameController.text,
          va: widget.vaController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .va
              : widget.vaController.text,
          ha: widget.haController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .ha
              : widget.haController.text,
          lastOilChange: widget.lastOilChangeController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .lastOilChange
              : DateTime.parse(widget.lastOilChangeController.text),
          tuvDate: widget.tuvDateController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .tuvDate
              : DateTime.parse(widget.tuvDateController.text),
          purchasePrice: widget.purchasePriceController.text.isEmpty
              ? widget
                  .controller
                  .currentGarages[widget.controller.selectedGarageIndex.value]
                  .purchasePrice
              : widget.purchasePriceController.text,
          image: widget
              .controller
              .currentGarages[widget.controller.selectedGarageIndex.value]
              .image,
        );

        await widget.controller.updateGarage(garage: updatedGarage);
        Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.offAll(
            () => const DetailsScreen(),
            transition: Transition.fadeIn,
          );
        });
      },
      backgroundColor: Colors.black,
      child: const Icon(
        Icons.save,
      ),
    );
  }
}
