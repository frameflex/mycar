import 'package:flutter/material.dart';

class InputFieldRow extends StatefulWidget {
  const InputFieldRow({
    Key? key,
    required this.deviceHeight,
    required this.deviceWidth,
    required this.hintText,
    required this.keyboardType,
    required this.title,
    required this.controller,
    this.isDate = false,
  }) : super(key: key);
  final double deviceHeight, deviceWidth;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final bool isDate;
  final TextEditingController controller;

  @override
  _InputFieldRowState createState() => _InputFieldRowState();
}

class _InputFieldRowState extends State<InputFieldRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      height: widget.deviceHeight * 0.05,
      width: widget.deviceWidth * .9,
      child: Row(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: widget.deviceHeight * 0.02,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: widget.deviceWidth * .5,
            child: TextField(
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              onTap: () {
                if (widget.isDate) {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2050),
                  ).then((value) {
                    widget.controller.text = value.toString().substring(0, 10);
                  });
                }
              },
              showCursor: !widget.isDate,
              readOnly: widget.isDate,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                contentPadding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
              ),
              minLines: 1,
              onSubmitted: (val) {
                FocusScopeNode().unfocus();
              },
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
        ],
      ),
    );
  }
}
