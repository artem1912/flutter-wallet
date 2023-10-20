import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:crypto_wallet/UI/pages/home/dashboard.dart';
import 'package:crypto_wallet/UI/pages/settings/settings.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/constants/customIcons.dart';

import '../../controllers/appController.dart';
import '../pages/swap/swap.dart';

class BottomNavigationBar1 extends StatefulWidget {
  const BottomNavigationBar1({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBar1> createState() => _BottomNavigationBar1State();
}

class _BottomNavigationBar1State extends State<BottomNavigationBar1> {
  final appController = Get.find<AppController>();
  List<TabItem> items = [
    TabItem(
      icon: CustomIcons.home,
      title: 'Home',
    ),
    TabItem(
      icon: CustomIcons.swap,
      title: 'Swap',
    ),
    TabItem(
      icon: CustomIcons.settings,
      title: 'Settings',
    ),
  ];
  int visit = 0;
  double height = 30;
  Color colorSelect = const Color(0XFF462D81);
  Color color = const Color(0XFF462D81);
  Color color2 = const Color(0XFF462D81);
  Color bgColor = lightColor;
  List pages = [
    Dashboard(), Swap(), Settings()
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomBarInspiredInside(
          fixed: true,
          fixedIndex: 1,
          items: items,
          backgroundColor: cardColor.value,
          color: labelColor.value,
          colorSelected: cardColor.value,
          indexSelected: visit,
          onTap: (int index) => setState(() {
            print('bsdhdsbhfbs $visit $index');
            visit = index;
            setState(() {

            });
          }),
          chipStyle: ChipStyle(
            convexBridge: true,
            color: primaryColor.value,
            background: appController.isDark.value == true ? dividerColor.value : primaryColor.value
          ),
          itemStyle: ItemStyle.circle,
          animated: false,
        ),
        body: pages.elementAt(visit),
      ),
    );
  }
}
