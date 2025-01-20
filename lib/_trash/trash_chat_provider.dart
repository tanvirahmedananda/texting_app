///MADE BY ME
//
//
// import 'package:flutter/material.dart';
// import 'package:texting_app/auth/auth_service.dart';
// import 'package:texting_app/db/db_helper.dart';
// import 'package:texting_app/model/message_model.dart';
// import 'package:texting_app/model/text_model.dart';
// import 'package:texting_app/model/user_model.dart';
// import 'package:texting_app/models/user_list_model.dart';
//
// class ChatProvider extends ChangeNotifier {
//   List<UserModel> users = [];
//   List<UserModel> randomRecivers = [];
//   List<List<TextModel>> randomReciversChat = [[]];
//   bool isDataLoaded = false;
//
//   //List<List<TextModel>> randomReciversChat = [[TextModel(username: "Tanvir"), TextModel(username: "Ahmed"), TextModel(username: "Ananada"), ],[TextModel(username: "Monjur"), TextModel(username: "Ahmed"), TextModel(username: "Akash"), ]];
//   String currentUserUsername = '';
//   String currentUserPhone = '';
//   String currentUserImage = '';
//
//   ///ADD A CHAT
//   addChat(String currentUser, String reciverPhone, MessageModel messagemodel) {
//     String? username;
//     for (var ele in users) {
//       if (ele.email == messagemodel.email) {
//         username = ele.username;
//       }
//     }
//     MessageModel messageModel = MessageModel(
//       username: username,
//       text: messagemodel.text,
//       time: messagemodel.time,
//       email: messagemodel.email,
//       phone: messagemodel.phone,
//       image: messagemodel.image,
//     );
//     for (var ele in users) {
//       if (ele.phone == reciverPhone) {
//         DbHelper.addChat(currentUser, reciverPhone, messageModel, ele);
//       }
//     }
//   }
//
//   ///FETCH CURRENT USER PHONE ALONG WITH ALL USERDATA
//   getData() async {
//     await getAllUserData();
//     notifyListeners();
//     isDataLoaded = true;
//     notifyListeners();
//   }
//
//   getCurrentUserData()async{
//     await getCurrentUserUsername();
//     await getCurrentUserImage();
//   }
//   getCurrentUserUsername()=>DbHelper.getCurrentUser(currentUserPhone).listen((snap){
//     UserModel userModel = UserModel.fromMap(snap.data()!);
//     currentUserUsername = userModel.username;
//     notifyListeners();
//     print("#######################f##${userModel.username}################");
//   });
//   getCurrentUserImage()=>DbHelper.getCurrentUser(currentUserPhone).listen((snap){
//     UserModel userModel = UserModel.fromMap(snap.data()!);
//     currentUserImage = userModel.image!;
//     notifyListeners();
//     print("#######################f##${userModel.image}################");
//   });
//
//   ///FETCH ALL USERDATA & FETCH CURRENT USERDATA
//   getAllUserData(){
//     DbHelper.getAllUserData().listen((snap){
//       for(var ele in snap.docs){
//         UserModel userModel = UserModel.fromMap(ele.data());
//         users.insert(0,userModel);
//         notifyListeners();
//         print("//////////////////////////");
//         print(userModel.username);
//         print("//////////////////////////");
//         if(userModel.email == AuthService.user?.email){
//           currentUserPhone = userModel.phone!;
//           notifyListeners();
//           getCurrentUserChatList(userModel.phone!);
//           /*print("++++++++++++++++++");
//           print("--------------------------------------${userModel.username}--------------------------");
//           print("++++++++++++++++++");*/
//         }
//       }
//     });
//   }
//
//   ///FETCH CURRENT USER CHATLIST
//   getCurrentUserChatList(String phone) {
//     print('***Phone: ${phone}***');
//     DbHelper.getCurrentUserChatList(phone).listen((snapshot) async {
//       for (var ele in snapshot.docs) {
//         UserModel userModel = UserModel.fromMap(ele.data());
//         randomRecivers.insert(0,userModel);
//         print(">>>>>>>>>>>>>>>>>>>>>>>>>>>${userModel.username}<<<<<<<<<<<<<<<<<<<<");
//         notifyListeners();
//         await getAllchat(
//             phone, userModel.phone!);
//       }
//       // notifyListeners();
//     });
//   }
//
//   ///FETCH RANDOM USERS CHATS
//   getAllchat(String userPhone, String reciverPhone) =>
//       DbHelper.getAllchat(
//         userPhone,
//         reciverPhone,
//       ).listen((snapshot) {
//         List<TextModel> tM = [];
//         for (var ele in snapshot.docs) {
//           TextModel textModel = TextModel.fromMap(ele.data());
//           tM.insert(0, textModel);
//           notifyListeners();
//           /*randomReciversChat[0].insert(0,textModel);*/
//           print("?????????${userPhone}???????????????${textModel.text}?????????????${reciverPhone}???????");
//           // notifyListeners();
//         }
//         randomReciversChat.insert(0, tM);
//         notifyListeners();
//       });
//
//   ///SEND MESSAGE
//   sendMessage(int index, String senderPhone, String reciverPhone, TextModel textModel)=>DbHelper.sendMessage(senderPhone, reciverPhone, textModel, "MessageNo.${(randomReciversChat[index].length+1)}");
//
//
//   resetData(){
//     users.clear();
//     randomRecivers.clear();
//     randomReciversChat.clear();
//     currentUserUsername = '';
//     currentUserPhone = '';
//     currentUserImage = '';
//     notifyListeners();
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//   ///Get and Fetch Hierarchical data
//   Future<void> addData() async {
//     final userListModel = UserListModel(
//       chatList: [
//         ChatList(
//           chatRoomMessages: [
//             ChatRoomMessages(message: "Hello, how are you?"),
//             ChatRoomMessages(message: "I'm fine, thank you!"),
//           ],
//         ),
//         ChatList(
//           chatRoomMessages: [
//             ChatRoomMessages(message: "Are we meeting today?"),
//             ChatRoomMessages(message: "Yes, at 5 PM."),
//           ],
//         ),
//       ],
//       userData: [
//         UserData(
//           email: "john.doe@example.com",
//           image: "https://example.com/images/john.jpg",
//           phone: "1234567890",
//           userName: "John Doe",
//         ),
//         UserData(
//           email: "jane.doe@example.com",
//           image: "https://example.com/images/jane.jpg",
//           phone: "0987654321",
//           userName: "Jane Doe",
//         ),
//       ],
//     );
//
//     await DbHelper.addUserData(userListModel, '01758187661');
//   }
//
//   /// Fetch all user data
//   List<UserListModel> userListModels = [];
//   bool isLoading = false;
//
//   // Fetch all user data and notify listeners
//   Future<void> fetchAllUserData() async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final data = await DbHelper.fetchAllUserData();
//       userListModels = data;
//       print(data.length);
//       print(
//           '----------------userlist length${userListModels.length} ---------------');
//     } catch (e) {
//       print("Error fetching user data: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> getSingleData() async {
//     try {
//       // Get the first snapshot from the stream
//       final snapshot = await DbHelper.getSingleUserData().first;
//
//       if (snapshot.exists) {
//         // Access the data
//         final message = snapshot.data()?['message'];
//         print(message);
//
//         // Update your model or notify listeners as needed
//         // orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
//         notifyListeners();
//       } else {
//         print('Document does not exist.');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }
// }
//

