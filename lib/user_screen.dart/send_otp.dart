import 'package:country_picker/country_picker.dart';
import 'package:flag/flag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_auction/repository.dart/user_repository.dart';
import 'package:smart_auction/user_screen.dart/verify_otp.dart';

import '../utils/colors.dart';

class SendOtp extends StatefulWidget {
  const SendOtp({Key? key}) : super(key: key);

  _SendOtpState createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _authController = Get.find<UserRepository>();
  String countryFlag = "BH";
  String countryCode = "973";

  @override
  void initState() {
    super.initState();
    _authController.countryText = countryCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: const Text(
                      "Phone Number",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: AppColors.primarycolor, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showCountryCode(context);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: AppColors.primarycolor, width: 2)),
                            // borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                          ),
                          height: 50,
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              Flag.fromString(countryFlag,
                                  height: 30, width: 30),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 24,
                                color: AppColors.primarycolor.withOpacity(0.5),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _authController.phoneNumberController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "9034678966",
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              prefixText: "+$countryCode ",
                              prefixStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),

                const Expanded(child: SizedBox()),
                // Container(
                //     margin: EdgeInsets.only(left: 50, right: 50),
                //     child: RichText(
                //         textAlign: TextAlign.center,
                //         text: TextSpan(
                //             text: "By clicking Continue, you agree to our ",
                //             style: TextStyle(
                //                 fontSize: 12,
                //                 color: Colors.black,
                //                 letterSpacing: 1),
                //             children: [
                //               TextSpan(
                //                 text: "Terms of use ",
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                   color: AppColor().backgroundColor,
                //                   letterSpacing: 0.5,
                //                 ),
                //                 recognizer: TapGestureRecognizer()
                //                   ..onTap = termOfUse,
                //               ),
                //               TextSpan(
                //                 text: "and ",
                //                 style: TextStyle(
                //                     fontSize: 12,
                //                     color: Colors.black,
                //                     letterSpacing: 1),
                //               ),
                //               TextSpan(
                //                 text: "and Privacy policy",
                //                 style: TextStyle(
                //                     fontSize: 12,
                //                     color: AppColor().backgroundColor,
                //                     letterSpacing: 0.5),
                //                 recognizer: TapGestureRecognizer()
                //                   ..onTap = privacyPolicy,
                //               )
                //             ]))),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (_authController.phoneNumberController.text == '') {
                      Get.snackbar(
                          'Alert', 'Enter your phone number to continue!',
                          titleText: const Text(
                            'Alert',
                          ),
                          messageText: const Text(
                            'Enter your phone number to continue!',
                          ),
                          icon: const Icon(Icons.info,
                              color: AppColors.primarycolor));
                      if (kDebugMode) {
                        print('phone cannot be empty');
                      }
                    } else if (_authController
                            .phoneNumberController.text.length >
                        10) {
                      Get.snackbar('Alert', 'Invalid phone number!',
                          titleText: const Text(
                            'Alert',
                          ),
                          messageText: const Text(
                            'Invalid phone number!',
                          ),
                          icon: const Icon(Icons.info,
                              color: AppColors.primarycolor));
                      if (kDebugMode) {
                        print('phone cannot be empty');
                      }
                    } else {
                      Get.to(VerifyPhoneNumberScreen(
                          phoneNumber:
                              "+$countryCode${_authController.phoneNumberController.text}"));
                      // _authController.sendSmsOtp();
                      // _homeController.selectOnboardSelectedNext();
                      // Get.to(() => Signup());
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 50, right: 50),
                    height: 50,
                    decoration: const BoxDecoration(
                        color: AppColors.primarycolor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: AppColors.primarycolor,
                            size: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 40,
                )
              ]),
        ),
      ),
    );
  }

  Future showCountryCode(BuildContext context) async {
    showCountryPicker(
      context: context,
      showPhoneCode:
          true, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        countryCode = country.toJson()['e164_cc'];
        countryFlag = country.toJson()['iso2_cc'];

        country.toJson();
        setState(() {});

        if (kDebugMode) {
          print('Select country: ${country.toJson()}');
        }
      },
    );
  }
}
