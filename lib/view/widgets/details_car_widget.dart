import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycar/controller/garage_controller.dart';

import '../details.dart';

class DetailsCarWidget extends StatefulWidget {
  const DetailsCarWidget({
    Key? key,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.controller,
  }) : super(key: key);
  final double deviceHeight, deviceWidth;
  final GarageController controller;

  @override
  _DetailsCarWidgetState createState() => _DetailsCarWidgetState();
}

class _DetailsCarWidgetState extends State<DetailsCarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.deviceHeight * .2,
      width: widget.deviceWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: widget.deviceHeight * 0.18,
            width: widget.deviceWidth * .65,
            child: (widget
                        .controller
                        .currentGarages[
                            widget.controller.selectedGarageIndex.value]
                        .image ==
                    '')
                ? const Center(
                    child: Text(
                      "No Image Available",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                : Image(
                    image: MemoryImage(
                      base64Decode(
                        widget
                            .controller
                            .currentGarages[
                                widget.controller.selectedGarageIndex.value]
                            .image,
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: widget.deviceHeight * 0.18,
            width: widget.deviceWidth * .3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedImage = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    final pickedImageFile = File(pickedImage!.path);
                    final pickedImageBytes =
                        await pickedImageFile.readAsBytes();

                    String img = base64Encode(pickedImageBytes);

                    await widget.controller.addGarageImage(
                      image: img,
                    );
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      Get.offAll(
                        () => const DetailsScreen(),
                        transition: Transition.fadeIn,
                      );
                    });
                  },
                  splashColor: Colors.black,
                  child: Container(
                    height: widget.deviceHeight * 0.05,
                    width: widget.deviceWidth * .3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Edit\nPicture",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: widget.deviceHeight * 0.015,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await widget.controller.addGarageImage(
                      image: "",
                    );
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      Get.offAll(
                        () => const DetailsScreen(),
                        transition: Transition.fadeIn,
                      );
                    });
                  },
                  splashColor: Colors.red,
                  child: Container(
                    height: widget.deviceHeight * 0.05,
                    width: widget.deviceWidth * .3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Delete\nPicture",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: widget.deviceHeight * 0.015,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
