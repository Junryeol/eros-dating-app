import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';

class MessageRoomPage extends StatefulWidget {
  MessageRoomPage({Key key, this.name, this.disconnect}) : super(key: key);

  final String name;
  final Function disconnect;

  @override
  _MessageRoomPageState createState() => _MessageRoomPageState();
}

class _MessageRoomPageState extends State<MessageRoomPage> {
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
      body: Center(
        child: Texts.basic(context: context, text: "채팅방", textAlign: TextAlign.center)
      ),
    );
  }
}