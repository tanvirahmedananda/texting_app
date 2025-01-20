///MADE BY ME
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:texting_app/auth/auth_service.dart';
// import 'package:texting_app/model/message_model.dart';
// import 'package:texting_app/pages/chat_page.dart';
// import 'package:texting_app/pages/profile_page.dart';
// import 'package:texting_app/providers/auth_provider.dart';
// import 'package:texting_app/providers/chat_provider.dart';
// import 'package:texting_app/utils/constants.dart';
// import 'package:texting_app/widget/common_text_form_field.dart';
// import 'package:texting_app/widget/message_bar.dart';
// import 'package:texting_app/widget/poppins_text.dart';
//
// class ChatListPage extends StatefulWidget {
//   static const String routeName = '/chat_list_page';
//
//   const ChatListPage({super.key});
//
//   @override
//   State<ChatListPage> createState() => _ChatListPageState();
// }
//
// class _ChatListPageState extends State<ChatListPage> {
//   var searchController = TextEditingController();
//   var phoneController = TextEditingController();
//   bool _isLoading = true; // Track loading state
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//   }
//
//   Future<void> _initializeData() async {
//     var chatProvider = Provider.of<ChatProvider>(context, listen: false);
//     try {
//       // Fetch the data asynchronously
//       await chatProvider.getData();
//     } catch (e) {
//       print("Error in fetching data: $e");
//     } finally {
//       setState(() {
//         _isLoading = false; // Set loading to false once the data is fetched
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Avoid duplicate builds during data fetch
//     if (_isLoading) {
//       return Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(), // Loading spinner
//         ),
//       );
//     }
//     else{
//       var currentUser = Provider.of<ChatProvider>(context);
//       // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//       // print(">>>>>>>>>>>>>>>>>>>>>>Build Called>>>>>>>>>>>>>>>>>>>>>");
//       // print("Length : ${currentUser.randomRecivers.length}");
//       // print(">>CUD>>${currentUser.currentUserPhone}>>>>${currentUser.currentUserUsername}>>>>${currentUser.currentUserPhone}>>>>${currentUser.currentUserPhone}>>>>>>>>>>>>");
//       // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//       return SafeArea(
//         child: Scaffold(
//           body: SingleChildScrollView(
//             padding: EdgeInsets.all(mQHeight(16, context)),
//             child: Consumer<AuthProvider>(
//               builder: (child, authProv, _) => Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   GestureDetector(
//                     onTap: () => authProv.aConVisiOff(),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             PoppinsText(
//                                 text: 'Chats',
//                                 fontSize: 24,
//                                 color: Colors.black,
//                                 weight: FontWeight.bold),
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () => authProv.addchat(),
//                                   child: Container(
//                                     height: mQHeight(24, context),
//                                     width: mQWidth(24, context),
//                                     decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                             image: AssetImage(
//                                                 'images/add_contact.png'),
//                                             fit: BoxFit.cover)),
//                                   ),
//                                 ),
//                                 SizedBox(width: mQWidth(8, context)),
//                                 GestureDetector(
//                                   onTap: () => Navigator.pushNamed(
//                                       context, ProfilePage.routeName),
//                                   child: Container(
//                                     height: mQHeight(24, context),
//                                     width: mQHeight(24, context),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(26),
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: mQHeight(16, context),
//                         ),
//                         Container(
//                             height: mQHeight(46, context),
//                             width: mQWidth(358, context),
//                             child: TextFormField(
//                               keyboardType: TextInputType.text,
//                               controller: searchController,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.w500),
//                               decoration: InputDecoration(
//                                 hintText: 'Search...',
//                               ),
//                             )),
//                         SizedBox(
//                           height: mQHeight(16, context),
//                         ),
//                         Consumer<ChatProvider>(
//                             builder: (child, chatProv, _) => Container(
//                                 height: (mQHeight(76, context) *
//                                     chatProv.randomRecivers.length),
//                                 width: mQWidth(358, context),
//                                 child: ListView.builder(
//                                     physics: NeverScrollableScrollPhysics(),
//                                     itemCount: chatProv.randomRecivers.length,
//                                     itemBuilder: (context, index) {
//                                       return Column(
//                                         children: [
//                                           GestureDetector(
//                                               onTap: () {
//                                                 authProv.aConVisiOff();
//                                                 Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             ChatPage(
//                                                                 index:
//                                                                 index)));
//                                               },
//                                               child: MessageBar(
//                                                   username: chatProv
//                                                       .randomRecivers[index]
//                                                       .username,
//                                                   time: "time",
//                                                   text: chatProv
//                                                       .randomReciversChat[
//                                                   index]
//                                                       .first
//                                                       .text)),
//                                           SizedBox(
//                                             height: mQHeight(24, context),
//                                           )
//                                         ],
//                                       );
//                                     }))),
//                       ],
//                     ),
//                   ),
//                   Visibility(
//                     visible: authProv.addChat,
//                     child: Container(
//                       height: mQHeight(200, context),
//                       width: mQWidth(300, context),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(25)),
//                       padding: EdgeInsets.all(mQHeight(16, context)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           PoppinsText(
//                               text: 'Add chat',
//                               fontSize: 25,
//                               color: themePurple,
//                               weight: FontWeight.w500),
//                           SizedBox(height: mQHeight(16, context)),
//                           CommonTextFormField(
//                             controller: phoneController,
//                             hintText: 'contact no.',
//                             isPassword: false,
//                             inputType: TextInputType.phone,
//                           ),
//                           SizedBox(height: mQHeight(16, context)),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   authProv.aConVisiOff();
//                                   Provider.of<ChatProvider>(context, listen: false)
//                                       .addChat(
//                                     currentUser.currentUserPhone,
//                                     phoneController.text,
//                                     MessageModel(
//                                       phone: currentUser.currentUserPhone,
//                                       email: AuthService.user?.email,
//                                       text: "hey...",
//                                     ),
//                                   );
//                                   phoneController.clear();
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(
//                                     vertical: mQHeight(15, context),
//                                     horizontal: mQWidth(30, context),
//                                   ),
//                                   decoration: BoxDecoration(
//                                       color: themeBlue,
//                                       borderRadius: BorderRadius.circular(100)),
//                                   child: PoppinsText(
//                                       text: "Add chat",
//                                       fontSize: 15,
//                                       color: Colors.white,
//                                       weight: FontWeight.w500),
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );}
//   }
// }