///MADE BY ME(2.0)
//
// import 'package:flutter/material.dart';
// import 'package:texting_app/auth/auth_service.dart';
// import 'package:texting_app/db/db_helper.dart';
// import 'package:texting_app/model/message_model.dart';
// import 'package:texting_app/model/text_model.dart';
// import 'package:texting_app/model/user_model.dart';
// import 'package:texting_app/models/user_list_model.dart';
//
// class ChatProvider extends ChangeNotifier {
//   List<UserModel> users = [];
//   List<UserModel> randomRecivers = [];
//   List<List<TextModel>> randomReciversChat = [[]];
//   bool isDataLoaded = false;
//
//   //List<List<TextModel>> randomReciversChat = [[TextModel(username: "Tanvir"), TextModel(username: "Ahmed"), TextModel(username: "Ananada"), ],[TextModel(username: "Monjur"), TextModel(username: "Ahmed"), TextModel(username: "Akash"), ]];
//   String currentUserUsername = '';
//   String currentUserPhone = '';
//   String currentUserImage = '';
//
//   ///ADD A CHAT
//   addChat(String currentUser, String reciverPhone, MessageModel messagemodel) {
//     String? username;
//     for (var ele in users) {
//       if (ele.email == messagemodel.email) {
//         username = ele.username;
//       }
//     }
//     MessageModel messageModel = MessageModel(
//       username: username,
//       text: messagemodel.text,
//       time: messagemodel.time,
//       email: messagemodel.email,
//       phone: messagemodel.phone,
//       image: messagemodel.image,
//     );
//     for (var ele in users) {
//       if (ele.phone == reciverPhone) {
//         DbHelper.addChat(currentUser, reciverPhone, messageModel, ele);
//       }
//     }
//   }
//
//   ///FETCH CURRENT USER PHONE ALONG WITH ALL USERDATA
//   getData() async {
//     users.clear();
//     randomRecivers.clear();
//     randomReciversChat.clear();
//     DbHelper.getAllUserData().listen((snap) {
//       users = List.generate(snap.docs.length, (index) {
//         var data = UserModel.fromMap(snap.docs[index].data());
//         if (data.email == AuthService.user?.email) {
//           currentUserPhone = data.phone!;
//           currentUserUsername = data.username;
//           currentUserImage = data.image ?? 'null';
//           notifyListeners();
//           DbHelper.getCurrentUserChatList(currentUserPhone)
//               .listen((rRSnap) async {
//             randomRecivers = List.generate(rRSnap.docs.length, (ind) {
//               var randomReciver = UserModel.fromMap(rRSnap.docs[ind].data());
//               DbHelper.getAllchat(
//                 currentUserUsername,
//                 randomReciver.phone!,
//               ).listen((rRCsnap) {
//                 List<TextModel> tM = [];
//                 tM = List.generate(rRCsnap.docs.length, (idx) {
//                   TextModel textModel =
//                   TextModel.fromMap(rRCsnap.docs[idx].data());
//                   return textModel;
//                 });
//                 randomReciversChat.add(tM);
//                 notifyListeners();
//               });
//               return randomReciver;
//             });
//             notifyListeners();
//           });
//           notifyListeners();
//         }
//         return data;
//       });
//     });
//     notifyListeners();
//     isDataLoaded = true;
//     notifyListeners();
//   }
//
//   ///SEND MESSAGE
//   sendMessage(int index, String senderPhone, String reciverPhone,
//       TextModel textModel) =>
//       DbHelper.sendMessage(senderPhone, reciverPhone, textModel,
//           "MessageNo.${(randomReciversChat[index].length + 1)}");
//
//   resetData() {
//     users.clear();
//     randomRecivers.clear();
//     randomReciversChat.clear();
//     currentUserUsername = '';
//     currentUserPhone = '';
//     currentUserImage = '';
//     notifyListeners();
//   }
//
//   ///Get and Fetch Hierarchical data
//   Future<void> addData() async {
//     final userListModel = UserListModel(
//       chatList: [
//         ChatList(
//           chatRoomMessages: [
//             ChatRoomMessages(message: "Hello, how are you?"),
//             ChatRoomMessages(message: "I'm fine, thank you!"),
//           ],
//         ),
//         ChatList(
//           chatRoomMessages: [
//             ChatRoomMessages(message: "Are we meeting today?"),
//             ChatRoomMessages(message: "Yes, at 5 PM."),
//           ],
//         ),
//       ],
//       userData: [
//         UserData(
//           email: "john.doe@example.com",
//           image: "https://example.com/images/john.jpg",
//           phone: "1234567890",
//           userName: "John Doe",
//         ),
//         UserData(
//           email: "jane.doe@example.com",
//           image: "https://example.com/images/jane.jpg",
//           phone: "0987654321",
//           userName: "Jane Doe",
//         ),
//       ],
//     );
//
//     await DbHelper.addUserData(userListModel, '01758187661');
//   }
//
//   /// Fetch all user data
//   List<UserListModel> userListModels = [];
//   bool isLoading = false;
//
//   // Fetch all user data and notify listeners
//   Future<void> fetchAllUserData() async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final data = await DbHelper.fetchAllUserData();
//       userListModels = data;
//       print(data.length);
//       print(
//           '----------------userlist length${userListModels.length} ---------------');
//     } catch (e) {
//       print("Error fetching user data: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> getSingleData() async {
//     try {
//       // Get the first snapshot from the stream
//       final snapshot = await DbHelper.getSingleUserData().first;
//
//       if (snapshot.exists) {
//         // Access the data
//         final message = snapshot.data()?['message'];
//         print(message);
//
//         // Update your model or notify listeners as needed
//         // orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
//         notifyListeners();
//       } else {
//         print('Document does not exist.');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }
// }
//
//
//
//

