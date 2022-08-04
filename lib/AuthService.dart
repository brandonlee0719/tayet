// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart'
    show
        CollectionReference,
        DocumentSnapshot,
        FirebaseFirestore,
        QuerySnapshot,
        Timestamp;
import 'model/user_model.dart';

class AuthService {
  UserModel? _currentUser;
  UserModel get user => _currentUser!;

  CollectionReference userRef() =>
      FirebaseFirestore.instance.collection("users");

  Future<UserModel?> getUser(String id) async {
    UserModel? user;
    var userData = await userRef().doc(id).get();
    if (userData.data() != null) {
      user = UserModel.fromJson(userData.data()!);
      _currentUser = user;
    } else {
      user = null;
    }

    return user;
  }

  // Future<UserModel> getUser(String id) async {
  //   var userData = await userRef().doc(id).get();
  //   var user = UserModel.fromJson(userData.data()!);
  //   _currentUser = user;
  //   return user;
  // }

  Future<DocumentSnapshot> getUserSnapshot(String id) async {
    return await userRef().doc(id).get();
  }

  Future updateUserLastLogin(UserModel userModel) async {
    userRef().doc(userModel.id).update({"lastLoginDate": Timestamp.now()});
  }

// TODO: #13 Upon saving user data, update the last login date.
  Future saveUser(UserModel userModel) async {
    await userRef().doc(userModel.id).set(userModel.toJson());
  }

  Future updateContact(UserModel userModel, List<dynamic> contact) async {
    userRef().doc(userModel.id).update({"contacts": contact});
  }

  Future<UserModel?> getUserByPhone(String phone) async {
    QuerySnapshot data =
        await userRef().where("phoneNumber", isEqualTo: phone).get();
    if (data.docs.isNotEmpty) {
      final value = data.docs[0];

      return UserModel.fromJson(value.data());
    }
    return null;
  }
}
