import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texting_app/pages/registration_page.dart';
import 'package:texting_app/providers/auth_provider.dart';
import 'package:texting_app/utils/constants.dart';
import 'package:texting_app/widget/common_text_form_field.dart';
import 'package:texting_app/widget/poppins_text.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login_page';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: '11@gmail.com');
  final passwordController = TextEditingController(text: "11111111");

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Consumer<AuthProvider>(
            builder: (child, authProv, _) => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Center(
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                              left: mQWidth(41, context),
                              right: mQWidth(41, context)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: mQHeight(120, context),
                                child: Image.asset(
                                  'images/logo.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              SizedBox(
                                height: mQHeight(50, context),
                              ),

                              ///Email TextFormField
                              CommonTextFormField(
                                controller: emailController,
                                hintText: 'Email',
                                isPassword: false,
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Enter Email';
                                  }
                                  return null;
                                },
                                inputType: TextInputType.text,
                              ),
                              SizedBox(
                                height: mQHeight(30, context),
                              ),

                              ///Password TextFormField
                              CommonTextFormField(
                                controller: passwordController,
                                hintText: 'password',
                                isPassword: true,
                                inputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Enter Password';
                                  } else if (value.length < 8) {
                                    return 'Password should be 8 character minimum';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(
                                height: mQHeight(30, context),
                              ),
                              Consumer<AuthProvider>(
                                  builder: (child, authProv, _) =>
                                      GestureDetector(
                                        onTap: () {
                                          // print(">>>>>>>>>UserList data: ${userList.users}");
                                          authProv.loginService(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text,
                                              formKey: formKey,
                                              context: context);
                                        },
                                        child: Container(
                                          height: mQHeight(41, context),
                                          width: mQWidth(278, context),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  themeBlue,
                                                  themePurple
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Text(
                                            "Login",
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      )),
                              SizedBox(
                                height: mQHeight(10, context),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "forget password?",
                                    style: TextStyle(color: themePurple),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: mQHeight(40, context),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                        fontSize: 20, color: black1),
                                  ),
                                  GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context,
                                          RegistrationPage.routeName),
                                      child: const Text(
                                        "Register",
                                        style: TextStyle(
                                            color: themeBlue, fontSize: 20),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: mQHeight(30, context),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Or Sign in with Google",
                                    style:
                                        TextStyle(color: grey, fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mQHeight(20, context),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: mQHeight(50, context),
                                    width: mQWidth(50, context),
                                    decoration: const BoxDecoration(),
                                    child: Image.network(
                                      "http://pngimg.com/uploads/google/google_PNG19635.png",
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.facebook,
                                        size: 45,
                                        color: themeBlue,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: authProv.addChat,
                      child: Container(
                        height: mQHeight(304, context),
                        width: mQWidth(360, context),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: const DecorationImage(
                                image: AssetImage(
                                  "images_scaffold/location_checker.png",
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(mQWidth(20, context)),
                                topRight:
                                    Radius.circular(mQWidth(20, context)))),
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            SizedBox(
                              height: mQWidth(32, context),
                            ),
                            Icon(
                              Icons.location_on,
                              color: text,
                              size: mQWidth(26, context),
                            ),
                            SizedBox(
                              height: mQHeight(14, context),
                            ),
                            const PoppinsText(
                                text: "Allow us to acess this device’s",
                                fontSize: 15,
                                color: black2,
                                weight: FontWeight.w500),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PoppinsText(
                                    text: "location ",
                                    fontSize: 15,
                                    color: black2,
                                    weight: FontWeight.w500),
                                PoppinsText(
                                    text: "all-the-time? ",
                                    fontSize: 15,
                                    color: text,
                                    weight: FontWeight.w500),
                              ],
                            ),
                            SizedBox(
                              height: mQHeight(23, context),
                            ),
                            const PoppinsText(
                                text:
                                    "Fly Far Ladies currently can access \nlocation only while you’re using the app \n",
                                fontSize: 12,
                                color: black2,
                                weight: FontWeight.w500),
                            SizedBox(
                              height: mQHeight(29, context),
                            ),
                            const PoppinsText(
                                text: "Allow all the time",
                                fontSize: 13,
                                color: text,
                                weight: FontWeight.w500),
                            SizedBox(
                              height: mQHeight(11.1, context),
                            ),
                            Container(
                              height: mQHeight(0.8, context),
                              width: mQWidth(360, context),
                              color: word,
                            ),
                            SizedBox(
                              height: mQHeight(10.1, context),
                            ),
                            const PoppinsText(
                                text: "Keep while-in-use-access",
                                fontSize: 13,
                                color: text,
                                weight: FontWeight.w500),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
      ),
    );
  }
}
