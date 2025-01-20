import 'package:flutter/material.dart';
import 'package:texting_app/auth/auth_service.dart';
import 'package:texting_app/db/db_helper.dart';
import 'package:texting_app/model/message_model.dart';
import 'package:texting_app/model/text_model.dart';
import 'package:texting_app/model/user_model.dart';

class ChatProvider extends ChangeNotifier {
  List<UserModel> users = [];
  List<UserModel> randomRecivers = [];
  // List<List<TextModel>> randomReceiversChat = [[]];
  // List<Map<String, dynamic>> receiverChats = [];
  List<Map<String,dynamic>> randomReceiversChat = [];
  bool isDataLoaded = false;

  //List<List<TextModel>> randomReceiversChat = [[TextModel(username: "Tanvir"), TextModel(username: "Ahmed"), TextModel(username: "Ananada"), ],[TextModel(username: "Monjur"), TextModel(username: "Ahmed"), TextModel(username: "Akash"), ]];
  String currentUserUsername = '';
  String currentUserPhone = '';
  String currentUserImage = '';

  late int chatRoomNO;








  //either user phone or phonelist or put phone inside phonelist and use it ase phonelist.first








  void addOrUpdateChat(String phone, UserModel randomUser, List<TextModel> chatList) {
    // Check if the phone already exists in the randomReceiversChat list
    int existingIndex = randomReceiversChat.indexWhere((element) => element["phone"] == phone);

    if (existingIndex != -1) {
      // If the phone exists, update the existing entry
      randomReceiversChat[existingIndex]["receiverChatList"] = chatList;
    } else {
      // If the phone does not exist, add a new entry
      randomReceiversChat.add({
        "phone": phone,
        "receiverDetails": randomUser,
        "receiverChatList": chatList,
      });
      print(randomReceiversChat[0]["receiverChatList"]);
    }
  }

// Example usage:
  /*addOrUpdateChat("1234567890", [
  TextModel(username: "John", text: "Hello again!", time: DateTime.now()),
  ]);

  addOrUpdateChat("0987654321", [
  TextModel(username: "Alice", text: "Updated message!", time: DateTime.now()),
  ]);*/




  chatRoomNo(int index){
    chatRoomNO = index;
    notifyListeners();
  }

  ///ADD A CHAT
  addChat(String currentUser, String reciverPhone, MessageModel messagemodel) {
    String? username;
    for (var ele in users) {
      if (ele.email == messagemodel.email) {
        username = ele.username;
      }
    }
    MessageModel messageModel = MessageModel(
      username: username,
      text: messagemodel.text,
      time: messagemodel.time,
      email: messagemodel.email,
      phone: messagemodel.phone,
      image: messagemodel.image,
    );
    UserModel currentUserModel = UserModel(username: username!,phoneList: [currentUserPhone], email: AuthService.user?.email, image: currentUserImage);
    for (var ele in users) {
      if (ele.phoneList?.first == reciverPhone) {
        DbHelper.addChat(currentUser, reciverPhone, messageModel, ele, currentUserModel);
      }
    }
  }

  createGroup(String groupName){
    UserModel groupModel = UserModel(username: groupName, phoneList: [groupName, currentUserPhone], email: '', );
    DbHelper.createGroup(groupModel,TextModel(
      username: currentUserUsername,
      image: null,
      text: "hey~~",
      time: null,
    ));
  }

  addGroupMember(String groupName, String newMember, List<TextModel> chatList)=>DbHelper.addGroupMember(currentUserPhone, groupName, newMember, chatList);

