import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:texting_app/model/text_model.dart';
import 'package:texting_app/pages/view_contact_page.dart';
import 'package:texting_app/providers/chat_provider.dart';
import 'package:texting_app/utils/constants.dart';
import 'package:texting_app/widget/poppins_text.dart';
import 'package:texting_app/widget/reciver_text_box.dart';
import 'package:texting_app/widget/user_text_box.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = '/chat_page';
  final int? index;

  const ChatPage({super.key, this.index});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // Provider.of<ChatProvider>(context, listen: false).getCurrentUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();

    print('//////////////4///////////');
    print(Provider.of<ChatProvider>(context, listen: false)
        .randomRecivers[widget.index!]
        .phoneList?.first);
    print(Provider.of<ChatProvider>(context, listen: false)
        .currentUserUsername);
    return SafeArea(
      child: Consumer<ChatProvider>(
          builder: (child, chatProv, _) => Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios)),
                  title: Container(
                    child: Row(
                      children: [
                        Container(
                          height: mQHeight(50, context),
                          width: mQHeight(50, context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: mQWidth(10, context),
                        ),
                        PoppinsText(
                            text:
                                chatProv.randomRecivers[widget.index!].username,
                            fontSize: 18,
                            color: themeBlue,
                            weight: FontWeight.w500)
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(onPressed: ()=>chatProv.addGroupMember(chatProv.randomRecivers[widget.index!].username, "cc", chatProv.randomReceiversChat[widget.index!]["receiverChatList"]), icon: Icon(Icons.add)),
                    IconButton(
                        onPressed: () => Navigator.pushNamed(
                            context, ViewContactPage.routeName),
                        icon: Icon(
                          Icons.info_outline,
                          size: 26,
                        ))
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(mQHeight(16, context)),
                      color: Colors.red,
                      child: ListView.builder(
                          reverse: true,
                          itemCount:
                              chatProv.randomReceiversChat[widget.index!]["receiverChatList"].length,
                          itemBuilder: (context, conindex) {
                            if (chatProv
                                    .randomRecivers[widget.index!].username ==
                                chatProv
                                    .randomReceiversChat[widget.index!]["receiverChatList"][conindex]
                                    .username) {
                              return ReciverTextBox(
                                text: chatProv
                                    .randomReceiversChat[widget.index!]["receiverChatList"][conindex]
                                    .text,
                                time: chatProv
                                        .randomReceiversChat[widget.index!]["receiverChatList"]
                                            [conindex]
                                        .time ??
                                    '',
                                image: chatProv
                                        .randomReceiversChat[widget.index!]["receiverChatList"]
                                            [conindex]
                                        .image ??
                                    '',
                              );
                            } else {
                              return UserTextBox(
                                text: chatProv
                                    .randomReceiversChat[widget.index!]["receiverChatList"][conindex]
                                    .text,
                                time: chatProv
                                        .randomReceiversChat[widget.index!]["receiverChatList"]
                                            [conindex]
                                        .time ??
                                    '',
                              );
                            }
                          }),
                    )),
                    Container(
                      height: 50,
                      width: 360,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 312,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                            alignment: Alignment.center,
                            child: Container(
                              height: 40,
                              width: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: messageController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                print("random receiver phone: ${chatProv.randomRecivers[widget.index!].phoneList}");
                                chatProv.sendMessage(widget.index!,
                                    chatProv.currentUserPhone,
                                    chatProv
                                        .randomRecivers[widget.index!].phoneList!,
                                    TextModel(
                                      username: chatProv.currentUserUsername,
                                      text: messageController.text,
                                      image: chatProv.currentUserImage,
                                      time: null,
                                    ));
                                messageController.clear();
                              },
                              icon: Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}

final dummyText =
    '''Lorem ipsum odor amet, consectetuer adipiscing elit. Dictum integer massa nisl sed maximus eleifend sed penatibus. Mattis iaculis vestibulum penatibus quam,.''';
