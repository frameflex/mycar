import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycar/view/details.dart';
import 'package:mycar/view/home.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);
  final int selectedIndex;
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  late double deviceHeight, deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      height: deviceHeight * .13,
      width: deviceWidth,
      child: Row(
        children: [
          SizedBox(
            width: deviceWidth * .1,
          ),
          InkWell(
            onTap: () {
              if (widget.selectedIndex == 0) {
                Get.to(
                  () => const HomeScreen(),
                  transition: Transition.fadeIn,
                );
              } else {
                Get.off(
                  () => const HomeScreen(),
                  transition: Transition.fadeIn,
                );
              }
            },
            child: Container(
              height: deviceHeight * .08,
              width: deviceWidth * .2,
              decoration: BoxDecoration(
                color:
                    (widget.selectedIndex == 1) ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: deviceWidth * .1,
                    child: Image(
                      image: (widget.selectedIndex == 1)
                          ? const AssetImage(
                              'assets/icons/car_white_icon.png',
                            )
                          : const AssetImage(
                              'assets/icons/car_black_icon.png',
                            ),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Text(
                    'Car',
                    style: TextStyle(
                      color: (widget.selectedIndex == 1)
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              if (widget.selectedIndex == 0) {
                Get.to(
                  () => const DetailsScreen(),
                  transition: Transition.fadeIn,
                );
              } else {
                Get.off(
                  () => const DetailsScreen(),
                  transition: Transition.fadeIn,
                );
              }
            },
            child: Container(
              height: deviceHeight * .08,
              width: deviceWidth * .2,
              decoration: BoxDecoration(
                color:
                    (widget.selectedIndex == 2) ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: deviceWidth * .1,
                    child: Image(
                      image: (widget.selectedIndex == 2)
                          ? const AssetImage(
                              'assets/icons/details_white_icon.png',
                            )
                          : const AssetImage(
                              'assets/icons/details_black_icon.png',
                            ),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Text(
                    'Details',
                    style: TextStyle(
                      color: (widget.selectedIndex == 2)
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: deviceWidth * .1,
          ),
        ],
      ),
    );
  }
}