///MADE BY ME(3.0)
// import 'package:flutter/material.dart';
// import 'package:texting_app/auth/auth_service.dart';
// import 'package:texting_app/db/db_helper.dart';
// import 'package:texting_app/model/message_model.dart';
// import 'package:texting_app/model/text_model.dart';
// import 'package:texting_app/model/user_model.dart';
// import 'package:texting_app/models/user_list_model.dart';
//
// class ChatProvider extends ChangeNotifier {
//   List<UserModel> users = [];
//   List<UserModel> randomRecivers = [];
//   List<List<TextModel>> randomReciversChat = [[]];
//   bool isDataLoaded = false;
//
//   //List<List<TextModel>> randomReciversChat = [[TextModel(username: "Tanvir"), TextModel(username: "Ahmed"), TextModel(username: "Ananada"), ],[TextModel(username: "Monjur"), TextModel(username: "Ahmed"), TextModel(username: "Akash"), ]];
//   String currentUserUsername = '';
//   String currentUserPhone = '';
//   String currentUserImage = '';
//
//   ///ADD A CHAT
//   addChat(String currentUser, String reciverPhone, MessageModel messagemodel) {
//     String? username;
//     for (var ele in users) {
//       if (ele.email == messagemodel.email) {
//         username = ele.username;
//       }
//     }
//     MessageModel messageModel = MessageModel(
//       username: username,
//       text: messagemodel.text,
//       time: messagemodel.time,
//       email: messagemodel.email,
//       phone: messagemodel.phone,
//       image: messagemodel.image,
//     );
//     for (var ele in users) {
//       if (ele.phone == reciverPhone) {
//         DbHelper.addChat(currentUser, reciverPhone, messageModel, ele);
//       }
//     }
//   }
//
//   ///FETCH ALL USERS DATA
//   fetchAllUserDetails()async{
//     DbHelper.getAllUserData().listen((snap){
//       users = List.generate(snap.docs.length, (index)=>UserModel.fromMap(snap.docs[index].data()));
//       for(var ele in users){
//         print('UserName : ${ele.username}');
//       }
//       notifyListeners();
//     });
//   }
//   fetchUserDetails(){
//     // DbHelper.getAllUserData().first.then((snap) {
//     //   users = List.generate(snap.docs.length, (index) => UserModel.fromMap(snap.docs[index].data()));
//     //   for (var ele in users) {
//     //     print('UserName : ${ele.username}');
//     //   }
//     //   notifyListeners();
//     // }).catchError((error) {
//     //   print('Error: $error');
//     // }).whenComplete(() {
//     //   print('Data retrieval complete.');
//     // });
//     DbHelper.getAllUserData().listen((snap)async{
//       users = List.generate(snap.docs.length, (index)=>UserModel.fromMap(snap.docs[index].data()));
//       for(var ele in users){
//         print('UserName : ${ele.username}');
//         if(ele.email == AuthService.user?.email){
//           currentUserUsername = ele.username;
//           currentUserPhone = ele.phone!;
//           currentUserImage = ele.image ?? 'null image';
//           print("Current User Username : ${currentUserUsername}");
//           print("Current User Phone : ${currentUserPhone}");
//           print("Current User Image : ${currentUserImage}");
//           notifyListeners();
//         }
//       }
//       print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
//       for(var ele in users){
//       }
//     });
//     notifyListeners();
//   }
//
//   ///FIND CURRENT USER DATA
//   findCurrentUserDetails()async{
//     print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
//     for(var ele in users){
//       if(ele.email == AuthService.user?.email){
//         currentUserUsername = ele.username;
//         currentUserPhone = ele.phone!;
//         currentUserImage = ele.image ?? 'null image';
//         print("Current User Username : ${currentUserUsername}");
//         print("Current User Phone : ${currentUserPhone}");
//         print("Current User Image : ${currentUserImage}");
//         notifyListeners();
//       }
//     }
//   }
//
//
//   ///SEND MESSAGE
//   sendMessage(int index, String senderPhone, String reciverPhone, TextModel textModel)=>DbHelper.sendMessage(senderPhone, reciverPhone, textModel, "MessageNo.${(randomReciversChat[index].length+1)}");
//
//
//   resetData(){
//     users.clear();
//     randomRecivers.clear();
//     randomReciversChat.clear();
//     currentUserUsername = '';
//     currentUserPhone = '';
//     currentUserImage = '';
//     notifyListeners();
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//   ///Get and Fetch Hierarchical data
//   Future<void> addData() async {
//     final userListModel = UserListModel(
//       chatList: [
//         ChatList(
//           chatRoomMessages: [
//             ChatRoomMessages(message: "Hello, how are you?"),
//             ChatRoomMessages(message: "I'm fine, thank you!"),
//           ],
//         ),
//         ChatList(
//           chatRoomMessages: [
//             ChatRoomMessages(message: "Are we meeting today?"),
//             ChatRoomMessages(message: "Yes, at 5 PM."),
//           ],
//         ),
//       ],
//       userData: [
//         UserData(
//           email: "john.doe@example.com",
//           image: "https://example.com/images/john.jpg",
//           phone: "1234567890",
//           userName: "John Doe",
//         ),
//         UserData(
//           email: "jane.doe@example.com",
//           image: "https://example.com/images/jane.jpg",
//           phone: "0987654321",
//           userName: "Jane Doe",
//         ),
//       ],
//     );
//
//     await DbHelper.addUserData(userListModel, '01758187661');
//   }
//
//   /// Fetch all user data
//   List<UserListModel> userListModels = [];
//   bool isLoading = false;
//
//   // Fetch all user data and notify listeners
//   Future<void> fetchAllUserData() async {
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final data = await DbHelper.fetchAllUserData();
//       userListModels = data;
//       print(data.length);
//       print(
//           '----------------userlist length${userListModels.length} ---------------');
//     } catch (e) {
//       print("Error fetching user data: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> getSingleData() async {
//     try {
//       // Get the first snapshot from the stream
//       final snapshot = await DbHelper.getSingleUserData().first;
//
//       if (snapshot.exists) {
//         // Access the data
//         final message = snapshot.data()?['message'];
//         print(message);
//
//         // Update your model or notify listeners as needed
//         // orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
//         notifyListeners();
//       } else {
//         print('Document does not exist.');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }
// }

