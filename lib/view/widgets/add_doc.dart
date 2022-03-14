import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycar/controller/garage_controller.dart';
import 'package:mycar/model/document.dart';

class AddDoc extends StatefulWidget {
  const AddDoc({
    Key? key,
    required this.controller,
    required this.deviceHeight,
    required this.deviceWidth,
  }) : super(key: key);
  final double deviceHeight, deviceWidth;
  final GarageController controller;
  @override
  State<AddDoc> createState() => _AddDocState();
}

class _AddDocState extends State<AddDoc> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: const Key('add_document_button'),
      onPressed: () {
        // * first user will add the name and then the image
        // * after that the image will be stored in database.

        String docName = '';

        Get.dialog(
          AlertDialog(
            title: const Text(
              'New Document',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: TextField(
              onChanged: (val) {
                setState(() {
                  docName = val;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Document Name',
              ),
            ),
            actions: [
              MaterialButton(
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedImage = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  final pickedImageFile = File(pickedImage!.path);

                  final pickedImageBytes = await pickedImageFile.readAsBytes();

                  String img = base64Encode(pickedImageBytes);
                  await widget.controller.addDocument(
                    document: Document(
                      id: 123,
                      garageId: widget
                          .controller
                          .currentGarages[
                              widget.controller.selectedGarageIndex.value]
                          .id,
                      image: img,
                      name: docName,
                    ),
                  );
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
      backgroundColor: const Color.fromARGB(255, 49, 45, 45),
      elevation: 0,
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
