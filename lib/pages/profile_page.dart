import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:texting_app/model/user_model.dart';
import 'package:texting_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texting_app/providers/chat_provider.dart';
import 'package:texting_app/providers/user_provider.dart';
import 'package:texting_app/widget/profile_detail.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile_page';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Consumer<UserProvider>(
        builder: (child, userProv, _) => StreamBuilder<
                DocumentSnapshot<Map<String, dynamic>>>(
            stream: userProv.getCurrentUser(
                Provider.of<ChatProvider>(context, listen: false).currentUserPhone),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                final userModel = UserModel.fromMap(snapshot.data!.data()!);
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back_ios)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 60,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ProfileDetail(
                          label: "Username", value: userModel.username),
                      ProfileDetail(label: "Email", value: userModel.email),
                      ProfileDetail(label: "Phone", value: userModel.phoneList?.first),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .logoutService(context);
                              },
                              child: const Row(
                                children: [
                                  Text('   Log out'),
                                  Icon(
                                    Icons.logout_outlined,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Failed to fetch data"),
                );
              }
              return CircularProgressIndicator();
            }),
      )),
    );
  }
}
// Center(child: Text('Hello'))
