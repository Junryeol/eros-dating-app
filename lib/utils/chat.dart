class Chat {
  final String name;
  final String message;
  final DateTime time;


  Chat(this.name, this.message, this.time);

  Chat.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        message = json['message'],
        time = json['time'];

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'message': message,
      'time': time,
    };
}