///MADE BY AKASH BHAI
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:texting_app/auth/auth_service.dart';
// import 'package:texting_app/model/message_model.dart';
// import 'package:texting_app/pages/chat_page.dart';
// import 'package:texting_app/pages/profile_page.dart';
// import 'package:texting_app/providers/auth_provider.dart';
// import 'package:texting_app/providers/chat_provider.dart';
// import 'package:texting_app/utils/constants.dart';
// import 'package:texting_app/widget/common_text_form_field.dart';
// import 'package:texting_app/widget/message_bar.dart';
// import 'package:texting_app/widget/poppins_text.dart';
//
// class ChatListPage extends StatefulWidget {
//   static const String routeName = '/chat_list_page';
//
//   const ChatListPage({super.key});
//
//   @override
//   State<ChatListPage> createState() => _ChatListPageState();
// }
//
// class _ChatListPageState extends State<ChatListPage> {
//   var searchController = TextEditingController();
//   var phoneController = TextEditingController();
//   bool _isLoading = true; // Track loading state
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//   }
//
//   Future<void> _initializeData() async {
//     var chatProvider = Provider.of<ChatProvider>(context, listen: false);
//     try {
//       // Fetch the data asynchronously
//       await chatProvider.getData();
//     } catch (e) {
//       print("Error in fetching data: $e");
//     } finally {
//       setState(() {
//         _isLoading = false; // Set loading to false once the data is fetched
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Avoid duplicate builds during data fetch
//     if (_isLoading) {
//       return Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(), // Loading spinner
//         ),
//       );
//     }
//     else{
//       var currentUser = Provider.of<ChatProvider>(context);
//       // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//       // print(">>>>>>>>>>>>>>>>>>>>>>Build Called>>>>>>>>>>>>>>>>>>>>>");
//       // print("Length : ${currentUser.randomRecivers.length}");
//       // print(">>CUD>>${currentUser.currentUserPhone}>>>>${currentUser.currentUserUsername}>>>>${currentUser.currentUserPhone}>>>>${currentUser.currentUserPhone}>>>>>>>>>>>>");
//       // print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//       return SafeArea(
//         child: Scaffold(
//           body: Consumer<ChatProvider>(builder: (child, provider, _) {
//             print('+++++++++++++++++++++++++++${provider.randomRecivers.length}');
//             return !provider.isDataLoaded
//                 ? CircularProgressIndicator()
//                 : Center(child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Total User length :${provider.users.length}"),
//                 Text("Random Receiver Detail list length :${provider.randomRecivers.length}"),
//                 Text("Random Receiver Chatlist length :${provider.randomReciversChat.length}"),
//                 Text("Random Receiver 1 username :${provider.randomReciversChat[0][0].username}"),
//                 Text("Random Receiver 2 length :${provider.randomReciversChat[0][0].username}"),
//                 Text("Random Receiver 1 Chat length :${provider.randomReciversChat[0].length}"),
//                 Text("Random Receiver 1 text 1 :${provider.randomReciversChat[0][0].text}"),
//                 Text("Random Receiver 1 text 2 :${provider.randomReciversChat[0][1].text}"),
//                 Text("Random Receiver 1 text 3 :${provider.randomReciversChat[0][2].text}"),
//                 Text("Random Receiver 1 text 4 :${provider.randomReciversChat[0][3].text}"),
//                 Text("Random Receiver 1 text 5 :${provider.randomReciversChat[0][4].text}"),
//
//               ],
//             ));
//           }),
//         ),
//       );}
//   }
// }
