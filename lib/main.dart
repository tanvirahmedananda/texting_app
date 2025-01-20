import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texting_app/pages/chat_list_page.dart';
import 'package:texting_app/pages/chat_page.dart';
import 'package:texting_app/pages/login_page.dart';
import 'package:texting_app/pages/profile_page.dart';
import 'package:texting_app/providers/auth_provider.dart';
import 'package:texting_app/providers/chat_provider.dart';
import 'package:texting_app/providers/text_field_provider.dart';
import 'package:texting_app/providers/user_provider.dart';
import 'package:texting_app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => ChatProvider()),
    ChangeNotifierProvider(create: (_) => TextFieldProvider()),
  ],child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.appRoutes,
      initialRoute: LoginPage.routeName,
    );
  }
}
