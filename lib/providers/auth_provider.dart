import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:texting_app/auth/auth_service.dart';
import 'package:texting_app/model/user_model.dart';
import 'package:texting_app/pages/chat_list_page.dart';
import 'package:texting_app/pages/login_page.dart';
import 'package:texting_app/providers/chat_provider.dart';
import 'package:texting_app/providers/user_provider.dart';
import 'package:texting_app/utils/helper_functions.dart';

class AuthProvider extends ChangeNotifier {
  String errMsg = '';
  bool addChat = false;

  addchat(){
    addChat = !addChat;
    notifyListeners();
  }

  aConVisiOff(){
    addChat = false;
    notifyListeners();
  }

  loginService({
    required String email,
    required String password,
    required GlobalKey<FormState> formKey,
    required BuildContext context,
  }) async {
    EasyLoading.show(status: 'Please Wait', dismissOnTap: false);
    if (formKey.currentState!.validate()) {
      try {
        final status = await AuthService.login(email, password);
        if (status) {
          if (!context.mounted) return;
          // await Provider.of<ChatProvider>(context,listen: false).fetchAllUserDetails();
          // await Provider.of<ChatProvider>(context,listen: false).findCurrentUserDetails();
          print(AuthService.user?.email);
          print('Entering ChatListPage');
          Navigator.pushReplacementNamed(context, ChatListPage.routeName);
        } else {
          EasyLoading.dismiss();
          await AuthService.logOut();
          errMsg = 'This email does not belong to an Admin account';
          if (!context.mounted) return;
          showMsg(context, errMsg, Colors.red);
          notifyListeners();
        }
      } on FirebaseAuthException catch (e) {
        errMsg = e.message!;
        print(errMsg);
        if (context.mounted) {
          showMsg(context, errMsg, Colors.red);
        }
        EasyLoading.dismiss();
        notifyListeners(); // Trigger a rebuild
      }
    } else {
      EasyLoading.dismiss();
    }
  }

  registrationService(
      {required String email,
        required String password,
        required String username,
        required String phone,
        required GlobalKey<FormState> formKey,
        required BuildContext context}) async {
    EasyLoading.show(status: 'Please Wait', dismissOnTap: false);
    if (formKey.currentState!.validate()) {
      try {
        final status = await AuthService.register(email, password);
        final userModel = UserModel(username: username, email: email, phoneList: [phone]);
        if (status && context.mounted) {
          Provider.of<UserProvider>(context,listen: false).addUser(userModel);
          Navigator.pushReplacementNamed(context, ChatListPage.routeName);
        } else {
          EasyLoading.dismiss();
          await AuthService.logOut();
          errMsg = 'This email does not belong to an Admin account';
          if (!context.mounted) return;
          showMsg(context, errMsg, Colors.red);
          notifyListeners();
        }
      } on FirebaseAuthException catch (e) {
        errMsg = e.message!;
        print(errMsg);
        if (context.mounted) {
          showMsg(context, errMsg, Colors.red);
        }
        EasyLoading.dismiss();
        notifyListeners(); // Trigger a rebuild
      }
    } else {
      EasyLoading.dismiss();
    }
  }

  logoutService(BuildContext context)async{
    await AuthService.logOut();
    await Provider.of<ChatProvider>(context,listen: false).resetData();
    Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName,(Route<dynamic> route) => false);
  }
}
