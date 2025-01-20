import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texting_app/pages/login_page.dart';
import 'package:texting_app/providers/auth_provider.dart';
import 'package:texting_app/utils/constants.dart';
import 'package:texting_app/widget/common_text_form_field.dart';

class RegistrationPage extends StatefulWidget {
  static const String routeName = '/registration_page';
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<AuthProvider>(
            builder: (child, authProv, _) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Center(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                          left: mQWidth(41, context), right: mQWidth(41, context)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 120,
                            child: Image.asset(
                              'images/logo.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),

                          ///UserName TextFormField
                          CommonTextFormField(
                            controller: usernameController,
                            hintText: 'Username',
                            isPassword: false,
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Enter Username';
                              }
                              return null;
                            },
                            inputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          ///Phone TextFormField
                          CommonTextFormField(
                            controller: phoneController,
                            hintText: 'Phone',
                            isPassword: false,
                            validator: (value) {
                              if (value == null || value == '') {
                                return 'Enter Phone';
                              }
                              return null;
                            },
                            inputType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 30,
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
                          const SizedBox(
                            height: 30,
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

                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              authProv.registrationService(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  username: usernameController.text,
                                  phone: phoneController.text,
                                  formKey: formKey,
                                  context: context);
                            },
                            child: Container(
                              height: mQHeight(41, context),
                              width: mQWidth(278, context),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [themeBlue,themePurple], ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Agree Terms and Conditions",
                                style: TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Already have an account? ",
                                  style: TextStyle(fontSize: 20)),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, LoginPage.routeName),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: themeBlue, fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
