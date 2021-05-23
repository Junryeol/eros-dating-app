import 'package:eros/utils/string.dart';
import 'package:flutter/material.dart';

class AppBars {
  static basic({BuildContext context, String title, List<Widget> actions, double fontSize = 14.0}){
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.keyboard_arrow_left, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      toolbarHeight: 48,
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Color(0xff706569), fontSize: fontSize),),
      backgroundColor: Colors.white,
      actions: actions,
    );
  }

  static popup({BuildContext context, String title, double fontSize = 14.0}){
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      toolbarHeight: 48,
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Color(0xff706569), fontSize: fontSize),),
      backgroundColor: Colors.white,
    );
  }

  static home({BuildContext context, String title, int token}) {
    return AppBar(
      leading: IconButton(
        icon: Container(
          width: 24, height: 24,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/profile_test.png'),
              fit: BoxFit.fill
            ),
            borderRadius: BorderRadius.all(Radius.circular(12.0))
          ),
        ),
        onPressed: () => Navigator.of(context).pushNamed('/profile'),
      ),
      toolbarHeight: 48,
      centerTitle: true,
      title: Text(
        title, 
        style: const TextStyle(
          color: Color(0xff706569), 
          fontSize: 16.0, 
          letterSpacing: 1.28
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        GestureDetector(
          child: Row(
            children: [
              Image.asset('assets/icons/token.png', width: 20, height: 20,),
              const SizedBox(width: 6,),
              Text(
                numberToStringWithComma(token), 
                style: const TextStyle(
                  color: Color(0xff706569),
                  fontSize: 12.0
                ),
              ),
              const SizedBox(width: 16.0)
            ],
          )
        )
      ],
    );
  }
}