import 'dart:typed_data';

import 'package:flutter/material.dart';

class Chat {
  final String name;
  final String message;
  final String image;
  final DateTime time;
  

  Chat({@required this.name, @required this.time, this.message, this.image});

  Chat.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        message = json['message'],
        image = json['image'],
        time = json['time'];

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'message': message,
      'image': image,
      'time': time,
    };
}