///MADE BY ME(4.0)
// import 'package:flutter/material.dart';
// import 'package:texting_app/auth/auth_service.dart';
// import 'package:texting_app/db/db_helper.dart';
// import 'package:texting_app/model/message_model.dart';
// import 'package:texting_app/model/text_model.dart';
// import 'package:texting_app/model/user_model.dart';
// import 'package:texting_app/models/user_list_model.dart';
//
// class ChatProvider extends ChangeNotifier {
//   List<UserModel> users = [];
//   List<UserModel> randomRecivers = [];
//   List<List<TextModel>> randomReceiversChat = [[]];
//   bool isDataLoaded = false;
//
//   //List<List<TextModel>> randomReciversChat = [[TextModel(username: "Tanvir"), TextModel(username: "Ahmed"), TextModel(username: "Ananada"), ],[TextModel(username: "Monjur"), TextModel(username: "Ahmed"), TextModel(username: "Akash"), ]];
//   String currentUserUsername = '';
//   String currentUserPhone = '';
//   String currentUserImage = '';
//
//   ///FETCH CURRENT USER PHONE ALONG WITH ALL USERDATA
//   getData() async {
//     DbHelper.getAllUserData().listen((snapshot) {
//       users = List.generate(
//         snapshot.docs.length,
//             (index) {
//           var data = UserModel.fromMap(snapshot.docs[index].data());
//           print(data.username);
//           if (data.email == AuthService.user?.email) {
//             currentUserPhone = data.phone!;
//             currentUserUsername = data.username;
//             currentUserImage = data.image ?? 'null';
//             notifyListeners();
//             print('*-*-*-*-*-Called-*-*--*--');
//             getCurrentUserChatList(currentUserPhone);
//             notifyListeners();
//           }
//           return data;
//         },
//       );
//
//       print(
//           '-----------++++++++++++++++++++++++++------------------++++++++++++++++-------------');
//       print(users.length);
//       print('Random Receiver: ${randomRecivers.length}');
//       print('Random Receiver Chat: ${randomReceiversChat.length}');
//       isDataLoaded = true;
//       notifyListeners();
//     });
//   }
//
//   ///FETCH CURRENT USER CHATLIST
//   getCurrentUserChatList(String phone) {
//     DbHelper.getCurrentUserChatList(phone).listen((snapshot) async {
//       randomRecivers = List.generate(snapshot.docs.length, (index) {
//         final data = UserModel.fromMap(snapshot.docs[index].data());
//         getAllChat(currentUserPhone, data.phone!);
//         return data;
//       });
//       notifyListeners();
//       print('Random Receiver: ${randomRecivers.length}');
//     });
//   }
//
//   ///FETCH RANDOM USERS CHATS
//   getAllChat(String userPhone, String receiverPhone) {
//     DbHelper.getAllchat(
//       userPhone,
//       receiverPhone,
//     ).listen((snapshot) {
//       List<TextModel> tM = [];
//       tM = List.generate(snapshot.docs.length,
//               (index) => TextModel.fromMap(snapshot.docs[index].data()));
//       randomReceiversChat.add(tM);
//       notifyListeners();
//     });
//   }
//
//   ///ADD A CHAT
//   addChat(String currentUser, String reciverPhone, MessageModel messagemodel) {
//     String? username;
//     for (var ele in users) {
//       if (ele.email == messagemodel.email) {
//         username = ele.username;
//       }
//     }
//     MessageModel messageModel = MessageModel(
//       username: username,
//       text: messagemodel.text,
//       time: messagemodel.time,
//       email: messagemodel.email,
//       phone: messagemodel.phone,
//       image: messagemodel.image,
//     );
//     for (var ele in users) {
//       if (ele.phone == reciverPhone) {
//         DbHelper.addChat(currentUser, reciverPhone, messageModel, ele);
//       }
//     }
//   }
//
//   ///FETCH ALL USERDATA & FETCH CURRENT USERDATA
//   getAllUserData() {
//     DbHelper.getAllUserData().listen((snap) {
//       for (var ele in snap.docs) {
//         UserModel userModel = UserModel.fromMap(ele.data());
//         users.insert(0, userModel);
//         notifyListeners();
//         print("//////////////////////////");
//         print(userModel.username);
//         print("//////////////////////////");
//         if (userModel.email == AuthService.user?.email) {
//           currentUserPhone = userModel.phone!;
//           notifyListeners();
//           getCurrentUserChatList(userModel.phone!);
//           /*print("++++++++++++++++++");
//           print("--------------------------------------${userModel.username}--------------------------");
//           print("++++++++++++++++++");*/
//         }
//       }
//     });
//   }
//
//   ///SEND MESSAGE
//   sendMessage(int index, String senderPhone, String reciverPhone,
//       TextModel textModel) =>
//       DbHelper.sendMessage(senderPhone, reciverPhone, textModel,
//           "MessageNo.${(randomReceiversChat[index].length + 1)}");
//
//   resetData() {
//     users.clear();
//     randomRecivers.clear();
//     randomReceiversChat.clear();
//     currentUserUsername = '';
//     currentUserPhone = '';
//     currentUserImage = '';
//     notifyListeners();
//   }
// }

