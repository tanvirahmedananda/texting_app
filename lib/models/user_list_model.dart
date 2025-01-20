class UserListModel {
  final List<ChatList> chatList;
  final List<UserData> userData;

  UserListModel({
    this.chatList = const [],
    this.userData = const [],
  });

  // Factory constructor for creating an instance from JSON
  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      chatList: (json['chat_list'] as List<dynamic>?)
          ?.map((v) => ChatList.fromJson(v as Map<String, dynamic>))
          .toList() ??
          [],
      userData: (json['user_data'] as List<dynamic>?)
          ?.map((v) => UserData.fromJson(v as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  // Convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'chat_list': chatList.map((v) => v.toJson()).toList(),
      'user_data': userData.map((v) => v.toJson()).toList(),
    };
  }
}

class ChatList {
  final List<ChatRoomMessages> chatRoomMessages;

  ChatList({this.chatRoomMessages = const []});

  factory ChatList.fromJson(Map<String, dynamic> json) {
    return ChatList(
      chatRoomMessages: (json['chat_room_messages'] as List<dynamic>?)
          ?.map((v) => ChatRoomMessages.fromJson(v as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_room_messages': chatRoomMessages.map((v) => v.toJson()).toList(),
    };
  }
}

class ChatRoomMessages {
  final String message;

  ChatRoomMessages({required this.message});

  factory ChatRoomMessages.fromJson(Map<String, dynamic> json) {
    return ChatRoomMessages(
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}

class UserData {
  final String email;
  final String image;
  final String phone;
  final String userName;

  UserData({
    this.email = '',
    this.image = '',
    this.phone = '',
    this.userName = '',
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      phone: json['phone'] ?? '',
      userName: json['user_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'image': image,
      'phone': phone,
      'user_name': userName,
    };
  }
}
