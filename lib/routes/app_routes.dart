import 'package:texting_app/pages/chat_list_page.dart';
import 'package:texting_app/pages/chat_page.dart';
import 'package:texting_app/pages/login_page.dart';
import 'package:texting_app/pages/profile_page.dart';
import 'package:texting_app/pages/registration_page.dart';
import 'package:texting_app/pages/view_contact_page.dart';

import '../_trash/trash_chatlist_page.dart';

class AppRoutes{
  static var appRoutes = {
    LoginPage.routeName: (_) => LoginPage(),
    RegistrationPage.routeName: (_) => RegistrationPage(),
    ProfilePage.routeName: (_) => ProfilePage(),
    ViewContactPage.routeName: (_) => ViewContactPage(),
    ChatListPage.routeName: (_) => ChatListPage(),
    // ChatPage.routeName: (_) => ChatPage(),
    // MyWidget.routeName: (_) => MyWidget(),
  };
}