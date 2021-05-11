import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/widgets/components/add_chip_button.dart';
import 'package:eros/widgets/components/chips.dart';
import 'package:eros/widgets/components/text_fields.dart';
import 'package:eros/widgets/components/text_form_fields.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:eros/widgets/components/toasts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:eros/providers/auth.dart';
import 'package:eros/widgets/components/buttons.dart';

class ProfileTagSelectPage extends StatefulWidget {
  ProfileTagSelectPage({Key key, this.id, this.tags, this.finish}) : super(key: key);

  final String id;
  final List<String> tags;
  final Function finish;

  @override
  _ProfileTagSelectPageState createState() => _ProfileTagSelectPageState();
}

class _ProfileTagSelectPageState extends State<ProfileTagSelectPage> {
  List<String> tags;
  List<String> selectedTags = [];
  
  @override
  void initState() {
    super.initState();
    tags = widget.tags;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void inputTag(String tag) {
    if (tag.length > 0) {
      setState(() { tags = [tag, ...tags]; });
      selectTag(tag);
    }
  }

  void selectTag(String tag) {
    if (selectedTags.length >= 10) {
      Toasts.basicShow(context: context, text: tr("tag_select_limit"));
    } else {
      setState(() { selectedTags = [...selectedTags, tag]; });
    }
  }
  void removeTag(String value) {
    if (selectedTags.length == 0) {
      return;
    } else {
      selectedTags.remove(value);
    }
  }

  void nextPage() {
    // TODO: selectedTags 저장

    widget.finish();
  }

  Function submit (BuildContext context, Auth auth) {
    return () async {
      Navigator.pushNamed(context, '/home');
    };
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 32.0, right: 32.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 48),
            Texts.basic(
              context: context,
              height: 26,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              text: tr(widget.id),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Texts.secondary(
              context: context,
              height: 40,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              text: tr(widget.id+"_message"),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48),
            AddChipButton(buttonText: tr('input_in_person'), hintText: tr('tag'), onSubmit: inputTag),
            Chips.basic(
              tags: tags,
              selectedTags: selectedTags,
              spacing: 5,
              runSpacing: 6,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              onSelected: (tag, selected) {
                setState(() {
                  if (selected){
                    selectTag(tag);
                  } else {
                    removeTag(tag);
                  }
                });
              },
            ),
            SizedBox(height: 36),
            Material(
              child: Buttons.primary(
                text: tr("next"),
                active: selectedTags.length >= 3,
                onPressed: nextPage,
              )
            ),
          ],
        )
      )
    );
  }
}
