import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/utils/chat.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/text_fields.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';

class MessageRoomPage extends StatefulWidget {
  MessageRoomPage({Key key, this.name, this.disconnect}) : super(key: key);

  final String name;
  final Function disconnect;
  String username = 'user1';

  @override
  _MessageRoomPageState createState() => _MessageRoomPageState();
}

class _MessageRoomPageState extends State<MessageRoomPage> {
  List<Chat> chats;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    chats = [
      Chat('user2', "안녕하세요~", DateTime(2021, 5, 3, 13, 15))
    ];
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void addChat(String text) {
    if (text.length == 0) return;
    setState((){
      chats = [Chat('user1', text, DateTime.now()), ...chats];
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffolds.basic(
      context: context,
      appBar: AppBars.basic(
        context: context,
        title: widget.name,
        fontSize: 16.0,
        actions: [
          TextButton(
            onPressed: () {
              widget.disconnect();
              Navigator.of(context).pop();
            },
            child: Text(tr('disconnect'), style: TextStyle(color: Skin.grey, fontSize: 12.0))
          )
        ]
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                reverse: true,
                itemCount: chats.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildChat(index);
                }
              )
            )
          ),
          buildChatInputField()
        ]
      ),
    );
  }

  Widget buildChat(int index) {
    log(index.toString() + chats.length.toString());
    bool isLast = index == 0 || chats[index-1].name != chats[index].name;
    bool isMine = chats[index].name == widget.username;
    Widget timeWidget = Container(
      margin: EdgeInsets.only(top: 10.0, left: isMine ? 0 : 42.0, bottom: 36.0),
      child: Text(
        chats[index].time.toString(),
        style: TextStyle(fontSize: 9, height: 1.6, color: Skin.lightgrey),
      )
    );
    return Column(
      crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        isMine ? buildRightBubble(chats[index].message)
        : buildLeftBubble(chats[index].message, imagePath: 'assets/images/profile_test.png'),
        isLast ? timeWidget : Container()
      ],
    );
     
  }

  Widget buildLeftBubble(String text, {String imagePath}) {
    var rad = Radius.circular(16);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        imagePath == null ? SizedBox(width: 30,) : Images.basic(
          width: 30, height: 30,
          borderRadius: 15,
          path: imagePath
        ),
        SizedBox(width: 12),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Skin.bubbleLeft,
            borderRadius: BorderRadius.only(topLeft: rad, topRight: rad, bottomRight: rad)
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.0,
              height: 1.6,
              letterSpacing: 0.67,
              color: Skin.chatText
            ),
          )
        )
      ]
    );
  }

  Widget buildRightBubble(String text) {
    var rad = Radius.circular(16);
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Skin.bubbleRight,
        borderRadius: BorderRadius.only(topLeft: rad, topRight: rad, bottomLeft: rad)
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.0,
          height: 1.6,
          letterSpacing: 0.67,
          color: Skin.chatText
        ),
      ),
    );
  }

  Widget buildChatInputField() {
    var border = const OutlineInputBorder(
      borderSide: BorderSide(color: const Color(0x1d000000)),
      borderRadius: BorderRadius.all(Radius.circular(12.0))
    );
    return Container(
      constraints: BoxConstraints(
        maxHeight: 120,
      ),
      color: Skin.unselected,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Skin.white,
            hoverColor: Skin.white,
            focusedBorder: border, enabledBorder: border,
            contentPadding: EdgeInsets.symmetric(vertical: 9),
            prefixIcon: InkWell(
              child: Icon(Icons.add, size: 20, color: Skin.grey),
              onTap: () {},
            ),
            suffixIcon: InkWell(
              child: Icon(Icons.send, size: 20, color: Skin.grey),
              onTap: () => addChat(controller.text)
            ),
          ),
          onSubmitted: (text) => addChat(text),
          style: TextStyle(
            color: Skin.grey,
            fontSize: 14
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          cursorColor: Skin.grey,
          cursorHeight: 18,
        )
      )
    );
  }
}