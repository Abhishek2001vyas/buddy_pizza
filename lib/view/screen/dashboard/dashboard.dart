import 'package:buddy_pizza/view/screen/dashboard/profile/profile_details/profile_screen.dart';
import 'package:buddy_pizza/view/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'coupon_screen.dart';
import 'home/home_screen.dart';
import 'menu_screen.dart';

class DashboardScreen extends StatefulWidget {

  const DashboardScreen({super.key,});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // final autoSizeGroup = AutoSizeGroup();
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
     HomeScreen(),
    const MenuScreen(),
    const CouponScreen(),
    const ProfileScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();
  // var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 0) {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Nav_bar(),));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        children: screens,
        index: selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            activeIcon: SvgPicture.asset(
              "assets/images/home.svg",
              height: 25,
              color: primaryColor,
            ),
            icon: SvgPicture.asset(
              "assets/images/home.svg",
              height: 25,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            activeIcon: SvgPicture.asset(
              "assets/images/menus.svg",
              height: 25,
              color: primaryColor,
            ),
            icon: SvgPicture.asset(
              "assets/images/menus.svg",
              height: 25,
              color: Colors.black,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            activeIcon: SvgPicture.asset(
              "assets/images/offerss.svg",
              height: 25,
              color: primaryColor,
            ),
            icon: SvgPicture.asset(
              "assets/images/offerss.svg",
              height: 25,
              color: Colors.black,
            ),
            label: 'Coupon',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            activeIcon: SvgPicture.asset(
              "assets/images/user.svg",
              height: 25,
              color: primaryColor,
            ),
            icon: SvgPicture.asset(
              "assets/images/user.svg",
              height: 25,
              color: Colors.black,
            ),
            label: 'Account',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: primaryColor,
        onTap: onItemTapped,
      ),
    );
  }

  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];
}
