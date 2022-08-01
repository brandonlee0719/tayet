// Splash screen controller with GetX Storage
// Language: dart
// Path: lib/onboarding/controllers/splash_controller.dart
// Compare this snippet from lib/user_screen.dart/bottom_nav.dart:
//
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../authentication/login.dart';
import '../../user_screen.dart/bottom_nav.dart';

class SplashController extends GetxController {
  final storageBox = GetStorage();
  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<SplashController>(() => SplashController());
  }

  @override
  void onReady() {
    super.onReady();
    if (storageBox.read("userName") != null) {
      Future.delayed(const Duration(microseconds: 2000), (() {
        Get.offAll(() => const NavigationBottomBar());
      }));
      // Get.off(() => NavigationBottomBar());
    } else {
      Get.off(() => LoginScreen());
    }
    // Get.off(() => const NavigationBottomBar());
  }

  @override
  void onClose() {
    super.onClose();
  }
}
