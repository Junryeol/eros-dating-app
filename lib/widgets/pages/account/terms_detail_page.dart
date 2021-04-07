import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/checkboxs.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eros/providers/auth.dart';

// Navigator를 통해 arguments를 받기 위함
class TermsDetailArguments {
  final String apiId;

  TermsDetailArguments(this.apiId);
}

class TermsDetailPage extends StatelessWidget {
  // TODO: 전달받은 id로 api 호출해 html을 render
  Future<String> downloadHtml(String id) async {
    log("API_ID in TermsDetailPage: " + id);
    // String API_URL = "blahblah"+id;
    // var response =  await http.get(API_URL);    
    return Future.value("[${id}] Data download successfully"); // return your response
  } 

  @override
  Widget build(BuildContext context) {
    final TermsDetailArguments args = ModalRoute.of(context).settings.arguments as TermsDetailArguments;

    return Scaffolds.scroll(
      appBar: AppBars.basic(
        context: context,
        title: tr("terms")
      ),
      body: Center(
        // child: Texts.basic(
        //   context: context,
        //   text: "HTML을 render할 예정"
        // ),
        child: FutureBuilder(
          future: downloadHtml(args.apiId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return Text('Loading....');
              default:
                if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                else
                return Text('Result: ${snapshot.data}');
            }
          } 
        ),
      )
    );
  }
}
