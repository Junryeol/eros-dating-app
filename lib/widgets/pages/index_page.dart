import 'package:eros/configs/route.dart';
import 'package:flutter/material.dart';

import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/buttons.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> route = RoutePath.routes(context);

    List<Widget> widgets = [SizedBox(height: 40)];
    route.forEach((k,v) =>
      widgets.add(Container(
        width: double.infinity,
        child: Buttons.transparency(
          text: k,
          onPressed: () {
            Navigator.pushNamed(context, k);
          },
        ),
      ))
    );

    return Scaffolds.scroll(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }
}
