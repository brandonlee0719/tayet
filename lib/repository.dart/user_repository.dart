// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../AuthService.dart';
import '../SharedPreference/sharepref.dart';
import '../apilink.dart';
import '../authentication/login.dart';
import '../model/user_model.dart';
import '../repository.dart/wallet_repository.dart';
import '../user_screen.dart/bottom_nav.dart';
import '../user_screen.dart/edit_profile.dart';

enum Status {
  isFirstTime,
  uninitialStat,
  authenticStat,
  Authenticating,
  Unauthenticated,
  invalidEmail,
  wrongPassword,
  userNotFound,
  tooManyRequests,
  operationNotAllowed,
  userDisabled,
  unknown,
  isLoading,
  Success,
  Error,
  phoneNumberExisted,
  googleSigninLoading
}

enum AddAdminStatus { Success, Error, Loading, Empty, UserNotFound }

class UserRepository extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Status _status = Status.uninitialStat;
  String? _error;
  var getContacts = [];
  var newgetContacts = [];

  StreamSubscription? _userListener;
  final storageBox = GetStorage();

  var check = [];
  List<String> myContactAvailable = [];
  final Rx<UserModel?> _fsUsers = Rx(null);
  final _user = UserModel().obs;

  List<UserModel> friends = [];
  List<UserModel> allfriends = [];
  var isadmin = false.obs;
  final _addAdminStatus = AddAdminStatus.Empty.obs;

  String countryText = "973";

  final phoneNumberController = TextEditingController();
  AddAdminStatus get addAdminStatus => _addAdminStatus.value;
//  List<Asset> images = List<Asset>();
  final GoogleSignIn? _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final isAgree = false.obs;
  final status = Status.uninitialStat.obs;
  SharedPref? pref;
//  Device currentDevice;

  bool? _loading;
  List<UserModel> allUsers = [];
  final _passwordVisible = false.obs;
  // Rx<File> image = Rx<File>(null);
  Rx<File?> muserFile = Rx(null);

  // ANCHOR: Changed the Firestore collection name to userProfiles
  CollectionReference userRef() =>
    // FirebaseFirestore.instance.collection('users');
    FirebaseFirestore.instance.collection('userProfiles');

  String get error => _error!;

  Status get getStatus => _status;

  // User get fbUser => _user.value;

  // Rx<UserModel?> _user=Rx(null);
  UserModel get userModel => _user.value;

  bool get isLoading => _loading!;
  bool get isPasswordVisible => _passwordVisible.value;
  File? get userFile => muserFile.value;
  String? userId;

  @override
  void onInit() async {
    super.onInit();
    if (FirebaseAuth.instance.currentUser != null) {
      if (kDebugMode) {
        print("user is loggedin ${FirebaseAuth.instance.currentUser!.uid} ");
        print("userName is ${FirebaseAuth.instance.currentUser!.displayName} ");
      }
      _user(await getUser(FirebaseAuth.instance.currentUser!.uid));
      if (userModel.id != "") {
        status(Status.authenticStat);
      }
    } else {
      status(Status.Unauthenticated);
    }
    pref = SharedPref();
    pref!.init();

    status.listen((p0) async {
      if (p0 == Status.authenticStat) {
//  getAllUser();

// if(FirebaseAuth.instance.currentUser.email.contains("admin@gmail.com")|| FirebaseAuth.instance.currentUser.email.contains("peldam@elejant.com")){

//    }else{
//      print("firebase auth is null");
//       // _user( await getUser(FirebaseAuth.instance.currentUser.uid));
//       // AuthService().updateUserLastLogin(user);

//      if(Platform.isAndroid &&pref.isAgree()){
//       refreshContacts2();
//      }else{
//        refreshContacts2();
//      }
//       getContact(user.contacts);
//     }
      }
    });
  }

  void updateAddAdminStatus(AddAdminStatus addAdminStatus) {
    _addAdminStatus(addAdminStatus);
  }
//   Future makeUserAdmin({String phone})async{

// _addAdminStatus(AddAdminStatus.Loading);

