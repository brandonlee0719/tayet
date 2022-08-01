// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';

import '../authentication/login.dart';
import '../authentication/login_new.dart';
import '../repository.dart/user_repository.dart';
import '../user_screen.dart/bottom_nav.dart';

class MySplashScreen extends StatefulWidget {
  static const routeName = "/splash_screen";

  const MySplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MySplashScreen> {
  // ignore: unused_field
  Timer? _timer;
  final _userController = Get.find<UserRepository>();

  @override
  void initState() {
    // FirebaseAuth.instance.signOut();
    if (kDebugMode) {
      print("user status: ${_userController.status.value}");
      // print("user id is ${FirebaseAuth.instance.currentUser!.email}");
    }
    // TODO: Splash screen timer on starting up
    _timer = Timer(const Duration(milliseconds: 7000), () {
      if (_userController.status == Status.Unauthenticated) {
        // Get.offNamed(LoginScreen.routeName);
        // Get.off(() => SignUpScreen());
        Get.off(() => HomeLoginScreen());
      } else {
        // var userController = _userController;
        if (_userController.status == Status.authenticStat) {
          if (kDebugMode) {
            print("user id is ${FirebaseAuth.instance.currentUser!.uid}");
          }
          Get.off(() => const NavigationBottomBar());
        }
      }
    });

    super.initState.obs;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      // theme: Theme.of(context).primaryColor.blue,
      home: SplashScreen.navigate(
        name: 'assets/intro/tayetsplash3.riv',
        // next: (context) => const IntroductionAnimationScreen(),
        // next: (context) => const LoginScreen(),
        next: (context) => const NavigationBottomBar(),
        until: () => Future.delayed(const Duration(seconds: 5)),
        startAnimation: 'TayetSplash',
      ),
    );
  }
}
