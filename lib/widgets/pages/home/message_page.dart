import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/components/dialogs.dart';
import 'package:eros/widgets/components/dividers.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:eros/widgets/items/message_room_item.dart';
import 'package:eros/widgets/pages/home/message_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_picker/flutter_picker.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  List<Map<String, dynamic>> roomList;

  final List<String> disconnectReasons = [
    tr('disconnect_reason_1'),
    tr('disconnect_reason_2'),
    tr('disconnect_reason_3'),
  ];
  String selectedReason = tr('disconnect_reason_2');

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

  void deleteChatRoom(int index) {
    setState((){ roomList = List.from(roomList)..removeAt(index); });
  }

  void disconnectChatRoom({@required BuildContext context, @required int index, Function onConfirm}) {
    showMaterialScrollPicker(
      context: context, 
      title: tr("disconnect"),
      headerTextColor: Skin.grey,
      headerColor: Skin.white,
      maxLongSide: 300,
      showDivider: false,
      items: disconnectReasons,
      selectedValue: selectedReason,
      buttonTextColor: Skin.primary,
      confirmText: tr('confirm'),
      cancelText: tr('cancel'),
      onChanged: (reason) => setState(() => selectedReason = reason),
      onConfirmed: () {
        log('Disconnect due to $selectedReason');
        setState((){ roomList[index]['connected'] = false; });
        onConfirm ??= (){};
        onConfirm();
      },
    );
  }

  Function onPressRoom(int index) {
    // TODO: 채팅방 화면으로 navigate
    return () { 
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MessageRoomPage(
            name: roomList[index]['name'],
            isConnected: roomList[index]['connected'],
            disconnect: (context, onConfirm) => disconnectChatRoom(context: context, index: index, onConfirm: onConfirm),
            delete: (context, onDelete) { deleteChatRoom(index); onDelete(); }
          )
        )
      ); 
    };
  }

  Function onLongPressRoom(int index) {
    List<Widget> contents = roomList[index]['connected'] ? [
      Container(
        alignment: Alignment.centerLeft,
        height: 30,
        child: Text(
          tr("disconnect"),
          style: TextStyle(color: Skin.black, fontSize: 20.0),            
        )
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 30,
        child: Text(
          tr("report"),
          style: TextStyle(color: Skin.lightgrey, fontSize: 20.0),            
        )
      )
    ] : [
      Container(
        alignment: Alignment.centerLeft,
        height: 30,
        child: Text(
          tr("delete"),
          style: TextStyle(color: Skin.black, fontSize: 20.0),            
        )
      )
    ];
    List<Function> events = roomList[index]['connected'] ? [
      () => disconnectChatRoom(context: context, index:index),
      () => log("Reported ${roomList[index]['name']}")
    ] : [ 
      () => deleteChatRoom(index)
    ];
    return () {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return Dialogs.option(
            context: context,
            length: contents.length,
            itemBuilder: (int index) => contents[index],
            onPressItem: (int index) => events[index](),
          );
        }
      );
    };
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
          Images.asset(
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
          onPress: onPressRoom(index),
          onLongPress: onLongPressRoom(index),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) {
        return Container(height:1, color: const Color(0x55ffaec1));
      }, 
    );
  }
}