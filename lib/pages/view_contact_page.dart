import 'package:texting_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texting_app/widget/profile_detail.dart';

class ViewContactPage extends StatelessWidget {
  static const String routeName = '/view_contact_page';

  const ViewContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Consumer<AuthProvider>(
            builder: (child, authProv, _) =>
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios)),
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
                          label: "Email", value: "authProv.currentUser?.email"),
                      ProfileDetail(
                          label: "Phone", value: "authProv.currentUser?.phone"),
                      ProfileDetail(
                          label: "Username",
                          value: "authProv.currentUser?.username"),
                    ],
                  ),
                ),
          )),
    );
  }
}
