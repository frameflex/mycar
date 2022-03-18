import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycar/controller/garage_controller.dart';
import 'package:mycar/view/image_preview.dart';
import 'package:mycar/view/widgets/add_doc.dart';
import 'package:mycar/view/widgets/garage_button.dart';
import 'package:photo_view/photo_view.dart';

class WheelsScreen extends StatefulWidget {
  const WheelsScreen({Key? key}) : super(key: key);

  @override
  _WheelsScreenState createState() => _WheelsScreenState();
}

class _WheelsScreenState extends State<WheelsScreen> {
  late double deviceHeight, deviceWidth;
  GarageController controller = Get.find<GarageController>();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    controller.getDocuments().then((value) {
      setState(() {
        isLoading = false;
      });
    });
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
        floatingActionButton: AddDoc(
          controller: controller,
          deviceHeight: deviceHeight,
          deviceWidth: deviceWidth,
        ),
        body: Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.05,
              width: deviceWidth,
            ),
            Container(
              padding: EdgeInsets.only(left: deviceWidth * 0.05),
              child: SizedBox(
                height: deviceHeight * 0.05,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FloatingActionButton(
                      heroTag: const Key('back_button'),
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
                      'All Wheels',
                      style: TextStyle(
                        fontSize: deviceHeight * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (controller.docs.isEmpty)
                ? Padding(
              padding: EdgeInsets.only(
                top: deviceHeight * .2,
              ),
              child: const Text(
                'No wheels added yet',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            )
                : Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: deviceHeight * .02,
                  childAspectRatio: 2.5 / 3,
                ),
                itemCount: controller.docs.length,
                itemBuilder: (ctx, itr) {
                  // return LayoutBuilder(builder: (context, sizes) {
                  return Container(
                    // color: Colors.grey,
                    margin: EdgeInsets.only(
                      left: deviceWidth * 0.03,
                      right: deviceWidth * 0.03,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => ImagePreviewScreen(
                                heroTag: itr.toString(),
                                image: MemoryImage(
                                  base64Decode(
                                    controller.docs[itr].image,
                                  ),
                                ),
                              ));
                            },
                            child: SizedBox(
                              height: deviceHeight * .2,
                              child: Image(
                                fit: BoxFit.fitHeight,
                                image: MemoryImage(
                                  base64Decode(
                                    controller.docs[itr].image,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // height: (sizes.maxHeight -
                            //         ((deviceHeight * 0.03) * 2)) *
                            //     0.18,
                            height: deviceHeight * 0.06,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '\t\t${controller.docs[itr].name}',
                                    style: TextStyle(
                                      fontSize: deviceHeight * 0.02,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    controller.removeDocument(
                                      document: controller.docs[itr],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  // });
                },
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
