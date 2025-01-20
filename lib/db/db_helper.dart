import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:texting_app/model/text_model.dart';
import 'package:texting_app/model/user_model.dart';

import '../model/message_model.dart';

const String collectionUserList = 'UserList';
const String collectionChatList = 'ChatList';
const String collectionUserData = 'UserData';
const String collectionChatRoom = 'ChatRoomMassages';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///REGISTER NEW USERDATA
  //CREATE COLLECTION & DOC AND THEN PUT THE MODEL INSIDE THE DOC
  static Future<void> addUser(UserModel userModel) => _db
      .collection(collectionUserList)
      .doc(userModel.phoneList?.first)
      .set(userModel.toMap());

  /*static Future<void> addUser(UserModel userModel) {
    //CREATE COLLECTION & DOC AND THEN PUT THE MODEL INSIDE THE DOC
    final doc = _db.collection(collectionUserList).doc(userModel.phone);
    return doc.set(userModel.toMap());
  }*/ //OLD METHOD

  ///ADD A CHAT
  static Future<void> addChat(
      String currentUser,
      String reciverPhone,
      MessageModel messageModel,
      UserModel reciverUserModel,
      UserModel currentUserModel) {
    TextModel textModel = TextModel(
      username: messageModel.username!,
      image: messageModel.image,
      text: messageModel.text,
      time: messageModel.time,
    );
    //CREATE COLLECTION & DOC AND THEN PUT THE MODEL INSIDE THE DOC
    _db
        .collection(collectionUserList)
        .doc(currentUser)
        .collection(collectionChatList)
        .doc(reciverPhone)
        .set(reciverUserModel.toMap());
    _db
        .collection(collectionUserList)
        .doc(currentUser)
        .collection(collectionChatList)
        .doc(reciverPhone)
        .collection(collectionChatRoom)
        .doc('Initial text')
        .set(textModel.toMap());
    _db
        .collection(collectionUserList)
        .doc(reciverPhone)
        .collection(collectionChatList)
        .doc(currentUser)
        .collection(collectionChatRoom)
        .doc('Initial text')
        .set(textModel.toMap());
    return _db
        .collection(collectionUserList)
        .doc(reciverPhone)
        .collection(collectionChatList)
        .doc(currentUser)
        .set(currentUserModel.toMap());
  }

  ///CREATE A GROUP
  static Future<void> createGroup(UserModel groupModel, TextModel textModel) {
    //CREATE COLLECTION & DOC AND THEN PUT THE MODEL INSIDE THE DOC
    _db
        .collection(collectionUserList)
        .doc(groupModel.phoneList?[1])
        .collection(collectionChatList)
        .doc(groupModel.username)
        .set(groupModel.toMap());
    return _db
        .collection(collectionUserList)
        .doc(groupModel.phoneList?[1])
        .collection(collectionChatList)
        .doc(groupModel.username)
        .collection(collectionChatRoom)
        .doc('Initial text')
        .set(textModel.toMap());
  }

  ///ADD A Member
  static Future<void> addGroupMember(
      String currentUser,
      String groupName,
      String newMember,
      List<TextModel> chatList) async {
    try {
      // Fetch the document once
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection(collectionUserList)
          .doc(currentUser)
          .collection(collectionChatList)
          .doc(groupName)
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        UserModel groupModel = UserModel.fromMap(snapshot.data()!);

        groupModel.phoneList?.add(newMember);

        // Update the group for all existing members
        for (int i = 1; i < groupModel.phoneList!.length; i++) {
          await FirebaseFirestore.instance
              .collection(collectionUserList)
              .doc(groupModel.phoneList?[i])
              .collection(collectionChatList)
              .doc(groupModel.phoneList?.first)
              .set(groupModel.toMap());
        }

        /*// Add the chat list for the new member
        for (var ele in chatList) {
          await FirebaseFirestore.instance
              .collection(collectionUserList)
              .doc(newMember)
              .collection(collectionChatList)
              .doc(groupName)
              .collection(collectionChatRoom)
              .doc()
              .set(ele.toMap());
        }*/

        // Access groupModel fields if needed
        print("Group Username: ${groupModel.username}");
        print("Phone List: ${groupModel.phoneList}");
      } else {
        print("Document does not exist or has no data.");
      }
    } catch (e) {
      print("Error: $e");
    }
  }


  /*static Future<void> addChat(String currentUser, String reciverPhone,
      MessageModel messageModel, UserModel userModel) {
    //CREATE COLLECTION & DOC AND THEN PUT THE MODEL INSIDE THE DOC
    final doc = _db.collection(collectionUserList).doc(currentUser);
    final doc_ = _db.collection(collectionUserList).doc(reciverPhone);
    final doc2 = doc.collection(collectionChatList).doc(reciverPhone);
    final doc2_ = doc_.collection(collectionChatList).doc(currentUser);
    final doc3 = doc2.collection(collectionChatRoom).doc('Chat2');
    final doc3_ = doc2_.collection(collectionChatRoom).doc('Chat2');
    TextModel textModel = TextModel(
      username: messageModel.username!,
      image: messageModel.image,
      text: messageModel.text,
      time: messageModel.time,
    );
    doc3.set(textModel.toMap());
    doc3_.set(textModel.toMap());
    doc2_.set(userModel.toMap());
    return doc2.set(userModel.toMap());
  }*/ //OLD METHOD

  ///GET CURRENT USERDATA
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUser(
          String phone) =>
      _db.collection(collectionUserList).doc(phone).snapshots();

  ///GET ALL USERDATA ONCE
  static Future<QuerySnapshot<Map<String, dynamic>>> getAllUserDataOnce() =>
      _db.collection(collectionUserList).get();

  ///GET ALL USERDATA
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUserData() =>
      _db.collection(collectionUserList).snapshots();

  ///GET CURRENT USER CHAT DATA
  static Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentUserChatList(
          String phone) =>
      _db
          .collection(collectionUserList)
          .doc(phone)
          .collection(collectionChatList)
          .snapshots();

  ///GET ALL CHAT
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllchat(
          String userPhone, String reciverPhone) =>
      _db
          .collection(collectionUserList)
          .doc(userPhone)
          .collection(collectionChatList)
          .doc(reciverPhone)
          .collection(collectionChatRoom)
          .snapshots();

  ///SEND MESSAGE
  static Future<void> sendMessage(String senderPhone, List<dynamic> reciverPhone,
      TextModel textModel) {
    if(reciverPhone.length == 1){
      _db
          .collection(collectionUserList)
          .doc(reciverPhone.first)
          .collection(collectionChatList)
          .doc(senderPhone)
          .collection(collectionChatRoom)
          .doc()
          .set(textModel.toMap());
      return _db
          .collection(collectionUserList)
          .doc(senderPhone)
          .collection(collectionChatList)
          .doc(reciverPhone.first)
          .collection(collectionChatRoom)
          .doc()
          .set(textModel.toMap());
    }else{
      for(int i = 0; i < reciverPhone.length; i++){
        print("Lenght of receiver phone : ${reciverPhone.length}");
        if(reciverPhone[i]==reciverPhone.first || reciverPhone[i]==senderPhone){
          continue;
        }
        print(reciverPhone[i]);
        _db
            .collection(collectionUserList)
            .doc(reciverPhone[i])
            .collection(collectionChatList)
            .doc(reciverPhone.first)
            .collection(collectionChatRoom)
            .doc()
            .set(textModel.toMap());
      }
      return _db
          .collection(collectionUserList)
          .doc(senderPhone)
          .collection(collectionChatList)
          .doc(reciverPhone.first)
          .collection(collectionChatRoom)
          .doc()
          .set(textModel.toMap());
    }

  }
  /*static Future<void> sendMessage(
      String senderPhone,
      List<dynamic> receiverPhone,
      TextModel textModel,
      String messageId,
      ) async {
    try {
      final batch = _db.batch(); // Use a batch for atomic writes

      if (receiverPhone.length == 1) {
        // Ensure the parent document exists
        DocumentReference receiverDoc = _db
            .collection(collectionUserList)
            .doc(receiverPhone.first)
            .collection(collectionChatList)
            .doc(senderPhone);

        batch.set(receiverDoc, {'exists': true}, SetOptions(merge: true)); // Ensure parent exists
        batch.set(
          receiverDoc.collection(collectionChatRoom).doc(messageId),
          textModel.toMap(),
        );
      } else {
        for (int i = 1; i < receiverPhone.length; i++) {
          print("Length of receiver phone : ${receiverPhone.length}");
          print(receiverPhone[i]);

          // Ensure the parent document exists
          DocumentReference receiverDoc = _db
              .collection(collectionUserList)
              .doc(receiverPhone[i])
              .collection(collectionChatList)
              .doc(receiverPhone.first);

          batch.set(receiverDoc, {'exists': true}, SetOptions(merge: true)); // Ensure parent exists
          batch.set(
            receiverDoc.collection(collectionChatRoom).doc(messageId),
            textModel.toMap(),
          );
        }
      }

      // Ensure the sender's parent document exists
      DocumentReference senderDoc = _db
          .collection(collectionUserList)
          .doc(senderPhone)
          .collection(collectionChatList)
          .doc(receiverPhone.first);

      batch.set(senderDoc, {'exists': true}, SetOptions(merge: true)); // Ensure parent exists
      batch.set(
        senderDoc.collection(collectionChatRoom).doc(messageId),
        textModel.toMap(),
      );

      // Commit the batch
      await batch.commit();

      print("Message sent successfully.");
    } catch (e) {
      print("Error sending message: $e");
    }
  }*/

