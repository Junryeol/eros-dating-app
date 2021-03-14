import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/chips.dart';
import 'package:eros/widgets/components/linear_progresses.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eros/providers/auth.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';

class ProfileTagSelectPage extends StatefulWidget {
  ProfileTagSelectPage({Key key}) : super(key: key);

  @override
  _ProfileTagSelectPageState createState() => _ProfileTagSelectPageState();
}

class _ProfileTagSelectPageState extends State<ProfileTagSelectPage> {
  List<String> tags = [
    "love",
    "instagood",
    "photooftheday",
    "beautiful",
    "fashion",
    "happy",
    "tbt",
    "cute",
    "followme",
    "like4like",
    "follow",
    "picoftheday",
    "me",
    "selfie",
    "summer",
    "instadaily"
  ];

  TextEditingController tagController = TextEditingController();

  List<String> selectedTags = [];
  bool inputActive = false;

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);

    var appBarTitle = tr("profile_registration");
    var nextButtonText = tr("next");
    var addButtonText = tr("add");
    var addTagHintText = tr("tag");
    var margin = const EdgeInsets.only(left: 40.0, right: 40.0);

    return Scaffolds.scroll(
        appBar: AppBars.basic(
          context: context,
          title: appBarTitle,
        ),
        body: Column(
          children: <Widget>[
            LinearProgresses.basic(value: 0.5),
            inputActive ? Container(
              margin: margin,
              child: TextFields.basic(
                keyboardType: TextInputType.text,
                controller: tagController,
                hintText: addTagHintText,
                onSubmitted: (value) {
                  tags.add(value);
                  selectedTags.add(value);
                  setState(() {
                    inputActive = false;
                  });
                },
              ),
            ) : Container(
              margin: margin,
              child: Buttons.primary(
                text: addButtonText,
                onPressed: () {
                  tagController.clear();
                  setState(() {
                    inputActive = true;
                  });
                },
              ),
            ),
            Container(
              margin: margin,
              child: Chips.basic(
                tags: tags,
                selectedTags: selectedTags,
                onSelected: (tag, selected) {
                  setState(() {
                    if (selected){
                      selectedTags.add(tag);
                    } else {
                      selectedTags.remove(tag);
                    }
                  });
                },
              ),
            ),
            Container(
              margin: margin,
              child: Buttons.primary(
                text: nextButtonText,
                onPressed: submit(context, auth),
              ),
            ),
          ],
        )
    );
  }

  Function submit (BuildContext context, Auth auth) {
    return () async {
      Navigator.pushNamed(context, '/home');
    };
  }
}