///MADE BY ME(4.0)
// class ChatProvider extends ChangeNotifier {
//   Map<String, List<TextModel>> randomReceiversChat = {};
//
//   // Other properties and methods...
//
//   getData() async {
//     users.clear();
//     randomRecivers.clear();
//     randomReceiversChat.clear();
//
//     DbHelper.getAllUserData().listen((snap) {
//       users = List.generate(snap.docs.length, (index) {
//         var data = UserModel.fromMap(snap.docs[index].data());
//         if (data.email == AuthService.user?.email) {
//           currentUserPhone = data.phone!;
//           currentUserUsername = data.username;
//           currentUserImage = data.image ?? 'null';
//
//           notifyListeners();
//
//           DbHelper.getCurrentUserChatList(currentUserPhone).listen((rRSnap) {
//             randomRecivers = List.generate(rRSnap.docs.length, (ind) {
//               var randomReciver = UserModel.fromMap(rRSnap.docs[ind].data());
//
//               DbHelper.getAllchat(currentUserPhone, randomReciver.phone!)
//                   .listen((snapshot) {
//                 List<TextModel> tM = List.generate(snapshot.docs.length, (idx) {
//                   return TextModel.fromMap(snapshot.docs[idx].data());
//                 });
//
//                 // Update the chat map
//                 randomReceiversChat[randomReciver.phone!] = tM;
//
//                 notifyListeners();
//               });
//
//               return randomReciver;
//             });
//
//             notifyListeners();
//           });
//
//           notifyListeners();
//         }
//         return data;
//       });
//     });
//
//     notifyListeners();
//     isDataLoaded = true;
//     notifyListeners();
//   }
// }



