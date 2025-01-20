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
    required this.userData,
  });

  final List<UserData> userData;

  factory RandomUser.fromJson(Map<String, dynamic> json) {
    return RandomUser(
      userData: json[keyColUserData] == null
          ? []
          : List<UserData>.from(
          json[keyColUserData]!.map((x) => UserData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    keyColUserData: userData.map((x) => x?.toJson()).toList(),
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
}*/
