// ignore_for_file: unrelated_type_equality_checks

import 'package:easy_localization/easy_localization.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_auction/authentication/signup.dart';
import 'package:smart_auction/repository.dart/user_repository.dart';
import 'package:smart_auction/user_screen.dart/bottom_nav.dart';
import 'package:smart_auction/utils/colors.dart';

import '../base/app_lib.dart';
import '../user_screen.dart/send_otp.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final _formKey = GlobalKey<FormState>();

  Widget authentificationButton(
      Color buttonColor, String title, Color textColor, BuildContext ctx) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style,
        // elevation: 0,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        // color: buttonColor,
        onPressed: () {
          Get.off(() => const NavigationBottomBar());
        },
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }

  bool isHiddenPassword = true;
  DateTime? birthdayDate;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userController = Get.find<UserRepository>();

  // Future<PackageInfo> packageInfo = PackageInfo.fromPlatform();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 166, 166, 166),
      body: showLoginPanel(),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<GlobalKey<FormState>>('_formKey', _formKey));
  }

  Widget showLoginPanel() {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: SizedBox(
              child: Image.asset(
                "assets/images/logo.png",
                height: Adaptive.h(40),
                // width: Adaptive.w(70),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 80.0),
          //   child: Obx(() {
          //     return Text(_userController.user.firstName!,
          //         style: Theme.of(context).textTheme.caption);
          //   }),
          // ),

          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      icon: const Icon(
                        Icons.email,
                        color: AppColors.primarycolor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      labelText: "Email",
                      enabledBorder: InputBorder.none,
                      labelStyle: const TextStyle(color: Colors.grey)),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: const Icon(
                        Icons.vpn_key,
                        color: AppColors.primarycolor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      labelText: "Password",
                      enabledBorder: InputBorder.none,
                      labelStyle: const TextStyle(color: Colors.grey)),
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                  child: SizedBox(
                    child: Text(
                      tr("forgot"),
                      style: GoogleFonts.changaTextTheme().bodyLarge!.copyWith(
                          color: AppColors.primarycolor, fontSize: 13),
                    ),
                  ))),
          GFButton(
            onPressed: () {
              if (_userController.status != Status.isLoading) {
                _userController.signIn(
                  _emailController.text,
                  _passwordController.text,
                );
              }
            },
            text: tr('signin'),
            colorScheme: const ColorScheme.dark(),
            icon: const Icon(
              FontAwesomeIcons.key,
              size: 15.0,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 80),
            color: AppColors.primarycolor,
            shape: GFButtonShape.pills,
            size: 40,
            textStyle: GoogleFonts.changaTextTheme().bodyLarge!.copyWith(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 20, 50, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GFIconButton(
                  onPressed: () {
                    _userController.signInWithGoogle();
                  },
                  icon: const Icon(FontAwesomeIcons.google),
                  shape: GFIconButtonShape.circle,
                  color: AppColors.primarycolor,
                ),
                GFIconButton(
                  onPressed: () {
                    Get.to(() => const SendOtp());
                  },
                  icon: const Icon(FontAwesomeIcons.sms),
                  shape: GFIconButtonShape.circle,
                  color: AppColors.primarycolor,
                ),
                GFIconButton(
                  onPressed: () {
                    _userController.SignInWithFacebook();
                  },
                  icon: const Icon(FontAwesomeIcons.facebook),
                  shape: GFIconButtonShape.circle,
                  color: AppColors.primarycolor,
                ),
                GFIconButton(
                  onPressed: () {
                    // TODO: Signin with Apple
                    _userController.signinWithApple();
                    // _userController.SignInWithApple();
                  },
                  type: GFButtonType.outline,
                  icon: const Icon(FontAwesomeIcons.apple),
                  shape: GFIconButtonShape.circle,
                  color: AppColors.primarycolor,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: Text(
                  tr("haveaccount"),
                  style: GoogleFonts.changaTextTheme().bodyLarge!.copyWith(
                      fontSize: 14,
                      color: AppColors.primarycolor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          // const Spacer(),
          GFButton(
            onPressed: () {
              // TODO: Sign up button
              Get.to(() => const SignUpScreen());
            },
            text: tr('signup'),
            colorScheme: const ColorScheme.dark(),
            icon: const Icon(FontAwesomeIcons.signInAlt),
            padding: const EdgeInsets.symmetric(horizontal: 80),
            color: AppColors.primarycolor,
            shape: GFButtonShape.pills,
            size: 50,
            disabledColor: Colors.grey,
            textStyle: GoogleFonts.changaTextTheme().bodyLarge!.copyWith(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          // TODO: Get version code for Login screen
          // const Text("Version Code: 1053")
        ],
      ),
    );
  }
}

class DoLabel extends StatelessWidget {
  const DoLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      tr("signin").isEmpty ? "SignIn" : tr("signin"),
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    );
  }
}
