const String keyUsername = 'username';
const String keyEmail = 'email';
const String keyPhone = 'phone';
const String keyText = 'text';
const String keyTime = 'time';
const String keyImage = 'image';

class MessageModel {
  final String? username;
  final String? email;
  final String? phone;
  final String? text;
  final String? time;
  final String? image;

  MessageModel({
    this.username,
    this.email,
    this.phone,
    this.text,
    this.time,
    this.image
  });

  Map<String, dynamic> toMap(){
    return{
      keyUsername : username,
      keyEmail : email,
      keyPhone : phone,
      keyText : text,
      keyTime : time,
      keyImage : image,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> json){
    return MessageModel(
      username: json[keyUsername],
      email: json[keyEmail],
      phone: json[keyPhone],
      text: json[keyText],
      time: json[keyTime],
      image: json[keyImage],
    );
  }

}