import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_auction/model/user_model.dart';
import 'package:smart_auction/utils/constants.dart';

import '../repository.dart/user_repository.dart';
import '../utils/colors.dart';
import '../utils/custom_textfield.dart';
import '../utils/font_family.dart';
import '../utils/screen_utils.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (_userController.userModel.id != null) {
      _emailController.text = _userController.userModel.email ?? "";
      _firstNameController.text = _userController.userModel.firstName ?? "";
      _lastNameController.text = _userController.userModel.lastName ?? "";
      _userNameController.text = _userController.userModel.userName ?? "";
      _countyController.text = _userController.userModel.country ?? "";
      if (_userController.userModel.dob != null) {
        _dobController.text = _userController.userModel.dob!.formatDate()!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("result is ${_userController.userModel.email}");
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          _userController.userModel.id == null ? tr("cp") : tr('up'),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primarycolor,
      ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Stack(children: [
                        Positioned(
                          top: 20,
                          left: 100,
                          right: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 2,
                                color: AppColors.primarycolor,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: (_userController.userFile != null)
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage: FileImage(
                                          _userController.userFile!,
                                        ))
                                    : (_userController.userModel.imageUrl ==
                                            null)
                                        ? const CircleAvatar(
                                            radius: 50,
                                            backgroundImage: AssetImage(
                                              "assets/images/user-male.png",
                                            ))
                                        : CircleAvatar(
                                            radius: 50.0,
                                            backgroundImage: NetworkImage(
                                                _userController
                                                    .userModel.imageUrl!),
                                            backgroundColor: Colors.transparent,
                                          )),
                          ),
                        ),
                        Positioned(
                          top: 90,
                          left: 200,
                          right: 115,
                          child: GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              // Pick an image
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              print("image selected  ${image!.path}");
                              // businessController.businessImage(File(image!.path));
                              _userController.muserFile(File(image.path));
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.primarycolor,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/addcamera.svg",
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("firstname",
                            style: GoogleFonts.changaTextTheme()
                                .caption!
                                .copyWith(
                                    color: AppColors.accentcolor,
                                    fontSize: 14)),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          keyType: TextInputType.name,
                          hint: "John",
                          validate: (val) {
                            if (val!.isEmpty) {
                              return "fnr";
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
                          "lastname",
                          style: GoogleFonts.changaTextTheme()
                              .caption!
                              .copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          keyType: TextInputType.name,
                          hint: "Doe",
                          validate: (val) {
                            if (val!.isEmpty) {
                              return "lnr";
                            }
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
                          "username",
                          style: GoogleFonts.changaTextTheme()
                              .caption!
                              .copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          keyType: TextInputType.name,
                          enabled: _userController.userModel.userName == null
                              ? true
                              : false,
                          hint: "Doe232",
                          validate: (val) {
                            if (val!.isEmpty) {
                              return "ur";
                            }
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
                          "email",
                          style: GoogleFonts.changaTextTheme()
                              .caption!
                              .copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          keyType: TextInputType.emailAddress,
                          hint: "johndoe123@gmail.com",
                          enabled: _userController.userModel.email == null ||
                                  _userController.userModel.email!.isEmpty
                              ? true
                              : false,
                          textEditingController: _emailController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'er';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "dob",
                          style: GoogleFonts.changaTextTheme()
                              .caption!
                              .copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            // FIXME: Date picker is not working
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime(2021))
                                .then((value) {
                              if (value != null) {
                                // _userController.muserFile(value);
                                Get.snackbar("Mandatory", "Please select date",
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            }).catchError((error) {
                              if (kDebugMode) {
                                print(error);
                              }
                            });

                            // BasicDateField(
                            //   controller: _dateController,
                            //   onChanged: (val) {
                            //     print("date selected $val");
                            //     _userController.muserDob(val);
                            //   },
                            // );

                            //                               DatePicker.showDatePicker(context,
                            //       showTitleActions: true,
                            //       theme: const DatePickerTheme(
                            //           // cancelStyle: const TextStyle(
                            //           //     color: Color(TEXT_COLOR_PRIMARY), fontSize: 16),
                            //           // headerColor: Color(COLOR_HEADER),
                            //           backgroundColor: Colors.black,
                            //           itemStyle: const TextStyle(
                            //               color: Colors.white, fontSize: 18),
                            //           doneStyle: const TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 16)), onChanged: (date) {
                            //     birthdayDate = date;
                            //     _dobController.text = birthdayDate!
                            //         .toLocal()
                            //         .toString()
                            //         .split(" ")[0];
                            //   }, onConfirm: (date) {
                            //     print('confirm $date');
                            //     currentTime = date;
                            //   },
                            //       currentTime: (currentTime != null)
                            //           ? currentTime
                            //           : DateTime.now(),
                            //       locale: LocaleType.en);
                            // },
                            // child: CustomTextField(
                            //   keyType: TextInputType.number,
                            //   hint: "09/09/1967",
                            //   enabled: false,
                            //   textEditingController: _dobController,
                            //   // validate: (String? value) {
                            //   //   if (value!.isEmpty) {
                            //   //     return 'enter your email';
                            //   //   }
                            //   //   return null;
                            //   // },
                            // ),
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
                          "country",
                          style: GoogleFonts.changaTextTheme()
                              .caption!
                              .copyWith(fontSize: 14),
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
                                _countyController.text = country.displayName;
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
                    // Spacer(flex: 10,),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(() {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () {
                          if (kDebugMode) {
                            print("update pressed");
                          }

                          UserModel user = _userController.userModel;
                          user.firstName = _firstNameController.text;
                          user.lastName = _lastNameController.text;
                          user.country = _countyController.text;
                          user.email = _emailController.text;

                          if (birthdayDate != null) {
                            user.dob = birthdayDate;
                          }

                          // UserModel userModel=UserModel(country: _countyController.text,firstName: _firstNameController.text,dob: birthdayDate,createdAt: DateTime.now(),
                          // lastName: _lastNameController.text,userName: _userNameController.text,email: _emailController.text);
                          // _userController.user.id=null;
                          if (_userController.status.value !=
                              Status.isLoading) {
                            if (_formKey.currentState!.validate()) {
                              if (_userController.userModel.id == null) {
                                if (kDebugMode) {
                                  print("trying to create profile");
                                }
                                user.createdAt = DateTime.now();
                                _userController.createProfile(user);
                              } else {
                                _userController.updateProfile(user);
                              }
                              if (kDebugMode) {
                                print("value is gotten");
                              }
                            }
                          }
                          // Get.to(LoginScreen());
                        },
                        child:
                            (_userController.status.value == Status.isLoading)
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
                                    _userController.userModel.id == null
                                        ? 'cp'
                                        : 'update',
                                    style: GoogleFonts.changaTextTheme()
                                        .caption!
                                        .copyWith(fontSize: 16),
                                  ),
                      );
                    }),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  BasicDateField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}
