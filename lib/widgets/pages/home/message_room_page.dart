import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/utils/chat.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/text_fields.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:eros/widgets/pages/profile/image_crop_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      Chat(name: 'user2', time: DateTime(2021, 5, 3, 13, 15), message: "안녕하세요~")
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
      chats = [Chat(name: 'user1', time: DateTime.now(), message: text), ...chats];
    });
    controller.clear();
  }

  String convertTimetoString(DateTime time) {
    String hour = time.hour - 12 >= 0 ? 
      '오후 ${(time.hour-12).toString().padLeft(2, '0')}' 
      : '오전 ${time.hour.toString().padLeft(2, '0')}';
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  bool isMinuteSame(DateTime t1, DateTime t2) =>
    t1.difference(t2).inMinutes == 0 && t1.minute == t2.minute;

  void uploadImage() async {
    PickedFile _image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (_image == null) return;
    File _imageFile = await Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => ImageCropPage(file: File(_image.path))));
    if (_imageFile != null) {
      Chat imageChat = Chat(
        name: 'user1',
        time: DateTime.now(),
        image: base64Encode(_imageFile.readAsBytesSync())
      );
      setState((){
        chats = [imageChat, ...chats];
      });
    }
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
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              reverse: true,
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                return buildChat(index);
              }
            )
          ),
          buildChatInputField()
        ]
      ),
    );
  }

  Widget buildChat(int index) {
    bool isLast = index == 0;
    bool isUserSame = !isLast && chats[index].name == chats[index-1].name; 
    bool isTimeSame = !isLast && isUserSame && isMinuteSame(chats[index].time, chats[index-1].time);
    bool isMine = chats[index].name == widget.username;
    String strTime = convertTimetoString(chats[index].time);
    Widget timeWidget = Container(
      margin: EdgeInsets.only(top: 0.0, left: isMine ? 0 : 42.0),
      child: Text(
        strTime,
        style: TextStyle(fontSize: 9, height: 1.6, color: Skin.lightgrey),
      )
    );
    return Column(
      crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        SizedBox(height: 6.0),
        isMine ? buildRightBubble(text: chats[index].message, image: chats[index].image)
        : buildLeftBubble(text: chats[index].message, image: chats[index].image, profile: 'assets/images/profile_test.png'),
        isLast || !isUserSame || !isTimeSame ? timeWidget : Container()
      ],
    );
     
  }

  Widget buildLeftBubble({String text, String image, String profile}) {
    var rad = Radius.circular(16);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        profile == null ? SizedBox(width: 30,) : Images.asset(
          width: 30, height: 30,
          borderRadius: 15,
          path: profile
        ),
        SizedBox(width: 12),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Skin.bubbleLeft,
            borderRadius: BorderRadius.only(topLeft: rad, topRight: rad, bottomRight: rad)
          ),
          child: image == null ? 
            Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                height: 1.6,
                letterSpacing: 0.67,
                color: Skin.chatText
              ),
            ) : Image.memory(base64Decode(image), width: 150, height: 150)
        )
      ]
    );
  }

  Widget buildRightBubble({String text, String image}) {
    var rad = Radius.circular(16);
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Skin.bubbleRight,
        borderRadius: BorderRadius.only(topLeft: rad, topRight: rad, bottomLeft: rad)
      ),
      child: image == null ? 
        Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            height: 1.6,
            letterSpacing: 0.67,
            color: Skin.chatText
          ),
          textAlign: TextAlign.center,
        ) : Image.memory(base64Decode(image), width: 150, height: 150),
    );
  }

  Widget buildChatInputField() {
    var border = const OutlineInputBorder(
      borderSide: BorderSide(color: const Color(0x1d000000)),
      borderRadius: BorderRadius.all(Radius.circular(12.0))
    );
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 120,
      ),
      color: Skin.unselected,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Skin.white,
            hoverColor: Skin.white,
            focusedBorder: border, enabledBorder: border,
            contentPadding: const EdgeInsets.symmetric(vertical: 9),
            prefixIcon: InkWell(
              child: Icon(Icons.add, size: 20, color: Skin.grey),
              onTap: () => uploadImage(),
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