import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/components/dividers.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:eros/widgets/items/message_room_item.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  List<Map<String, dynamic>> roomList;

  @override
  void initState() {
    super.initState();
    roomList = [];
  }

  void addChatRoom() {
    var newRoom = {
      "connected": true,
      "thumbnail": "assets/images/profile_test.png",
      "name": "이름은최대열글자까지",
      "lastChat": "대화내용이 길면 두 줄까지 표현 하되 여기까지만 표현하고뒤에는점점점...",
      "lastTime": "2020-01-20",
      "newCount": 1
    };
    setState(() {
      roomList = [newRoom, ...roomList];
    });
  }

  Function onPressRoom(String name) {
    // TODO: 채팅방 화면으로 navigate
    return () {log("onPressRoom");};
  }

  Function onLongPressRoom(String name) {
    return () {log("onLongPressRoom");};
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        roomList.length > 0 ? buildRoomList() : buildEmptyList(),
        Padding(
          padding: EdgeInsets.only(right: 20, bottom: 20),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Skin.primary, 
            onPressed: addChatRoom
          )
        )
      ]
    );
  }

  Widget buildEmptyList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Images.basic(
            context: context,
            width: 210, height: 210,
            path: 'assets/images/empty_message.png'
          ),
          const SizedBox(height: 36),
          Texts.secondary(
            context: context,
            height: 45,
            text: tr("empty_message_guide"),
            fontSize: 18.0,
            textAlign: TextAlign.center
          )
        ],
      )
    );
  }

  Widget buildRoomList() {
    return ListView.separated(
      itemCount: roomList.length,
      itemBuilder: (BuildContext context, int index) {
        return MessageRoomItem(
          active: roomList[index]['connected'],
          thumbnail: roomList[index]['thumbnail'],
          name: roomList[index]['name'],
          lastChat: roomList[index]['lastChat'],
          lastTime: roomList[index]['lastTime'],
          newCount: roomList[index]['newCount'],
          onPress: onPressRoom(roomList[index]['name']),
          onLongPress: onLongPressRoom(roomList[index]['name']),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) {
        return Container(height:1, color: const Color(0x55ffaec1));
      }, 
    );
  }
}