  ///FETCH CURRENT USER PHONE ALONG WITH ALL USERDATA
  getData() async {
    users.clear();
    randomRecivers.clear();
    randomReceiversChat.clear();
    DbHelper.getAllUserData().listen((snap) {
      users = List.generate(snap.docs.length, (index) {
        var data = UserModel.fromMap(snap.docs[index].data());
        if (data.email == AuthService.user?.email) {
          currentUserPhone = data.phoneList?.first!;
          currentUserUsername = data.username;
          currentUserImage = data.image ?? 'null';
          print(">>>>>>>>Current Username: ${currentUserUsername}");
          print(">>>>>>>>Current Phone: ${currentUserPhone}");
          print(">>>>>>>>Current Image: ${currentUserImage}");
          notifyListeners();
          DbHelper.getCurrentUserChatList(currentUserPhone)
              .listen((rRSnap) async {
            randomRecivers = List.generate(rRSnap.docs.length, (ind) {
              var randomReciver = UserModel.fromMap(rRSnap.docs[ind].data());
              print(rRSnap.docs.length);
              print(">>>>>>>>Random Username: ${randomReciver.username}");
              print(">>>>>>>>Random Phone: ${randomReciver.phoneList?.first!}");
              print(">>>>>>>>Random Image: ${randomReciver.image}");
              DbHelper.getAllchat(
                currentUserPhone,
                randomReciver.phoneList?.first!!,
              ).listen((snapshot) {
                List<TextModel> tM = [];
                print('Get all chat entered');
                print('snapshot.docs.length: ${snapshot.docs.length}');
                tM = List.generate(snapshot.docs.length, (idx) {
                  TextModel textModel =
                  TextModel.fromMap(snapshot.docs[idx].data());
                  print("????????????text: ${textModel.text}");
                  return textModel;
                });
                print("tM length : ${tM.length}");
                print("Random Receiver length : ${randomRecivers.length}");
                notifyListeners();
                addOrUpdateChat(randomReciver.phoneList?.first, randomReciver, tM);
                for(var ele in randomReceiversChat){
                  print("Random receiver length${ele.length}");
                }
                print(randomReceiversChat[(randomReceiversChat.length-1)].length);
                notifyListeners();
              });
              return randomReciver;
            });
            notifyListeners();
          });
          notifyListeners();
        }
        return data;
      });
    });
    notifyListeners();
    isDataLoaded = true;
    notifyListeners();
  }

  ///SEND MESSAGE
  sendMessage(int index, String senderPhone, List<dynamic> reciverPhone,
      TextModel textModel) {
    DbHelper.sendMessage(senderPhone, reciverPhone, textModel);
  }

  resetData() {
    users.clear();
    randomRecivers.clear();
    randomReceiversChat.clear();
    currentUserUsername = '';
    currentUserPhone = '';
    currentUserImage = '';
    notifyListeners();
  }
/*
  ///Get and Fetch Hierarchical data
  Future<void> addData() async {
    final userListModel = UserListModel(
      chatList: [
        ChatList(
          chatRoomMessages: [
            ChatRoomMessages(message: "Hello, how are you?"),
            ChatRoomMessages(message: "I'm fine, thank you!"),
          ],
        ),
        ChatList(
          chatRoomMessages: [
            ChatRoomMessages(message: "Are we meeting today?"),
            ChatRoomMessages(message: "Yes, at 5 PM."),
          ],
        ),
      ],
      userData: [
        UserData(
          email: "john.doe@example.com",
          image: "https://example.com/images/john.jpg",
          phone: "1234567890",
          userName: "John Doe",
        ),
        UserData(
          email: "jane.doe@example.com",
          image: "https://example.com/images/jane.jpg",
          phone: "0987654321",
          userName: "Jane Doe",
        ),
      ],
    );

    await DbHelper.addUserData(userListModel, '01758187661');
  }

  /// Fetch all user data
  List<UserListModel> userListModels = [];
  bool isLoading = false;

  // Fetch all user data and notify listeners
  Future<void> fetchAllUserData() async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await DbHelper.fetchAllUserData();
      userListModels = data;
      print(data.length);
      print(
          '----------------userlist length${userListModels.length} ---------------');
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getSingleData() async {
    try {
      // Get the first snapshot from the stream
      final snapshot = await DbHelper.getSingleUserData().first;

      if (snapshot.exists) {
        // Access the data
        final message = snapshot.data()?['message'];
        print(message);

        // Update your model or notify listeners as needed
        // orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
        notifyListeners();
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }*/
}



