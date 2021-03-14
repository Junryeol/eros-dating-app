import 'package:flutter/material.dart';
import 'package:eros/widgets/components/app_bars.dart';

class PopupPage extends StatefulWidget {
  final String title;
  final Widget page;

  PopupPage({Key key, this.title, this.page}) : super(key: key);

  @override
  _PopupPageState createState() => _PopupPageState();
}

class _PopupPageState extends State<PopupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.popup(context: context, title: widget.title),
      body: widget.page,
    );
  }
}
