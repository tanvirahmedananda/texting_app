import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texting_app/auth/auth_service.dart';
import 'package:texting_app/model/message_model.dart';
import 'package:texting_app/pages/chat_page.dart';
import 'package:texting_app/pages/profile_page.dart';
import 'package:texting_app/providers/auth_provider.dart';
import 'package:texting_app/providers/chat_provider.dart';
import 'package:texting_app/utils/constants.dart';
import 'package:texting_app/widget/common_text_form_field.dart';
import 'package:texting_app/widget/message_bar.dart';
import 'package:texting_app/widget/poppins_text.dart';

class ChatListPage extends StatefulWidget {
  static const String routeName = '/chat_list_page';

  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  var searchController = TextEditingController();
  var phoneController = TextEditingController();
  var gpNameController = TextEditingController();
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    var chatProvider = Provider.of<ChatProvider>(context, listen: false);
    try {
      await chatProvider.getData();
    } catch (e) {
      print("Error in fetching data: $e");
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false once the data is fetched
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Loading spinner
        ),
      );
    } else {
      var currentUser = Provider.of<ChatProvider>(context);
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(mQHeight(16, context)),
            child: Consumer<AuthProvider>(
              builder: (child, authProv, _) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PoppinsText(
                          text: 'Chats',
                          fontSize: 24,
                          color: Colors.black,
                          weight: FontWeight.bold),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Container(
                                      height: 200,
                                      width: 300,
                                      child: Column(
                                        children: [
                                          ExpansionTile(
                                            title: Container(

                                                child: Text('Add chat')),
                                            children: [
                                              Container(

                                                child: Column(
                                                  children: [
                                                    CommonTextFormField(
                                                      controller: phoneController,
                                                      hintText: 'contact no.',
                                                      isPassword: false,
                                                      inputType: TextInputType.phone,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Provider.of<ChatProvider>(context,
                                                                listen: false)
                                                                .addChat(
                                                              currentUser.currentUserPhone,
                                                              phoneController.text,
                                                              MessageModel(
                                                                phone: currentUser.currentUserPhone,
                                                                email: AuthService.user?.email,
                                                                text: "hey...",
                                                              ),
                                                            );
                                                            phoneController.clear();
                                                            Navigator.pop(context);
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                              vertical: mQHeight(10, context),
                                                              horizontal: mQWidth(20, context),
                                                            ),
                                                            decoration: BoxDecoration(
                                                                color: themeBlue,
                                                                borderRadius: BorderRadius.circular(100)),
                                                            child: PoppinsText(
                                                                text: "Add chat",
                                                                fontSize: 15,
                                                                color: Colors.white,
                                                                weight: FontWeight.w500),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          ExpansionTile(
                                            title: Container(

                                                child: Text('Add group')),
                                            children: [
                                              Container(

                                                child: Column(
                                                  children: [
                                                    CommonTextFormField(
                                                      controller: gpNameController,
                                                      hintText: 'Group name',
                                                      isPassword: false,
                                                      inputType: TextInputType.phone,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Provider.of<ChatProvider>(context,
                                                                listen: false)
                                                                .createGroup(gpNameController.text);
                                                            gpNameController.clear();
                                                            Navigator.pop(context);
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                              vertical: mQHeight(10, context),
                                                              horizontal: mQWidth(20, context),
                                                            ),
                                                            decoration: BoxDecoration(
                                                                color: themeBlue,
                                                                borderRadius: BorderRadius.circular(100)),
                                                            child: PoppinsText(
                                                                text: "Create Group",
                                                                fontSize: 15,
                                                                color: Colors.white,
                                                                weight: FontWeight.w500),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            child: Container(
                              height: mQHeight(24, context),
                              width: mQWidth(24, context),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'images/add_contact.png'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          SizedBox(width: mQWidth(8, context)),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, ProfilePage.routeName),
                            child: Container(
                              height: mQHeight(24, context),
                              width: mQHeight(24, context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: mQHeight(16, context),
                  ),
                  Container(
                      height: mQHeight(46, context),
                      width: mQWidth(358, context),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: searchController,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: 'Search...',
                        ),
                      )),
                  SizedBox(
                    height: mQHeight(16, context),
                  ),
                  Consumer<ChatProvider>(
                      builder: (child, chatProv, _) => Container(
                          height: (mQHeight(76, context) *
                              chatProv.randomRecivers.length),
                          width: mQWidth(358, context),
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: chatProv.randomRecivers.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          authProv.aConVisiOff();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatPage(
                                                          index: index)));
                                        },
                                        child: MessageBar(
                                            username: chatProv
                                                .randomRecivers[index]
                                                .username,
                                            time: "time",
                                            text: chatProv
                                                .randomReceiversChat[
                                                    index]
                                                    ["receiverChatList"]
                                                .first
                                                .text)),
                                    SizedBox(
                                      height: mQHeight(24, context),
                                    )
                                  ],
                                );
                              }))),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
