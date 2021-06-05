import 'dart:convert';

import 'package:eros/configs/skin.dart';
import 'package:eros/models/chat.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key key, this.isMine = true, @required this.chatData }) : super(key: key);

  final bool isMine;
  final Chat chatData;

  @override
  Widget build(BuildContext context) {
    return isMine ? 
      buildRightBubble(context: context, text: chatData.message, image: chatData.image)
      : buildLeftBubble(context: context, text: chatData.message, image: chatData.image, profile: 'assets/images/profile_test.png');
  }

  Widget buildLeftBubble({BuildContext context, String text, String image, String profile}) {
    var rad = Radius.circular(16);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          child: Images.asset(
            width: 30, height: 30,
            borderRadius: 15,
            path: profile
          ),
          onTap: () => Navigator.of(context).pushNamed('/profile'),
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

  Widget buildRightBubble({BuildContext context, String text, String image}) {
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
}


