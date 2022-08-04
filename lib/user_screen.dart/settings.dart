import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smart_auction/repository.dart/user_repository.dart';
import 'package:smart_auction/utils/colors.dart';

import 'bottom_nav.dart';

class SettingsScreen extends StatelessWidget {
  final _userController = Get.find<UserRepository>();

  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView(
          children: [
            Center(
              child: Text(
                tr('settings'),
                textAlign: TextAlign.start,
                style: GoogleFonts.changaTextTheme().bodyMedium!,
              ),
            ),
            const SizedBox(height: 20),
            SettingsItem(
              icon: CupertinoIcons.settings,
              text: tr('notification'),
              onPress: () {},
            ),
            const SizedBox(height: 10),
            SettingsItem(
              text: tr('notificationsound'),
              icon: Icons.account_balance_wallet,
              onPress: () {},
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                if (context.locale.toString() == "ar_AR") {
                  // Get.updateLocale(const Locale('en'));
                  EasyLocalization.of(context)!
                      .setLocale(const Locale('en', 'US'));
                } else {
                  EasyLocalization.of(context)!
                      .setLocale(const Locale('ar', 'AR'));
                }

                if (kDebugMode) {
                  print("Locale: " + context.locale.toString());
                }

                context.resetLocale();
                Future.delayed(const Duration(seconds: 3),
                    () => Get.off(() => const NavigationBottomBar()));
              },
              child: SettingsItem(
                icon: Icons.change_circle,
                text: tr('language'),
                onPress: () {},
              ),
            ),
            // SizedBox(height: 10),
            // SettingsItem(
            //   icon: CupertinoIcons.location_fill,
            //   text: 'Dark Mode',
            //   onPress: () {},
            // ),
            const SizedBox(height: 10),
            SettingsItem(
              icon: CupertinoIcons.person_3_fill,
              text: tr('pp'),
              onPress: () {},
            ),
            const SizedBox(height: 10),
            SettingsItem(
              icon: Icons.info,
              text: tr('tos'),
              onPress: () {},
            ),
            const SizedBox(height: 10),
            SettingsItem(
              // TODO: Retrieve the current build number to be displayed
              icon: Icons.app_settings_alt,
              text: showBuildNumber() as String?,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                _userController.signOut();
              },
              child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SettingsItem(icon: Icons.logout, text: tr('logout'))),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> showBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    // String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    return buildNumber;
  }
}

class SettingsItem extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Function? onPress;

  const SettingsItem({Key? key, this.text, this.icon, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffF9F9F9)),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Text(
            text!,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                color: AppColors.secondary,
                fontFamily: GoogleFonts.tajawal().fontFamily,
                fontStyle: FontStyle.normal,
                fontSize: 14),
          ),
          const Spacer(),
          Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: AppColors.accentcolor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                icon,
                size: 18,
                color: AppColors.accentcolor,
              )),
        ],
      ),
    );
  }
}
