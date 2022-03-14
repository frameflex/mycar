import 'package:flutter/material.dart';
import 'package:mycar/controller/garage_controller.dart';

class DeleteGarage extends StatefulWidget {
  const DeleteGarage({
    Key? key,
    required this.controller,
    required this.deviceHeight,
    required this.deviceWidth,
  }) : super(key: key);
  final GarageController controller;
  final double deviceHeight, deviceWidth;

  @override
  State<DeleteGarage> createState() => _DeleteGarageState();
}

class _DeleteGarageState extends State<DeleteGarage> {
  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Garage'),
              content:
                  const Text('Are you sure you want to delete this garage?'),
              actions: <Widget>[
                MaterialButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    widget.controller.deleteGarage(
                      garage: widget.controller.currentGarages[
                          widget.controller.selectedGarageIndex.value],
                    );
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: widget.deviceWidth * 0.05,
          right: widget.deviceWidth * 0.05,
          bottom: widget.deviceHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        height: widget.deviceHeight * 0.05,
        child: Center(
          child: Text(
            "Delete Garage",
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
