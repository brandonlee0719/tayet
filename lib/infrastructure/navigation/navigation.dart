import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';
import 'package:flutter_config/flutter_config.dart' as config;

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: child,
    );
    // var env = ConfigEnvironments.getEnvironments()['env'];
    // return env != Environments.PRODUCTION
    //     ? Banner(
    //         location: BannerLocation.topStart,
    //         message: env!,
    //         color: env == Environments.QAS ? Colors.blue : Colors.purple,
    //         child: child,
    //       )
    //     : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
    ),
  ];
}
