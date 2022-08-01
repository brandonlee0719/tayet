import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:foodigital_vendor/ui/features/home/dashboard/dashbord_page.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:smart_auction/user_screen.dart/coins.dart';
import 'package:smart_auction/user_screen.dart/profile.dart';
import 'package:smart_auction/utils/colors.dart';

import 'dashboard/dashboard.dart';
import 'settings.dart';

class NavigationBottomBar extends StatelessWidget {
  final PersistentTabController? controller;
  final bool? hideNavBar;

  const NavigationBottomBar({Key? key, this.controller, this.hideNavBar})
      : super(key: key);

  List<Widget> _buildScreens() {
    return [
      const Dashboard(),
      CoinScreen(),
      const ProfileScreen(),
      SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      // floatingActionButton: FloatingActionButton(onPressed: (){

      // },child: Icon(Icons.message),),
      items: navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      padding: const NavBarPadding.only(top: 13, bottom: 13),
      stateManagement: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? kBottomNavigationBarHeight
          : 70,
      hideNavigationBarWhenKeyboardShows: true,
      popActionScreens: PopActionScreensType.once,
      bottomScreenMargin: 0.0,
      selectedTabScreenContext: (context) {
        context = context;
      },
      onItemSelected: (index) {
        if (kDebugMode) {
          print(index);
        }
      },
      hideNavigationBar: hideNavBar,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        colorBehindNavBar: Color(0xFF05121E),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }

  // Future<List<PersistentBottomNavBarItem>> get getItems =>
  //     NavBarsItems(context);
}

List<PersistentBottomNavBarItem> navBarsItems(final BuildContext context) {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      title: tr("Home"),
      activeColorPrimary: AppColors.primarycolor,
      inactiveColorPrimary: AppColors.accentcolor,
      textStyle: GoogleFonts.changaTextTheme()
          .displaySmall!
          .copyWith(fontWeight: FontWeight.bold, fontSize: 10.0),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.collections),
      title: tr("Coin"),
      activeColorPrimary: AppColors.primarycolor,
      inactiveColorPrimary: AppColors.accentcolor,
      textStyle: GoogleFonts.changaTextTheme()
          .displaySmall!
          .copyWith(fontWeight: FontWeight.bold, fontSize: 10.0),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.person),
      title: tr("Profile"),
      activeColorPrimary: AppColors.primarycolor,
      inactiveColorPrimary: AppColors.accentcolor,
      textStyle: GoogleFonts.changaTextTheme()
          .displaySmall!
          .copyWith(fontWeight: FontWeight.bold, fontSize: 10.0),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.settings),
      title: tr("Settings"),
      activeColorPrimary: AppColors.primarycolor,
      inactiveColorPrimary: AppColors.accentcolor,
      textStyle: GoogleFonts.changaTextTheme()
          .displaySmall!
          .copyWith(fontWeight: FontWeight.bold, fontSize: 10.0),
    ),
  ];
}
