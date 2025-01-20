import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:texting_app/db/db_helper.dart';
import 'package:texting_app/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  ///REGISTER NEW USERDATA
  Future<void> addUser(UserModel userModel) => DbHelper.addUser(userModel);

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUser(String phone) => DbHelper.getCurrentUser(phone);

}
