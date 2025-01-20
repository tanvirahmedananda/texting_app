const String keyUsername = 'username';
const String keyText = 'text';
const String keyTime = 'time';
const String keyImage = 'image';

class TextModel {
  final String username;
  final String? text;
  final String? time;
  final String? image;

  TextModel({
    required this.username,
    this.text,
    this.time,
    this.image
  });

  Map<String, dynamic> toMap(){
    return{
      keyUsername : username,
      keyText : text,
      keyTime : time,
      keyImage : image,
    };
  }

  factory TextModel.fromMap(Map<String, dynamic> json){
    return TextModel(
      username: json[keyUsername],
      text: json[keyText],
      time: json[keyTime],
      image: json[keyImage],
    );
  }

}