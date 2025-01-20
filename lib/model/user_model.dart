const String keyUsername = 'username';
const String keyEmail = 'email';
const String keyPhone = 'phone';
const String keyPhoneList = 'phoneList';
const String keyImage = 'image';

class UserModel {
  final String username;
  final String? email;
  final List<dynamic>? phoneList;
  final String? image;
  final bool available;

  UserModel({
    required this.username,
    this.email,
    this.phoneList,
    this.image,
    this.available = true,
  });

  Map<String, dynamic> toMap(){
    return{
      keyUsername : username,
      keyEmail : email,
      keyPhoneList : phoneList,
      keyImage : image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> json){
    return UserModel(
      username: json[keyUsername],
      email: json[keyEmail],
      phoneList: json[keyPhoneList],
      image: json[keyImage],
    );
  }

}