///MADE BY AKASH BHAI
// import 'package:flutter/material.dart';
// import 'package:texting_app/auth/auth_service.dart';
// import 'package:texting_app/db/db_helper.dart';
// import 'package:texting_app/model/message_model.dart';
// import 'package:texting_app/model/text_model.dart';
// import 'package:texting_app/model/user_model.dart';
// import 'package:texting_app/models/user_list_model.dart';
//
// class ChatProvider extends ChangeNotifier {
//   List<UserModel> users = [];
//   List<UserModel> randomRecivers = [];
//   List<List<TextModel>> randomReceiversChat = [[]];
//   bool isDataLoaded = false;
//
//   //List<List<TextModel>> randomReciversChat = [[TextModel(username: "Tanvir"), TextModel(username: "Ahmed"), TextModel(username: "Ananada"), ],[TextModel(username: "Monjur"), TextModel(username: "Ahmed"), TextModel(username: "Akash"), ]];
//   String currentUserUsername = '';
//   String currentUserPhone = '';
//   String currentUserImage = '';
//
//   ///FETCH CURRENT USER PHONE ALONG WITH ALL USERDATA
//   getData() async {
//     DbHelper.getAllUserData().listen((snapshot) {
//       users = List.generate(
//         snapshot.docs.length,
//             (index) {
//           var data = UserModel.fromMap(snapshot.docs[index].data());
//           print(data.username);
//           if (data.email == AuthService.user?.email) {
//             currentUserPhone = data.phone!;
//             currentUserUsername = data.username;
//             currentUserImage = data.image ?? 'null';
//             notifyListeners();
//             print('*-*-*-*-*-Called-*-*--*--');
//             getCurrentUserChatList(currentUserPhone);
//             notifyListeners();
//           }
//           return data;
//         },
//       );
//
//       print(
//           '-----------++++++++++++++++++++++++++------------------++++++++++++++++-------------');
//       print(users.length);
//       print('Random Receiver: ${randomRecivers.length}');
//       print('Random Receiver Chat: ${randomReceiversChat.length}');
//       isDataLoaded = true;
//       notifyListeners();
//     });
//   }
//
//   ///FETCH CURRENT USER CHATLIST
//   getCurrentUserChatList(String phone) {
//     DbHelper.getCurrentUserChatList(phone).listen((snapshot) async {
//       randomRecivers = List.generate(snapshot.docs.length, (index) {
//         final data = UserModel.fromMap(snapshot.docs[index].data());
//         getAllChat(currentUserPhone, data.phone!);
//         return data;
//       });
//       notifyListeners();
//       print('Random Receiver: ${randomRecivers.length}');
//     });
//   }
//
//   ///FETCH RANDOM USERS CHATS
//   getAllChat(String userPhone, String receiverPhone) {
//     DbHelper.getAllchat(
//       userPhone,
//       receiverPhone,
//     ).listen((snapshot) {
//       List<TextModel> tM = [];
//       tM = List.generate(snapshot.docs.length,
//               (index) => TextModel.fromMap(snapshot.docs[index].data()));
//       randomReceiversChat.add(tM);
//       notifyListeners();
//     });
//   }
//
//   ///ADD A CHAT
//   addChat(String currentUser, String reciverPhone, MessageModel messagemodel) {
//     String? username;
//     for (var ele in users) {
//       if (ele.email == messagemodel.email) {
//         username = ele.username;
//       }
//     }
//     MessageModel messageModel = MessageModel(
//       username: username,
//       text: messagemodel.text,
//       time: messagemodel.time,
//       email: messagemodel.email,
//       phone: messagemodel.phone,
//       image: messagemodel.image,
//     );
//     for (var ele in users) {
//       if (ele.phone == reciverPhone) {
//         DbHelper.addChat(currentUser, reciverPhone, messageModel, ele);
//       }
//     }
//   }
//
//   ///FETCH ALL USERDATA & FETCH CURRENT USERDATA
//   getAllUserData() {
//     DbHelper.getAllUserData().listen((snap) {
//       for (var ele in snap.docs) {
//         UserModel userModel = UserModel.fromMap(ele.data());
//         users.insert(0, userModel);
//         notifyListeners();
//         print("//////////////////////////");
//         print(userModel.username);
//         print("//////////////////////////");
//         if (userModel.email == AuthService.user?.email) {
//           currentUserPhone = userModel.phone!;
//           notifyListeners();
//           getCurrentUserChatList(userModel.phone!);
//           /*print("++++++++++++++++++");
//           print("--------------------------------------${userModel.username}--------------------------");
//           print("++++++++++++++++++");*/
//         }
//       }
//     });
//   }
//
//   ///SEND MESSAGE
//   sendMessage(int index, String senderPhone, String reciverPhone,
//       TextModel textModel) =>
//       DbHelper.sendMessage(senderPhone, reciverPhone, textModel,
//           "MessageNo.${(randomReceiversChat[index].length + 1)}");
//
//   resetData() {
//     users.clear();
//     randomRecivers.clear();
//     randomReceiversChat.clear();
//     currentUserUsername = '';
//     currentUserPhone = '';
//     currentUserImage = '';
//     notifyListeners();
//   }
// }






