import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';

class RequestManagePage extends StatefulWidget {
  RequestManagePage({Key key}) : super(key: key);

  @override
  _RequestManagePageState createState() => _RequestManagePageState();
}

class _RequestManagePageState extends State<RequestManagePage> {

  bool isReceived;
  List<Map<String, dynamic>> requestsSent, requestsReceived;

  @override
  void initState() { 
    super.initState();
    isReceived = true;
    requestsSent = List.generate(10, (index) => {
      'image': null, 
      'name': '이름이길면여기까지', 
      'location': '서울',
      'age': 27,
      'checked': index < 3
    });
    requestsReceived = List.generate(8, (index) => {
      'image': null, 
      'name': '이름이길면여기까지', 
      'location': '서울',
      'age': 27,
      'checked': index < 3
    });
  }

  @override
  Widget build(BuildContext context) {
    var requests = isReceived ? requestsReceived : requestsSent;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          const SizedBox(height: 12),
          buildSelection(),
          const SizedBox(height: 12),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                Texts.basic(
                  context: context,
                  height: 18,
                  text: tr('request_before'),
                  fontSize: 16.0,
                  textAlign: TextAlign.left
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1.5,
                  color: Skin.lightgrey
                ),
                const SizedBox(height: 24),
                buildRequestSet(requests.where((element) => !element['checked']).toList()),
                const SizedBox(height: 36),
                Texts.basic(
                  context: context,
                  height: 18,
                  text: tr('request_after'),
                  fontSize: 16.0,
                  textAlign: TextAlign.left
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1.5,
                  color: Skin.lightgrey
                ),
                const SizedBox(height: 24),
                buildRequestSet(requests.where((element) => element['checked']).toList()),
              ],
            )
          ))
        ],
      )
    );
  }

  Widget buildSelection() {
    return Row(
      children: [
        Flexible(child:Buttons.onoff(
          context: context,
          text: tr('request_received'),
          selected: isReceived,
          onPressed: () => setState((){isReceived=true;})
        )),
        SizedBox(width: 12),
        Flexible(child:Buttons.onoff(
          context: context,
          text: tr('request_sent'),
          selected: !isReceived,
          onPressed: () => setState((){isReceived=false;})
        )),
      ]
    );
  }

  Widget buildRequestSet(List<Map<String, dynamic>> requests) {
    return requests.length == 0 ? Container(
      child: Text('없엉')
    ) : LayoutBuilder(builder: (context, constraints) {
      var width = (constraints.maxWidth - 30) / 3;
      var height = width + 44;
      return GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 24,
        childAspectRatio: width/height,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: requests.map((e) => buildRequestForm(e, size: width)).toList(),
      );
    });
  }

  Widget buildRequestForm(Map<String, dynamic> request, {double size = double.infinity}) {
    return Column(
      children: [
        Images.asset(
          context: context,
          width: size, height: size,
          borderRadius: 8,
          path: request['image']
        ),
        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size/13),
          child: Text(
            request['name'],
            style: TextStyle(
              color: Skin.grey,
              fontSize: 13,
              height: 16/14,
              letterSpacing: 0.28
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ),
        const SizedBox(height: 4),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size/13),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: size/7, color: Skin.primary),
              SizedBox(width: size/50),
              Text(
                request['location'],
                style: TextStyle(color: Skin.bordergrey, fontSize: size/9),
              ),
              SizedBox(width: size/12),
              Icon(Icons.cake, size: size/7, color: Skin.primary),
              SizedBox(width: size/50),
              Text(
                '${request['age']}세',
                style: TextStyle(color: Skin.bordergrey, fontSize: size/9)
              )
            ]
          )
        )
      ]
    );
  }
}