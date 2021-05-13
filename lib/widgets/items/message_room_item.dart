import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';

class MessageRoomItem extends StatelessWidget {
  const MessageRoomItem({
    Key key, 
    this.active = true,
    this.thumbnail, 
    this.name, 
    this.lastChat, 
    this.lastTime, 
    this.newCount,
    this.onPress,
    this.onLongPress
  }) : super(key: key);

  final bool active;
  final String thumbnail, name, lastChat, lastTime;
  final int newCount;
  final Function onPress, onLongPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? Skin.white : Skin.disabled,
      child: InkWell(
        onTap: onPress,
        onLongPress: onLongPress,
        child: Container(
          height: 120, 
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(     
              children: [
                active ? Images.asset(
                  context: context,
                  width: 88, height: 88,
                  path: thumbnail,
                  borderRadius: 44
                ) : Images.blackandwhite(
                  context: context,
                  width: 88, height: 88,
                  path: thumbnail,
                  borderRadius: 44
                ),
                const SizedBox(width: 16),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Texts.basic(
                      context: context,
                      text: name,
                      fontSize: 18.0,
                    ),
                    const SizedBox(height: 11),
                    Text(
                      active ? lastChat : tr("disconnected_message"),
                      style: TextStyle(color: Skin.bordergrey, fontSize: 13.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )),
                const SizedBox(width: 36),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    active ? Texts.primary(
                      context: context,
                      width: 48,
                      text: lastTime,
                      fontSize: 8.0,
                      textAlign: TextAlign.center
                    ) : Text(
                      lastTime,
                      style: TextStyle(
                        color: Skin.bordergrey,
                        fontWeight: FontWeight.w300,
                        fontSize: 8.0
                      ),
                      textAlign: TextAlign.center                
                    ),
                    Align(
                      alignment: Alignment.centerRight, 
                      child: active && (newCount > 0) ? Container(
                        alignment: Alignment.center,
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Skin.primary,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text(
                          newCount.toString(),
                          style: TextStyle(
                            color: Skin.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.0
                          ),             
                        )
                      ) : Container()
                    )
                  ],
                )
              ]
            )
          )
        )
      )
    );
  }
}