/*
  static Future<void> addUserData(
      UserListModel userListModel, String userId) async {
    // Reference to the user_list collection
    final userDoc = _db.collection('user_list').doc(userId);

    // Save chat_list as a sub-collection
    for (final chat in userListModel.chatList) {
      final chatDoc = await userDoc.collection('chat_list').add({});
      for (final message in chat.chatRoomMessages) {
        await chatDoc.collection('chat_room_messages').add(message.toJson());
      }
    }

    // Save user_data as a sub-collection
    for (final user in userListModel.userData) {
      await userDoc.collection('user_data').add(user.toJson());
    }
  }

  static Future<List<UserListModel>> fetchAllUserData() async {
    try {
      // Reference to the 'user_list' collection
      final userListQuery = await _db
          .collection('user_list')
          .doc('01758187661')
          .collection('user_data')
          .get();
      // final userListQuery = await _db.collection('user_list').get();

      final data = await _db
          .collection('user_list')
          .doc('01725402748')
          .collection('user_data')
          .doc('eWt8lUDcwPmiFe0et4hm')
          .get();
      final data1 = await _db.collection('user_list').doc('01725402748').get();

      print(data.data()?['email']);

      print('Total documents in user_list collection: ${userListQuery.size}');
      print('Documents:');
      for (var doc in userListQuery.docs) {
        print('Document ID: ${doc.id}, Data: ${doc.data()}');
      }

      if (userListQuery.docs.isEmpty) {
        print("No users found");
        return [];
      } else {
        print('Found ${userListQuery.docs.length} documents');
      }

      if (userListQuery.docs.isEmpty) {
        print("No users found");
        return [];
      }

      // Convert each document to a UserListModel
      final List<UserListModel> users = [];
      for (final userDoc in userListQuery.docs) {
        // Fetch user_data sub-collection
        final userDataQuery =
            await userDoc.reference.collection('user_data').get();
        final userData = userDataQuery.docs
            .map((doc) => UserData.fromJson(doc.data()))
            .toList();

        // Fetch chat_list sub-collection
        final chatListQuery =
            await userDoc.reference.collection('chat_list').get();
        final chatList =
            await Future.wait(chatListQuery.docs.map((chatDoc) async {
          // Fetch chat_room_messages for each chat
          final chatRoomMessagesQuery =
              await chatDoc.reference.collection('chat_room_messages').get();
          final chatRoomMessages = chatRoomMessagesQuery.docs
              .map((msgDoc) => ChatRoomMessages.fromJson(msgDoc.data()))
              .toList();

          return ChatList(chatRoomMessages: chatRoomMessages);
        }).toList());

        // Reconstruct UserListModel
        final userListModel = UserListModel(
          chatList: chatList,
          userData: userData,
        );

        users.add(userListModel);
      }

      return users;
    } catch (e) {
      print("Error fetching all user data: $e");
      return [];
    }
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getSingleUserData() {
    return _db
        .collection(collectionUserList)
        .doc('Tanvir')
        .collection('chat_list')
        .doc('3wblDVy5HyH2ctJ45wnQ')
        .collection('chat_room_messages')
        .doc('xrRyibhNM3tcdvI8FiBn')
        .snapshots();
  }*/
}
