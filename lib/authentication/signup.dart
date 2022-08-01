// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'package:auth_buttons/auth_buttons.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_auction/model/user_model.dart';
import 'package:smart_auction/repository.dart/user_repository.dart';
import 'package:smart_auction/user_screen.dart/dashboard/dashboard.dart';
import 'package:smart_auction/utils/colors.dart';
import 'package:smart_auction/utils/custom_textfield.dart';
import 'package:smart_auction/utils/custom_widget.dart';
import 'package:smart_auction/utils/font_family.dart';
import 'package:smart_auction/utils/screen_utils.dart';

import 'login.dart';

/// This is the class for the signup screen, DISABLED FOR NOW
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool darkMode = true;

  AuthButtonType? buttonType = AuthButtonType.secondary;
  AuthIconType? iconType;
  bool isHiddenPassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _countyController = TextEditingController();
  final _dobController = TextEditingController();
  DateTime? currentTime;
  DateTime? birthdayDate;
  final _userController = Get.find<UserRepository>();
  final Divider _divider = const Divider(height: 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whitecolor,
      body: Obx(() {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 100, bottom: 50),
                                child: Text(
                                  tr("createaccount"),
                                  style: TextStyle(
                                    color: AppColors.accentcolor,
                                    fontSize: 24,
                                    fontFamily: FontFamily.sofiaProBold,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr("firstname"),
                                    style: TextStyle(
                                      color: AppColors.accentcolor,
                                      fontSize: 14,
                                      fontFamily: FontFamily.sofiaPro,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextField(
                                    keyType: TextInputType.name,
                                    hint: "John",
                                    validate: (val) {
                                      if (val!.isEmpty) {
                                        return tr("fnr");
                                      } else {
                                        return null;
                                      }
                                    },
                                    textEditingController: _firstNameController,
                                    // validate: (String? value) {
                                    //   if (value!.isEmpty) {
                                    //     return 'enter your email';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    tr("lastname"),
                                    style: TextStyle(
                                      color: AppColors.accentcolor,
                                      fontSize: 14,
                                      fontFamily: FontFamily.sofiaPro,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextField(
                                    keyType: TextInputType.name,
                                    hint: "Doe",
                                    validate: (val) {
                                      if (val!.isEmpty) {
                                        return tr("lnr");
                                      }
                                      return null;
                                    },
                                    textEditingController: _lastNameController,
                                    // validate: (String? value) {
                                    //   if (value!.isEmpty) {
                                    //     return 'enter your email';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Username",
                                    style: TextStyle(
                                      color: AppColors.accentcolor,
                                      fontSize: 14,
                                      fontFamily: FontFamily.sofiaPro,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextField(
                                    keyType: TextInputType.name,
                                    hint: "Doe232",
                                    validate: (val) {
                                      if (val!.isEmpty) {
                                        return tr("ur");
                                      }
                                      return null;
                                    },
                                    textEditingController: _userNameController,
                                    // validate: (String? value) {
                                    //   if (value!.isEmpty) {
                                    //     return 'enter your email';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      color: AppColors.accentcolor,
                                      fontSize: 14,
                                      fontFamily: FontFamily.sofiaPro,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomTextField(
                                    keyType: TextInputType.emailAddress,
                                    hint: "johndoe123@gmail.com",
                                    textEditingController: _emailController,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return tr('er');
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    tr("password"),
                                    style: TextStyle(
                                      color: AppColors.accentcolor,
                                      fontSize: 14,
                                      fontFamily: FontFamily.sofiaPro,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.done,
                                    obscureText: isHiddenPassword,
                                    controller: _passwordController,

                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          (12),
                                        ),
                                        borderSide: BorderSide(
                                          color: AppColors.secondary,
                                          width: getProportionateScreenWidth(1),
                                        ),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: _togglePasswordView,
                                        child: Icon(
                                          isHiddenPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: isHiddenPassword
                                              ? AppColors.accentcolor
                                              : AppColors.primarycolor,
                                        ),
                                      ),
                                      hintText: tr('password'),
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                            color: AppColors.accentcolor,
                                            fontFamily: FontFamily.sofiaPro,
                                            fontSize: 14,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    // validator: (String value) {
                                    //   if (value.isEmpty) {
                                    //     return 'enter your password';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    tr("dob"),
                                    style: TextStyle(
                                      color: AppColors.accentcolor,
                                      fontSize: 14,
                                      fontFamily: FontFamily.sofiaPro,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          theme: const DatePickerTheme(
                                              // cancelStyle: const TextStyle(
                                              //     color: Color(TEXT_COLOR_PRIMARY), fontSize: 16),
                                              // headerColor: Color(COLOR_HEADER),
                                              backgroundColor: Colors.black,
                                              itemStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              doneStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                          onChanged: (date) {
                                        birthdayDate = date;
                                        _dobController.text = birthdayDate!
                                            .toLocal()
                                            .toString()
                                            .split(" ")[0];
                                      }, onConfirm: (date) {
                                        if (kDebugMode) {
                                          print('confirm $date');
                                        }
                                        currentTime = date;
                                      },
                                          currentTime: (currentTime != null)
                                              ? currentTime
                                              : DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    child: CustomTextField(
                                      keyType: TextInputType.number,
                                      hint: "09/09/1967",
                                      enabled: false,
                                      textEditingController: _dobController,
                                      // validate: (String? value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'enter your email';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    tr("country"),
                                    style: TextStyle(
                                      color: AppColors.accentcolor,
                                      fontSize: 14,
                                      fontFamily: FontFamily.sofiaPro,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        showPhoneCode:
                                            true, // optional. Shows phone code before the country name.
                                        onSelect: (Country country) {
                                          if (kDebugMode) {
                                            print(
                                                'Select country: ${country.displayName}');
                                          }
                                          _countyController.text =
                                              country.displayName;
                                        },
                                      );
                                    },
                                    child: CustomTextField(
                                      keyType: TextInputType.name,
                                      hint: "United State",
                                      enabled: false,
                                      textEditingController: _countyController,
                                      // validate: (String? value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'enter your email';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                onPressed: () {
                                  // TODO: User registration on firebase
                                  if (kDebugMode) {
                                    print(
                                        "sign up button pressed $_userController.status ");
                                  }
                                  UserModel userModel = UserModel(
                                      country: _countyController.text,
                                      firstName: _firstNameController.text,
                                      dob: DateTime.parse(_dobController.text),
                                      createdAt: DateTime.now(),
                                      lastName: _lastNameController.text,
                                      userName: _userNameController.text,
                                      email: _emailController.text,
                                      wpId: 0,
                                      id: "");

                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    if (kDebugMode) {
                                      print('email: ${_emailController.text}');
                                      print(
                                          'password: ${_passwordController.text}');
                                      print('dob: ${_dobController.text}');
                                      print(
                                          'country: ${_countyController.text}');
                                    }
                                    _userController.signUp(
                                        _emailController.text,
                                        _passwordController.text,
                                        userModel,
                                        _countyController.text);
                                  }

                                  // Get.log(Status.isLoading.toString());

                                  // if (_userController.status !=
                                  //         Status.isLoading &&
                                  //     _formKey.currentState!.validate()) {
                                  //   print("sign up button pressed 483");
                                  //   if (birthdayDate != null) {
                                  //     print("sign up button pressed 483");
                                  //     _userController.signUp(
                                  //         _emailController.text,
                                  //         _passwordController.text,
                                  //         userModel);
                                  //   } else {
                                  //     Get.snackbar(
                                  //         "Error", "Please select DOB");
                                  //   }
                                  // } else {
                                  //   print("sign up button pressed 495");
                                  // }
                                  // // Get.to(LoginScreen());
                                },
                                child: (_userController.status ==
                                        Status.isLoading)
                                    ? const Center(
                                        child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            )),
                                      )
                                    : Text(
                                        tr('createaccount'),
                                        style: GoogleFonts.changaTextTheme()
                                            .labelMedium,
                                      ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: const Text("or"),
                                ),
                              ),
                              GoogleAuthButton(
                                onPressed: () {
                                  // your implementation
                                  _userController.signInWithGoogle();
                                  // setState(() {
                                  //   isLoading = !isLoading;

                                  // });
                                },
                                darkMode: darkMode,
                                isLoading: isLoading,
                                style: AuthButtonStyle(
                                  buttonType: buttonType,
                                  iconType: iconType,
                                ),
                              ),
                              _divider,
                              AppleAuthButton(
                                onPressed: () {
                                  _userController.signinWithApple();
                                },
                                darkMode: darkMode,
                                isLoading: isLoading,
                                style: AuthButtonStyle(
                                  buttonType: buttonType,
                                  iconType: iconType,
                                ),
                              ),
                              _divider,
                              FacebookAuthButton(
                                onPressed: () {},
                                darkMode: darkMode,
                                isLoading: isLoading,
                                style: AuthButtonStyle(
                                  buttonType: buttonType,
                                  iconType: iconType,
                                ),
                              ),
                              Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customDescriptionText(
                                    tr("alreadymember"),
                                    onTap: () {
                                      Get.offAll(() => const Dashboard());
                                    },
                                    textAlign: TextAlign.center,
                                    colors: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  customDescriptionText(
                                    tr("signin"),
                                    onTap: () {
                                      Get.offAll(() => LoginScreen());
                                    },
                                    textAlign: TextAlign.center,
                                    colors: AppColors.primarycolor,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              )),
                            ])))));
      }),
    );
  }

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
