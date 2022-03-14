import 'package:flutter/material.dart';
import 'package:mycar/controller/garage_controller.dart';
import 'package:get/get.dart';

class ShowParts extends StatefulWidget {
  const ShowParts({
    Key? key,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.garageController,
  }) : super(key: key);
  final double deviceHeight;
  final double deviceWidth;
  final GarageController garageController;
  @override
  State<ShowParts> createState() => _ShowPartsState();
}

class _ShowPartsState extends State<ShowParts> {
  @override
  void initState() {
    super.initState();
    widget.garageController.getParts();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          Container(
            height: widget.deviceHeight * 0.6,
            width: widget.deviceWidth,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView.builder(
              itemCount: widget.garageController.parts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: widget.deviceWidth * .05,
                    right: widget.deviceWidth * .05,
                    top: widget.deviceHeight * .01,
                  ),
                  child: ListTile(
                    title: Text(
                      widget.garageController.parts[index].name,
                      style: TextStyle(
                        fontSize: widget.deviceHeight * 0.02,
                      ),
                    ),
                    subtitle: Text(
                      "Price: ${widget.garageController.parts[index].price}\t\$",
                      style: TextStyle(
                        fontSize: widget.deviceHeight * 0.015,
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        widget.garageController.removePart(
                          part: widget.garageController.parts[index],
                        );
                        Get.back();
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: widget.deviceWidth * 0.05,
          right: widget.deviceWidth * 0.05,
          top: widget.deviceHeight * 0.02,
          bottom: widget.deviceHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        height: widget.deviceHeight * 0.05,
        child: Center(
          child: Text(
            "Show Parts",
            style: TextStyle(
              fontSize: widget.deviceHeight * 0.02,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
