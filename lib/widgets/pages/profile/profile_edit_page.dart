import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/components/add_chip_button.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/chips.dart';
import 'package:eros/widgets/components/pickers.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/text_fields.dart';
import 'package:eros/widgets/components/text_form_fields.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:eros/widgets/components/toasts.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({Key key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {

  TextEditingController introductionController;
  String userIntroduction = '';
  TextEditingController tagController;
  bool inputActive = false;

  String userName = "글자수는최대열자까지";
  int userAge = 27;
  String userLocation = "서울";
  double userHeight = 173;
  String userWork = "서비스 기획자";
  String userWeigth = "보통";
  String userReligion = "무교";
  String userSmoke = "흡연";
  String userDrink = "자주 마심";
  List<String> userCharmingPoint =  [
    "윙크를 잘해요",
    "배려심이 깊어요",
    "장난기가 많아요",
    "몸이 좋아요",
    "코가 오똑해요",
    "몸매가 좋아요",
  ];
  List<String> selectedTags = [];

  List<String> imageList = ['assets/images/profile_test.png']..length = 6;

  Map<String, String> pickerText = {
    'gender': tr('female'),
    'job': tr('job_hint'),
    'birth': tr('date_of_birth_hint'),
    'height': tr('height_hint'),
    'body': tr('body_hint'),
    'residence': tr('residence_hint'),
    'religion': tr('religion_hint'),
    'smoking': tr('smoking_hint'),
    'drinking': tr('drinking_hint'),
  };

  @override
  void initState() { 
    super.initState();
    introductionController = TextEditingController()
      ..addListener(() { setState(() { userIntroduction = introductionController.text; });});
    tagController = TextEditingController();
  }

  @override
  void dispose() {
    introductionController.dispose();
    tagController.dispose();
    super.dispose();
  }

  void onImageTap(int idx) {
    setState(() {
      if (idx == imageList.length) {
        imageList.add('image');
      } else if (idx < imageList.length) {
        imageList[idx] = 'image';
      }
    });
  }

  void inputTag(String tag) {
    if (tag.length > 0) {
      setState(() { userCharmingPoint = [tag, ...userCharmingPoint]; });
      selectTag(tag);
    }
    setState(() {
      inputActive = false;
    });
  }
  void selectTag(String tag) {
    if (selectedTags.length >= 10) {
      Toasts.basicShow(context: context, text: tr("tag_select_limit"));
    } else {
      setState(() { selectedTags = [...selectedTags, tag]; });
    }
  }

  @override
  Widget build(BuildContext context) {
    var jobList = ["하나","둘","셋"];

    return Scaffolds.scroll(
      context: context,
      appBar: AppBars.basic(
        context: context,
        title: tr('profile_edit'),
        fontSize: 12.0,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(tr('complete'), style: TextStyle(color: Skin.grey, fontSize: 16.0))
          )
        ]
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: [
            SizedBox(height: 36),
            buildImageSet(imageList),
            SizedBox(height: 24),
            Texts.secondary(
              context: context,
              height: 16,
              text: tr('image_order_tip'),
              textAlign: TextAlign.center
            ),
            SizedBox(height: 12),
            guideButton(),
            _buildInfoTitle(context, tr('basic_info')),
            Pickers.basic(
              context: context,
              labelText: tr("gender"),
              hintText: pickerText['gender'],
              icon: Icon(Icons.work),
              pickerdata:jobList,
              onConfirm:(List<String> values) {  } 
            ),
            SizedBox(height: 12),
            Pickers.date(
              context: context,
              labelText: tr("date_of_birth"),
              hintText: pickerText['birth'],
              icon: Icon(Icons.cake),
              onConfirm:(DateTime value) {}
            ),
            SizedBox(height: 12),
            Pickers.date(
              context: context,
              labelText: tr("nick_name"),
              hintText: userName,
              icon: Icon(Icons.cake),
              onConfirm:(DateTime value) {}
            ),
            SizedBox(height: 12),
            Pickers.basic(
              context: context,
              labelText: tr("job"),
              hintText: pickerText['job'],
              icon: Icon(Icons.work),
              pickerdata:jobList,
              onConfirm:(List<String> values) {  } 
            ),
            SizedBox(height: 12),
            Pickers.number(
              context: context,
              labelText: tr("height"),
              hintText: pickerText['height'],
              // TODO: Icon 대신 AssetImage가 들어갈 수 있도록
              icon: Icon(Icons.height),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            SizedBox(height: 12),
            Pickers.number(
              context: context,
              labelText: tr("body"),
              hintText: pickerText['body'],
              // TODO: Icon 대신 AssetImage가 들어갈 수 있도록
              icon: Icon(Icons.height),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            SizedBox(height: 12),
            Pickers.number(
              context: context,
              labelText: tr("residence"),
              hintText: pickerText['residence'],
              icon: Icon(Icons.location_on),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            SizedBox(height: 12),
            Pickers.number(
              context: context,
              labelText: tr("religion"),
              hintText: pickerText['religion'],
              icon: Icon(Icons.perm_contact_cal),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            SizedBox(height: 12),
            Pickers.number(
              context: context,
              labelText: tr("smoking"),
              hintText: pickerText['smoking'],
              icon: Icon(Icons.smoking_rooms),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            SizedBox(height: 12),
            Pickers.number(
              context: context,
              labelText: tr("drinking"),
              hintText: pickerText['drinking'],
              icon: Icon(Icons.liquor),
              onConfirm:(List<int> values) {},
              begin: 140,
              end: 210,
              jump: 1,
            ),
            _buildInfoTitle(context, tr('introduction_content')),
            TextFields.basic(
              context: context,
              controller: introductionController,
              hintText: tr('introduction_content_hint')
            ),
            SizedBox(height: 12),
            Texts.secondary(
              context: context,
              text: "${userIntroduction.length.toString()}/100",
              textAlign: TextAlign.end
            ),
            _buildInfoTitle(context, tr('personality')),
            _buildInfoTitle(context, tr('dating_style')),
            _buildInfoTitle(context, tr('charming_point')),
            Chips.basic(
              context: context,
              tags: userCharmingPoint,
              selectedTags: [],
              onSelected: (String tag, bool selected) {}
            ),
            AddChipButton(buttonText: tr('add'), hintText: tr('tag'), onSubmit: inputTag),
            _buildInfoTitle(context, tr('ideal')),
            Chips.basic(
              context: context,
              tags: userCharmingPoint,
              selectedTags: [],
              onSelected: (String tag, bool selected) {}
            ),
            AddChipButton(buttonText: tr('add'), hintText: tr('tag'), onSubmit: inputTag),
            _buildInfoTitle(context, tr('hobbies')),
            Chips.basic(
              context: context,
              tags: userCharmingPoint,
              selectedTags: [],
              onSelected: (String tag, bool selected) {}
            ),
            AddChipButton(buttonText: tr('add'), hintText: tr('tag'), onSubmit: inputTag),
            SizedBox(height: 260)
          ]
        )
      )
    );
  }

  Widget imageForUpload({
      int index=0,
      double width=228.0, 
      double height=228.0, 
      double borderRadius=10.0, 
      String path,
      bool active=true
    }) {
    return Images.basic(
      context: context,
      width: width, height: height,
      path: path,
      borderRadius: borderRadius,
      border: path == null && active ? Border.all(
        color: Skin.bordergrey,
        width: 1,
      ) : null,
      widget: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: width*0.1+16, height: 20,
            decoration: BoxDecoration(
              color: Skin.bordergrey,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))
            ),
            child: Center(
              child: Text(
                index == 0 ? tr('represent') : (index+1).toString(),
                style: TextStyle(
                  color: Skin.white,
                  fontSize: 10,
                  fontWeight: FontWeight.normal
                )
              )
            ),
          ),
          active ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => onImageTap(index),
            child: Container()
          ) : Container(color: Skin.disabled),
        ],
      ),
    );
  }

  Widget buildImageSet(List<String> images) {
    return LayoutBuilder(builder: (BuildContext b_context, BoxConstraints b_constraints) {
      double width = b_constraints.maxWidth;
      double marginWidth = 15.0;
      double widthMain = width*2/3-marginWidth/2;
      double widthSub = widthMain/2-marginWidth/2;
      return Column(
        children: [
          Row(
            children: [
              imageForUpload(index: 0, width: widthMain,height: widthMain, path: images[0]),
              SizedBox(width: marginWidth),
              Column(
                children: [
                  imageForUpload(index: 1, width: widthSub, height: widthSub, path: images[1], active: images[0] != null),
                  SizedBox(height: marginWidth),
                  imageForUpload(index: 2, width: widthSub, height: widthSub, path: images[2], active: images[1] != null),
                ]
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              imageForUpload(index: 3, width: widthSub, height: widthSub, path: images[3], active: images[2] != null),
              SizedBox(width: marginWidth),
              imageForUpload(index: 4, width: widthSub, height: widthSub, path: images[4], active: images[3] != null),
              SizedBox(width: marginWidth),
              imageForUpload(index: 5, width: widthSub, height: widthSub, path: images[5], active: images[4] != null),
            ]
          )
        ]
      );
    });
  }

  Widget guideButton() {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed('/image_guide'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(6) 
              ),
              color: Skin.bordergrey,
            ),
            alignment: Alignment.center,
            child: Text(
              "?",
              style: TextStyle(
                color: Color(0xffffffff),
                fontWeight: FontWeight.bold,
                fontSize: 8.0
              ),            
            ),
          ),
          SizedBox(width: 6),
          Text(
            tr("image_accept_standard"),
            style: TextStyle(
              color: Skin.bordergrey,
              fontSize: 10.0
            ),       
          )
        ],
      ),
    );
  }

  Widget _buildInfoTitle(BuildContext context, String title) {
    return Column(
      children: [
        SizedBox(height: 48),
        Texts.basic(
          context: context,
          height: 18,
          text: title,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center
        ),
        SizedBox(height: 8),
        Container(
          height: 1.5,
          color: Skin.lightgrey
        ),
        SizedBox(height: 24)
      ],
    );
  }
}