// final user= await getUserByPhone(phone);
// if(user==null){
// _addAdminStatus(AddAdminStatus.UserNotFound);
//   return;
// }
// user.isadmin=true;
// print("user map ${user.toMap()}");
// userRef().doc(user.id).update(user.toMap());

// _addAdminStatus(AddAdminStatus.Success);
//   }

  // Future setcontactpermissionStatus(bool value)async{

  //   pref.setReadAgree(value);
  //   if(value){
  // if (await Permission.contacts.request().isGranted) {
  //   // Either the permission was already granted before or the user just granted it.
  //   }else{

  //     Permission.contacts.request();
  //   }
  //   }
  // Get.off(WelcomeScreen());
  // }
  Future getAllUser() async {
    QuerySnapshot snapshot = await userRef().get();
    snapshot.docs.forEach((element) {
      allUsers.add(UserModel.fromJson(element.data()));
    });
  }

  Future signinWithPhoneNumber(UserCredential fireUser) async {
    // if(Fire)
    userId = fireUser.user!.uid;
    print("user id is $userId");
    UserModel? user = await getUser(userId!);

    if (user == null) {
      userId = fireUser.user!.uid;
      Get.to(() => const UpdateProfile());
    } else {
      _user(user);
      Get.off(() => const NavigationBottomBar());
    }
  }

  Future createProfile(UserModel userModel) async {
    userModel.id = userId!;
    userRef().doc(userId).set(userModel.toJson());
    storageBox.write("id", userId);
    storageBox.write("wpId", userModel.wpId);
    storageBox.write("userName", userModel.firstName);
    // storageBox.write("isadmin", userModel.isAdmin);
    Get.off(() => const NavigationBottomBar());
  }

  Future forgetPassword(String email) async {
    try {
      status(Status.isLoading);
      var generateLink = await _createDynamicLink(false);
      if (kDebugMode) {
        print("dynamic link $generateLink");
      }
      var actionCodeSettings = ActionCodeSettings(
          url: generateLink,
          dynamicLinkDomain: "tayet-3aleeh.page.link",
          androidPackageName: "com.tayet",
          androidInstallApp: true,
          androidMinimumVersion: "1.0.5",
          iOSBundleId: "com.tayet",
          handleCodeInApp: true);
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email, actionCodeSettings: actionCodeSettings);
      Get.snackbar('Success', 'Reset email successfully sent!',
          snackPosition: SnackPosition.BOTTOM);
      status(Status.Success);
      // Get.to(VerificationSent(email: email,));
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid email") {
        status(Status.invalidEmail);
        Get.snackbar('Error', 'Email is not found`',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        if (kDebugMode) {
          print("error message is ${e.message}");
        }
        status(Status.Error);
        Get.snackbar('Error', 'Error has occurred',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<String> _createDynamicLink(bool short) async {
    // final DynamicLinkParameters parameters = DynamicLinkParameters(
    //   uriPrefix: 'https://tayet-3aleeh.page.link',
    //   link: Uri.parse('https://tayet-3aleeh.page.link/recoverypassword'),
    //   androidParameters: AndroidParameters(
    //     packageName: 'com.tayet',
    //     minimumVersion: 0,
    //   ),
    //   dynamicLinkParametersOptions: DynamicLinkParametersOptions(
    //     shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
    //   ),
    //   iosParameters: IosParameters(
    //     bundleId: 'com.tayet',
    //     minimumVersion: '0',
    //   ),
    // );

    // Uri url;
    // if (short) {
    //   final ShortDynamicLink shortLink = await parameters.buildShortLink();
    //   url = shortLink.shortUrl;
    // } else {
    //   url = await parameters.buildUrl();
    // }

    return '';
    // url.toString();
  }

  Future updateStatus(Status statu) async {
    status(statu);
  }

  Future updatePasswordVisbility() async {
    _passwordVisible(!isPasswordVisible);
  }

  Future<bool?> updateisfirsttime() async {
    pref!.setFirstTimeAppOpen(false);
    return null;
  }

  Future signIn(String email, String password) async {
    try {
      status(Status.isLoading);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final loggedUser = await getUser(userCredential.user!.uid);
      _user(loggedUser);
      if (kDebugMode) {
        print("Getting value ${userModel.toJson().length}");
      }

      if (kDebugMode) {
        print("user json ${userModel.toJson()}");
      }

      AuthService().updateUserLastLogin(userModel);
      Get.log("User status: $_status!");

      if (loggedUser!.id!.isNotEmpty) {
        Get.log("User Logged in! ${loggedUser.firstName}", isError: false);
        status(Status.Authenticating);
        Get.off(() => const NavigationBottomBar());
      } else {
        Get.log("User NOT Logged in! ${loggedUser.firstName}", isError: true);
        _status = Status.Unauthenticated;
        status(Status.Unauthenticated);
      }
      status(userCredential.user!.uid.isNotEmpty
          ? Status.authenticStat
          : Status.Unauthenticated);
      if (Status.Unauthenticated == _status) {
        Get.off(() => LoginScreen());
        Get.snackbar("Error", tr("wrongpassword"),
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.off(() => const NavigationBottomBar());
      }
      // Get.off(() => const NavigationBottomBar());

      // _error = '';
      return true;
    } catch (e) {
      if (kDebugMode) {
        Get.log("! ERROR $e", isError: true);
      }

      switch (e) {
        case 'invalid-email':
          Get.snackbar("Error", "Invalid Email");
          if (kDebugMode) {
            print("error is invalid email");
          }
          status(Status.invalidEmail);
          break;
        case 'unknown':
//
//_status=Status.
          status(Status.unknown);
          break;
        case 'wrong-password':
          Get.snackbar("Error", "Wrong email or password");
          status(Status.wrongPassword);

//          _status=Status.wrong_password;

          break;
        case 'user-not-found':
          if (kDebugMode) {
            print("error user-not-found");
          }
          Get.snackbar("Error", "User not found");
//          _status=Status.user_not_found;
          status(Status.userNotFound);
          break;
        case 'user_disabled':
//          _status=Status.user_disabled;
          Get.snackbar("Error", "User is disabled");
          status(Status.userDisabled);
          break;
        case 'too-many-requests':
          Get.snackbar("Error", "Too many request.. try again in few minutes");
//          _status=Status.too_many_requests;
          status(Status.tooManyRequests);
          break;
        case 'operation_not_allowed':
          Get.snackbar("Error", "Operation not allowed");
//          _status=Status.operation_not_allowed;
          status(Status.operationNotAllowed);
          break;
        default:
          Get.snackbar("Error", "Unknown error:: 🦧 " + e.toString());
          break;
      }
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future signUp(String email, String password, UserModel userModel,
      [String? text]) async {
    try {
      if (kDebugMode) {
        print("sign up loading.... $email $password");
      }
      status(Status.isLoading);
//    final value= await getUserByPhone(userModel.);

//    if(value!=null){
// status(Status.Phone_Number_Existed);
//      return false;
//    }
      int newWPId = await registerUserOnServer(userModel, password);

      if (newWPId < 0) {
        status(Status.unknown);
        return;
      }
      userModel.wpId = newWPId;
      if (kDebugMode) {
        print("result for server $newWPId");
      }
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print("usermodel ${userModel.toJson()}");
      }
      if (userCredential.user != null) {
        userModel.id = userCredential.user!.uid;
        userModel.email = email;
        // user=userModel;

        await AuthService().saveUser(userModel);
        // _error = '';
        status(Status.authenticStat);
        final walletRepository = Get.find<WalletRepository>();
        walletRepository.createWallet(userModel.id!);

        Get.off(() => const NavigationBottomBar());
      } else {
        status(Status.Error);
        _error = "Not Successful";
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
        Get.snackbar("Error", "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "The account already exists for that email.");
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (ex) {
      _error = ex.toString();
      if (kDebugMode) {
        print("error is occuured ${ex.toString()}");
      }
      Get.snackbar("Error", "Error Occurred");
      if (kDebugMode) {
        print(_error);
      }
      status(Status.Unauthenticated);

      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();

    _status = Status.Unauthenticated;
    _user(null);

    status(Status.Unauthenticated);
    Get.offAll(() => LoginScreen());
    storageBox.erase();
    Get.log("GetX Storage Erased! \n User status: $_status");
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<UserModel?> getUser(String id) async {
    print("user from getUser user is $id");
    final value = await AuthService().getUser(id);
    _user(value);
    // if (value != null) print("getting user ${value.toJson()}");
    return value;
  }

  bool isAdmin() {
    return isadmin.value;
  }

  /// Register users on Wordpress API and return the user id.
  /// TODO: Refactor this method to use the API service properly
  Future<int> registerUserOnServer(UserModel userModel, String password) async {
    try {
      String username = 'appdeamon';
      String password = 'Zop6 1HYu 2SIt Ddvp hBUX 8YPg';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      var response = await http.post(Uri.parse(ApiLink.wpUsersAPI),
          body: jsonEncode({
            "username": userModel.userName,
            "first_name": userModel.firstName,
            "last_name": userModel.lastName,
            "password": password,
            "email": userModel.email,
            "roles": "bidderstarter"
          }),
          headers: {
            "Content-Type": "application/json",
            "Authorization": basicAuth,
          });
      if (kDebugMode) {
        print(
            "server sign in response ${response.statusCode} ${response.body} ");
      }
      if (response.statusCode == 500) {
        Get.off(() => LoginScreen());
        return -1;
      } else if (response.statusCode == 201) {
        var json = jsonDecode(response.body);
        Get.log("User created on server: $json['id']");
        return json['id'];
      } else {
        var json = jsonDecode(response.body);
        _error = json['message'];
        Get.snackbar("Error", _error!);
        return -1;
      }
    } catch (ex) {
      return -1;
    }
  }

// update user profile on the wordpress server
  Future<int> updateProfile(UserModel user) async {
    try {
      String username = 'appdeamon';
      String password = 'Zop6 1HYu 2SIt Ddvp hBUX 8YPg';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      String url = ApiLink.wpUpdateUsersAPI +
          userModel.wpId!.toString() +
          ApiLink.wpUpdateUsersEmbedAPI;
      print(url);
      var response = await http.post(
          Uri.parse(ApiLink.wpUpdateUsersAPI +
              userModel.wpId!.toString() +
              ApiLink.wpUpdateUsersEmbedAPI),
          body: jsonEncode({
            "id": userModel.wpId!.toString(),
            "username": userModel.userName,
            "first_name": userModel.firstName,
            "last_name": userModel.lastName,
            // "password": password,
            "email": userModel.email,
            "roles": "bidderstarter"
          }),
          headers: {
            "Content-Type": "application/json",
            "Authorization": basicAuth,
          });
      if (kDebugMode) {
        print(
            "server sign in response ${response.statusCode} ${response.body} ");
      }
      if (response.statusCode == 500) {
        Get.off(() => LoginScreen());
        return -1;
      } else if (response.statusCode == 201) {
        var json = jsonDecode(response.body);
        status(Status.Success);
        Get.snackbar("Success", "Profile update successfully");
        var muser = await getUser(user.id!);
        _user(muser);
        return json['id'];
      } else {
        var json = jsonDecode(response.body);
        _error = json['message'];
        Get.snackbar("Error", _error!);
        return -1;
      }
    } catch (ex) {
      return -1;
    }
  }

/*
  Future updateProfile(UserModel user) async {
    try {
      status(Status.isLoading);
      if (userFile != null) {
        String? imageUrl = await saveImage();
        user.imageUrl = imageUrl;
      }

      userRef().doc(user.id).update(user.toJson());
      status(Status.Success);
      Get.snackbar("Success", "Profile update successfully");
      var muser = await getUser(user.id!);
      _user(muser);
      update();
    } catch (ex) {
      Get.snackbar("Error", "Unable to update profile right now. try again");
      status(Status.Error);
    }
  } */

  Future<String?> saveImage() async {
    // ByteData byteData =
    //     await asset.getByteData(); // requestOriginal is being deprecated
    // List<int> imageData = byteData.buffer.asUint8List();
    status(Status.isLoading);
    // Reference ref = FirebaseStorage.instance.ref().child(
    //     '${userModel.userName}profileimage'); // To be aligned with the latest firebase API(4.0)
    // UploadTask uploadTask = ref.putFile(userFile!);

    // return (await uploadTask.then((value) => value.ref.getDownloadURL()));
    return null;
  }

  Future signinWithApple() async {
    if (kDebugMode) {
      print("trying to signin in apple");
    }
    try {
      AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);

      if (credential.identityToken != null) {
        final oAuthProvider = OAuthProvider('apple.com');
        final signinCrediential = oAuthProvider.credential(
          idToken: credential.identityToken,
          accessToken: credential.authorizationCode,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(signinCrediential);

        var user = await getUser(userCredential.user!.uid);

        status(Status.authenticStat);
        if (user == null) {
          if (kDebugMode) {
            print("user id is $userId");
          }
          userId = userCredential.user!.uid;
          UserModel userModel = UserModel(
              id: userId!,
              email: credential.email,
              // imageUrl: user.photoUrl,
              userName: credential.givenName,
              createdAt: DateTime.now(),
              wpId: 0);
          userRef().doc(userId).set(userModel.toJson());
          _user(userModel);
          Get.off(() => const NavigationBottomBar());
        } else {
          _user(user);
          Get.off(() => const NavigationBottomBar());
        }
      }
    } catch (ex) {
      print("error occurred ${ex.toString()}");
    }
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    var contactText = 'Loading contact info...';

    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      contactText = 'People API gave a ${response.statusCode} '
          'response. Check logs for details.';

      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);

    if (namedContact != null) {
      contactText = '$namedContact!';
    } else {
      contactText = 'No contacts to display.';
    }

    UserModel userModel = UserModel(
        id: userId!,
        email: user.email,
        imageUrl: user.photoUrl,
        userName: namedContact,
        createdAt: DateTime.now(),
        wpId: 0);

    userRef().doc(userId!).set(userModel.toJson());
    _user(userModel);

    Get.off(() => const NavigationBottomBar());
  }

  Future<void> signInWithGoogle() async {
    try {
      status(Status.googleSigninLoading);
      var result = await _googleSignIn!.signIn();

      if (result != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await result.authentication;
        // FirebaseAuth.instance.signInWithCredential(result.)
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        userId = FirebaseAuth.instance.currentUser!.uid;

        var user = await getUser(userId!);

        status(Status.authenticStat);
        if (user == null) {
          print("user id is $userId");
          _handleGetContact(result);
        } else {
          _user(user);
          Get.off(() => const NavigationBottomBar());
        }
      }
      status(Status.Success);
    } catch (error) {
      status(Status.Error);
      print(error);
    }
  }

  Future SignInWithFacebook() async {
// FirebaseAuth.instance.

    final LoginResult result = await FacebookAuth.instance.login(permissions: [
      "email",
      "public_profile",
      "user_friends"
    ]); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
    } else {
      print(result.status);
      print(result.message);
    }
  }

  Future getFbData() async {
    final userData = await FacebookAuth.instance.getUserData();
    String userId = userData['id'];
    UserModel? user = await getUser(userId);

    if (user != null) {
      _user(user);
      status(Status.authenticStat);
      Get.off(() => const NavigationBottomBar());
    } else {
      UserModel muser = UserModel(
          email: userData['email'],
          firstName: userData['name'].split("")[0],
          lastName: userData['name'].split("")[0],
          imageUrl: userData['picture']['data']['url'],
          createdAt: DateTime.now(),
          id: userData['id'],
          wpId: 0);
      userRef().doc(muser.id).set(muser.toJson());
      status(Status.authenticStat);
      Get.off(() => const NavigationBottomBar());
    }
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }
}
