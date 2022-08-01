// ignore_for_file: unrelated_type_equality_checks

import 'dart:ui';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_auction/repository.dart/user_repository.dart';

import '../base/app_lib.dart';
import '../user_screen.dart/bottom_nav.dart';
import '../user_screen.dart/send_otp.dart';
import '../utils/colors.dart';
import 'signup.dart';

class HomeLoginScreen extends StatefulWidget {
  HomeLoginScreen({Key? key}) : super(key: key);

  @override
  _HomeLoginScreenState createState() => _HomeLoginScreenState();
}

class _HomeLoginScreenState extends State<HomeLoginScreen>
    with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(const Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _userController = Get.find<UserRepository>();
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 53, 71, 92),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Stack(children: [
                Positioned(
                  top: size.height * (animation2.value + .58),
                  left: size.width * .21,
                  child: CustomPaint(
                    painter: MyPainter(50),
                  ),
                ),
                Positioned(
                  top: size.height * .98,
                  left: size.width * .1,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value - 30),
                  ),
                ),
                Positioned(
                  top: size.height * .5,
                  left: size.width * (animation2.value + .8),
                  child: CustomPaint(
                    painter: MyPainter(30),
                  ),
                ),
                Positioned(
                  top: size.height * animation3.value,
                  left: size.width * (animation1.value + .1),
                  child: CustomPaint(
                    painter: MyPainter(60),
                  ),
                ),
                Positioned(
                  top: size.height * .1,
                  left: size.width * .8,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value),
                  ),
                ),
                Column(children: <Widget>[
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
                          // TODO: Needs a text controller
                          decoration: InputDecoration(
                              icon: const Icon(
                                Icons.email,
                                color: AppColors.primarycolor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100)),
                              labelText: "Email",
                              enabledBorder: InputBorder.none,
                              labelStyle: const TextStyle(color: Colors.grey)),
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: const Icon(
                                Icons.vpn_key,
                                color: AppColors.primarycolor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100)),
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
                              style: GoogleFonts.changaTextTheme()
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppColors.primarycolor,
                                      fontSize: 13),
                            ),
                          ))),
                  GFButton(
                    onPressed: () {
                      // FIXME: Firebase sign in
                      if (_userController.status != Status.isLoading) {
                        _userController.signIn(
                            _emailController.text, _passwordController.text);
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
                    textStyle: GoogleFonts.changaTextTheme()
                        .bodyLarge!
                        .copyWith(
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
                          style: GoogleFonts.changaTextTheme()
                              .bodyLarge!
                              .copyWith(
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
                    textStyle: GoogleFonts.changaTextTheme()
                        .bodyLarge!
                        .copyWith(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                  ),
                ]),
              ]),
            ),
          ),
        ));
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    final _emailController = TextEditingController();
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: _emailController,
            style: TextStyle(color: Colors.white.withOpacity(.8)),
            cursorColor: Colors.white,
            obscureText: isPassword,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }

  Widget passBox(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    final _passwordController = TextEditingController();

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: _passwordController,
            style: TextStyle(color: Colors.white.withOpacity(.8)),
            cursorColor: Colors.white,
            obscureText: isPassword,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }

  Widget component2(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: voidCallback,
          child: Container(
            height: size.width / 8,
            width: size.width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(color: Colors.white.withOpacity(.8)),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
              // colors: [Color(0xffFD5E3D), Color(0xffC43990)],
              colors: [AppColors.primarycolor, AppColors.orangecolor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: const Offset(10, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
