import 'package:flutter/material.dart';
import 'package:texting_app/_trash/trash_model_class.dart';

const Color baseColor = Color(0xfff88d92);

//size 800/360
// height : 820.5714285714286
// I/flutter ( 4209): width : 411.42857142857144

const Color main1_1 = Color(0xffFFF5F5);
const Color main1_2 = Color(0xffFFF5F5);
const Color main2_1 = Color(0xffFFE9E9);
const Color main2_2 = Color(0xffFFF5F5);
const Color linear_1 = Color(0xffFE5F74);
const Color linear_2 = Color(0xffF88D92);
const Color word = Color(0xffFCB4BE);
const Color title_1 = Color(0xff0D0C0C);
const Color title_2 = Color(0xffF88D92);
const Color text = Color(0xffED6C7D);
const Color black1 = Color(0xff2C3C4B);
const Color white = Color(0xffFFFFFF);
const Color watermark = Color(0xffBC6277);
const Color black2 = Color(0xff242323);
const Color grey = Color(0xff898B8F);



const Color packagePurple1 = Color(0xff702C8B);
const Color packagePurple2 = Color(0xff837FB1);
const Color violet = Color(0xff584660);
const Color black3 = Color(0xff413C43);

const Color blue = Color(0xff2D669B);
const Color green = Color(0xff008B16);







const Color themeBlue = Color(0xff1e6bff);
const Color themePurple = Color(0xffb929ff);




// UserList userList = UserList(users: [
//   User(chatList: [
//     ChatRoom(messages: [
//       Message(image: "image", time: "time", text: "text", username: "username")
//     ], email: "email", image: "image", phone: "phone", username: "username")
//   ], email: "email", image: "image", phone: "phone", username: "username")
// ]);
















final slideDetails = [
  {
    'short title': 'Plan a trip',
    'short details': 'Easily you can select the date and alos we can help you by suggesting you to set a good schedule '
  },
  {
    'short title': 'Book A Trip',
    'short details': 'Found the trip that matches your destination and schedule. Book it in just few taps'
  },
  {
    'short title': 'Enjoy your trip',
    'short details': 'A Easy discovering new places and share these between your friends and travel together'
  },
];






mQHeight(double height, BuildContext context) {
  return height * ((MediaQuery.of(context).size.height) / 844);
}

mQWidth(double width, BuildContext context) {
  return width * ((MediaQuery.of(context).size.width) / 390);
}
