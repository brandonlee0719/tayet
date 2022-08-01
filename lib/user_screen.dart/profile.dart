import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_auction/repository.dart/user_repository.dart';
import 'package:smart_auction/repository.dart/wallet_repository.dart';
import 'package:smart_auction/utils/colors.dart';

import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _userController = Get.find<UserRepository>();
  final _walletController = Get.find<WalletRepository>();
  @override
  Widget build(BuildContext context) {
    // print("user json from profile ${_userController.user!.toJson()}");
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      appBar: AppBar(
        backgroundColor: AppColors.whitecolor,
        elevation: 1,
        centerTitle: true,
        title: Text(tr('profile'),
            style: GoogleFonts.changaTextTheme().bodyMedium!),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: AppColors.accentcolor,
              ))
        ],
      ),
      body: Obx(() {
        return SizedBox(
          width: Get.width,
          height: Get.height,
          child: SafeArea(
            child: ListView(
              children: [
                SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                                image: (_userController.userModel.imageUrl !=
                                        null)
                                    ? DecorationImage(
                                        image: NetworkImage(_userController
                                            .userModel.imageUrl!),
                                        fit: BoxFit.cover)
                                    : const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/profile-header.jpg'),
                                        fit: BoxFit.cover)),
                          ),
                          Positioned(
                            bottom: -50,
                            right: MediaQuery.of(context).size.width / 2 - 50,
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primarycolor,
                                  image: (_userController.userModel.imageUrl !=
                                          null)
                                      ? DecorationImage(
                                          image: NetworkImage(_userController
                                              .userModel.imageUrl!),
                                          fit: BoxFit.cover)
                                      : const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/user-male.png'),
                                          fit: BoxFit.cover)),
                            ),
                          ),
                        ])),
                const SizedBox(height: 60),
                Container(
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  child: Center(
                    child: Text(
                      '${_userController.userModel.firstName} ${_userController.userModel.lastName}',
                      style: Theme.of(context).textTheme.headline4,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    "${_userController.userModel.email}",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                const SizedBox(height: 10),
                // Center(
                //   child: Container(
                //     padding: const EdgeInsets.all(8),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(12),
                //         border: Border.all(
                //             width: 0.5, color: AppColors.accentcolor)),
                //     child: Text(
                //       tr('ep'),
                //       style: Theme.of(context).textTheme.bodySmall,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 10),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(const UpdateProfile());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 0.5, color: AppColors.accentcolor)),
                    child: Text(
                      tr('ep'),
                      style: TextStyle(
                          fontFamily: GoogleFonts.tajawal().fontFamily,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentcolor,
                          fontSize: 12),
                    ),
                  ),
                )),
                ProfileMenu(
                  iconData: Icons.account_balance,
                  title: tr('cb'),
                  child: Text(
                    '${_walletController.coinBalance}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                ProfileMenu(
                  iconData: Icons.shopping_cart,
                  title: tr('sb'),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.accentcolor),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                ProfileMenu(
                  iconData: Icons.card_giftcard,
                  title: tr('pb'),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.accentcolor),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                ProfileMenu(
                  iconData: Icons.people,
                  title: 'Invite Friends',
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.accentcolor),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                ProfileMenu(
                  iconData: Icons.support_agent,
                  title: 'Customer Support',
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.accentcolor),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                ProfileMenu(
                  iconData: Icons.rate_review,
                  title: 'Rate Our App',
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.accentcolor),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 40)
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final Widget? child;

  const ProfileMenu({Key? key, this.iconData, this.title, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Icon(
            iconData,
            color: AppColors.accentcolor,
          ),
          const SizedBox(width: 15),
          Text(
            title!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Spacer(flex: 3),
          child!
        ],
      ),
    );
  }
}
