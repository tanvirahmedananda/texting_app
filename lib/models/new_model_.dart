//Collection & Document keys
const String keyColUserList = 'UL';

const String keyColChatList = 'ChatList';

const String keyColChatRoomMessages = 'ChatRoomMessages';


const String keyColUserData = 'UserData';
const String keydocUserDataDetails = 'details';






//UserDetails & message keys
const String keyUsername = 'username';
const String keyEmail = 'email';
const String keyPhone = 'phone';
const String keyText = 'text';
const String keyImage = 'image';

/*

class UserList {
  UserList({
    required this.randomUser,
  });

  final RandomUser? randomUser;

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      randomUser: json["random_user"] == null
          ? null
          : RandomUser.fromJson(json["random_user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "random_user": randomUser?.toJson(),
  };
}

class ChatList {
  ChatList({
    required this.randomReciver,
  });

  final RandomReciver? randomReciver;

  factory ChatList.fromJson(Map<String, dynamic> json) {
    return ChatList(
      randomReciver: json["random_reciver"] == null
          ? null
          : RandomReciver.fromJson(json["random_reciver"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "random_reciver_1": randomReciver?.toJson(),
  };
}

class ChatRoomMessage {
  ChatRoomMessage({
    required this.messageNo,
  });

  final MessageNo? messageNo;

  factory ChatRoomMessage.fromJson(Map<String, dynamic> json) {
    return ChatRoomMessage(
      messageNo: json["message_no_"] == null
          ? null
          : MessageNo.fromJson(json["message_no_"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message_no_1": messageNo?.toJson(),
  };
}











class UserListModel {
  UserListModel({
    required this.userList,
  });

  final List<UserList> userList;

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      userList: json[keyColUserList] == null
          ? []
          : List<UserList>.from(
          json[keyColUserList]!.map((x) => UserList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    keyColUserList: userList.map((x) => x?.toJson()).toList(),
  };
}



class RandomUser {
  RandomUser({
    required this.chatList,
    required this.userData,
  });

  final List<ChatList> chatList;
  final List<UserData> userData;

  factory RandomUser.fromJson(Map<String, dynamic> json) {
    return RandomUser(
      chatList: json[keyColChatList] == null
          ? []
          : List<ChatList>.from(
          json[keyColChatList]!.map((x) => ChatList.fromJson(x))),
      userData: json[keyColUserData] == null
          ? []
          : List<UserData>.from(
          json[keyColUserData]!.map((x) => UserData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    keyColChatList: chatList.map((x) => x?.toJson()).toList(),
    keyColUserData: userData.map((x) => x?.toJson()).toList(),
  };
}



class RandomReciver {
  RandomReciver({
    required this.chatRoomMessages,
  });

  final List<ChatRoomMessage> chatRoomMessages;

  factory RandomReciver.fromJson(Map<String, dynamic> json) {
    return RandomReciver(
      chatRoomMessages: json[keyColChatRoomMessages] == null
          ? []
          : List<ChatRoomMessage>.from(json[keyColChatRoomMessages]!
          .map((x) => ChatRoomMessage.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    keyColChatRoomMessages:
    chatRoomMessages.map((x) => x?.toJson()).toList(),
  };
}



class MessageNo {
  MessageNo({
    required this.email,
    required this.image,
    required this.phone,
    required this.text,
    required this.username,
  });

  final String? email;
  final String? image;
  final String? phone;
  final String? text;
  final String? username;

  factory MessageNo.fromJson(Map<String, dynamic> json) {
    return MessageNo(
      email: json[keyEmail],
      image: json[keyImage],
      phone: json[keyPhone],
      text: json[keyText],
      username: json[keyUsername],
    );
  }

  Map<String, dynamic> toJson() => {
    keyEmail: email,
    keyImage: image,
    keyPhone: phone,
    keyText: text,
    keyUsername: username,
  };
}

class UserData {
  UserData({
    required this.details,
  });

  final Details? details;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      details:
      json[keydocUserDataDetails] == null ? null : Details.fromJson(json[keydocUserDataDetails]),
    );
  }

  Map<String, dynamic> toJson() => {
    keydocUserDataDetails: details?.toJson(),
  };
}

class Details {
  Details({
    required this.email,
    required this.image,
    required this.phone,
    required this.userName,
  });

  final String? email;
  final String? image;
  final String? phone;
  final String? userName;

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      email: json[keyEmail],
      image: json[keyImage],
      phone: json[keyPhone],
      userName: json[keyUsername],
    );
  }

  Map<String, dynamic> toJson() => {
    keyEmail: email,
    keyImage: image,
    keyPhone: phone,
    keyUsername: userName,
  };
}
*/
