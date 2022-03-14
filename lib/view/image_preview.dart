import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({
    Key? key,
    required this.image,
    required this.heroTag,
  }) : super(key: key);
  final MemoryImage image;
  final String heroTag;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late double deviceHeight, deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: deviceHeight * 0.05,
          ),
          Container(
            padding: EdgeInsets.only(left: deviceWidth * 0.05),
            child: SizedBox(
              height: deviceHeight * 0.05,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FloatingActionButton(
                    onPressed: () => Get.back(),
                    backgroundColor: Colors.black,
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.05,
                  ),
                  Text(
                    'Image Preview',
                    style: TextStyle(
                      fontSize: deviceHeight * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.85,
            width: deviceWidth,
            child: PhotoView(
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              imageProvider: widget.image,
            ),
          ),
        ],
      ),
    );
  }
}
