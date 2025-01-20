const String userModelUsername = 'username';
const String userModelEmail = 'username';
const String userModelPhone = 'phone';
const String userModelImage = 'image';
const String userModelTime = 'time';
const String userModelText = 'text';

class Message {
  String username;
  String image;
  String time;
  String text;

  Message({
    required this.username,
    required this.image,
    required this.time,
    required this.text,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      username: map[userModelUsername] ?? '',
      image: map[userModelImage] ?? '',
      time: map[userModelTime] ?? '',
      text: map[userModelText] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      userModelUsername: username,
      userModelImage: image,
      userModelTime: time,
      userModelText: text,
    };
  }
}

class ChatRoom {
  List<Message> chatRoomMessages;
  String username;
  String phone;
  String email;
  String image;

  ChatRoom({
    required this.chatRoomMessages,
    required this.username,
    required this.phone,
    required this.email,
    required this.image,
  });

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      chatRoomMessages: (map['chat_room_messages'] as List)
          .map((messageMap) => Message.fromMap(messageMap.values.first))
          .toList(),
      username: map[userModelUsername] ?? '',
      phone: map[userModelPhone] ?? '',
      email: map[userModelEmail] ?? '',
      image: map[userModelImage] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chat_room_messages':
      chatRoomMessages.map((message) => {'message_no': message.toMap()}).toList(),
      userModelUsername: username,
      userModelPhone: phone,
      userModelEmail: email,
      userModelImage: image,
    };
  }
}

class User {
  List<ChatRoom> chatList;
  String username;
  String phone;
  String email;
  String image;

  User({
    required this.chatList,
    required this.username,
    required this.phone,
    required this.email,
    required this.image,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      chatList: (map['chat_list'] as List)
          .map((chatRoomMap) => ChatRoom.fromMap(chatRoomMap.values.first))
          .toList(),
      username: map[userModelUsername] ?? '',
      phone: map[userModelPhone] ?? '',
      email: map[userModelEmail] ?? '',
      image: map[userModelImage] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chat_list': chatList.map((chatRoom) => {'random_receiver': chatRoom.toMap()}).toList(),
      userModelUsername: username,
      userModelPhone: phone,
      userModelEmail: email,
      userModelImage: image,
    };
  }
}

class UserDataList {
  List<User> userList;

  UserDataList({required this.userList});

  factory UserDataList.fromMap(Map<String, dynamic> map) {
    return UserDataList(
      userList: (map['user_list'] as List)
          .map((userMap) => User.fromMap(userMap.values.first))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_list': userList.map((user) => {'random_user': user.toMap()}).toList(),
    };
  }
}
