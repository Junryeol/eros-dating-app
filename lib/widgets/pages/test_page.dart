import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/custom/spider_chart.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
        Container(
          width: 200,
          height: 200,
          child: SpiderChart(
              data: [[
                7,
                5,
                10,
                7,
                4,
                7,
                5,
                10,
                7,
                4,
              ],[
                7,
                5,
                10,
                10,
                7,
                7,
                7,
                5,
                4,
                4,
              ]],
              maxValue: 10,
              colors: <Color>[
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.indigo,
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.indigo,
              ],
              labels: <String>[
                "label 1",
                "label 2",
                "label 3",
                "label 4",
                "label 5",
                "label 6",
                "label 7",
                "label 8",
                "label 9",
                "label 10",
              ]),
        ),
          ],
        )
      ),
    );
  }
}
