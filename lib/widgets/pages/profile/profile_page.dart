import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/chips.dart';
import 'package:eros/widgets/components/dialogs.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/texts.dart';

// 프로필 화면 생성 시 (라우트 생성 시) 전달할 아규먼트 클래스
// TODO: API에 따라 달라질 예정
class ProfileArgument {
  final String userID;

  ProfileArgument(this.userID);
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key key,
  }) : super(key: key);
  final String myID = "abc";
  

  void showBlockDialog(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) {
        return Dialogs.confirm(
          context: context,
          title: tr('block_do'),
          content: tr('block_message'),
          cancelOnPressed: () => Navigator.of(context).pop(),
          confirmOnPressed: () => Navigator.of(context).pop()
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    // TODO: 유저 데이터 ID? 받아오기
    // final ProfileArgument arg = ModalRoute.of(context).settings.arguments;
    String userID = "abc2";
    bool liked = true, checked = false;
    String userName = "글자수는최대열자까지";
    int userAge = 27;
    String userLocation = "서울";
    double userHeight = 173;
    String userWork = "서비스 기획자";
    String userWeigth = "보통";
    String userReligion = "무교";
    String userSmoke;
    String userDrink;
    List<String> userCharmingPoint =  [
      "윙크를 잘해요",
      "배려심이 깊어요",
      "장난기가 많아요",
      "몸이 좋아요",
      "코가 오똑해요",
      "몸매가 좋아요",
    ];

    String buttonText;
    if (myID == userID) {
      buttonText = tr('profile_edit');
    } else {
      if (!liked) {
        buttonText = tr('like');
      } else {
        if (checked) {
          buttonText = tr('chatting');
        } else {
          buttonText = tr('checking_like');
        }
      } 
    }

    List<Widget> contents = [
      Container(
        alignment: Alignment.centerLeft,
        height: 30,
        child: Text(
          tr("block"),
          style: TextStyle(color: Skin.black, fontSize: 20.0),            
        )
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 30,
        child: Text(
          tr("report"),
          style: TextStyle(color: Skin.lightgrey, fontSize: 20.0),            
        )
      )
    ];
    List<Function> events = [
      () => showBlockDialog(context),
      () => log("Reported $userName")
    ];


    return Scaffolds.scroll(
      context: context,
      appBar: AppBars.basic(
        context: context,
        title: tr('profile'),
        actions: myID != userID ? [
          IconButton(
            icon: Icon(Icons.more_vert),
            color: Skin.grey, 
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return Dialogs.option(
                    context: context,
                    length: contents.length,
                    itemBuilder: (int index) => contents[index],
                    onPressItem: (int index) => events[index](),
                  );
                },
              );
            }
          )
        ] : []
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: buildButtonWithBadge(
          context: context, 
          text: buttonText,
          badge: buttonText == tr('like') ? buildBadge() : null,
        ),
      ),
      body: Column(
        children: [
          // TODO: 이미지 넘기는 거 디자인 미정?
          AspectRatio(
            aspectRatio: 1.0,
            child: Images.asset(
              context: context,
              width: double.infinity,
              path: 'assets/images/profile_test.png'
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.only(left: 32, right: 32),
            child: Column(
              children: [
                Texts.basic(
                  context: context,
                  height: 26,
                  text: "$userName  $userAge",
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 24.0, color: Skin.bordergrey,),
                    SizedBox(width: 4),
                    Text(
                      userLocation,
                      style: TextStyle(color: Skin.bordergrey, fontSize: 16.0)
                    ),
                    SizedBox(width: 12),
                    ImageIcon(AssetImage('assets/icons/height.png'), size: 24.0, color: Skin.bordergrey),
                    SizedBox(width: 4),
                    Text(
                      "$userHeight cm",
                      style: TextStyle(color: Skin.bordergrey, fontSize: 16.0)
                    )
                  ],
                ),
                _buildInfoTitle(context, tr('basic_info')),
                Padding(
                  padding: EdgeInsets.only(left: 6, right: 6),
                  child: Column(
                    children: [
                      _buildInfoPair(Icon(Icons.work, size: 24.0, color: Skin.primary), userWork),
                      SizedBox(height: 8),
                      _buildInfoPair(ImageIcon(AssetImage('assets/icons/weight.png'), size: 24.0, color: Skin.primary), userWeigth),
                      SizedBox(height: 8),
                      _buildInfoPair(Icon(Icons.perm_contact_cal, size: 24.0, color: Skin.primary), userReligion),
                      SizedBox(height: 8),
                      _buildInfoPair(Icon(Icons.smoking_rooms, size: 24.0, color: Skin.primary), userSmoke),
                      SizedBox(height: 8),
                      _buildInfoPair(Icon(Icons.liquor, size: 24.0, color: Skin.primary), userDrink),
                    ]
                  )
                ),
                _buildInfoTitle(context, tr('charming_point')),
                Chips.basic(
                  context: context,
                  tags: userCharmingPoint,
                  selectedTags: [],
                  onSelected: (String tag, bool selected) {}
                ),
                _buildInfoTitle(context, tr('ideal')),
                Chips.basic(
                  context: context,
                  tags: userCharmingPoint,
                  selectedTags: [],
                  onSelected: (String tag, bool selected) {}
                ),
                _buildInfoTitle(context, tr('hobbies')),
                Chips.basic(
                  context: context,
                  tags: userCharmingPoint,
                  selectedTags: [],
                  onSelected: (String tag, bool selected) {}
                ),
                _buildInfoTitle(context, tr('charming_index')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.filled(5, Container(width: 40, height: 40, color: Skin.primary))
                ),
                SizedBox(height: 28),
                // TODO: 여긴 뭐냐
                Text(
                  tr('tell_your_personality'),
                  style: TextStyle( color: Skin.bordergrey, fontSize: 14.0),
                ),
                SizedBox(height: 260)
              ]
            )
          )
        ]
      )
    );
  }

  Widget buildButtonWithBadge({BuildContext context, String text, @required Container badge, double buttonHeight=64.0, Function onPress}) {
    double badgeHeight = badge == null ? 0 : badge.constraints.maxHeight/2;
    return Container(
      height: buttonHeight+badgeHeight,
      child: Stack(
        children: [
          Positioned(right: badgeHeight, child: badge ?? Container()),
          Container(
            margin: EdgeInsets.only(top: badgeHeight),
            child: Buttons.primary(
              context: context,
              active: text != tr('checking_like'),
              text: text,
              onPressed: onPress ?? () {},
              fontSize: 20.0
            )
          )
        ],
      )
    );
  }

  Widget buildBadge() {
    return Container(
      width: 89,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
              color: Skin.shadow,
              offset: Offset(0,3),
              blurRadius: 6,
              spreadRadius: 0
          )
        ],
        color: Skin.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/icons/token.png'), width: 18),
          SizedBox(width: 4),
          Text(
            "20",
            style: const TextStyle(
                color: const Color(0xffd18c28),
                fontWeight: FontWeight.w700,
                fontSize: 12.0
            ),
            textAlign: TextAlign.center                
          ),
          SizedBox(width: 8),
          Text(
            "소요",
            style: const TextStyle(color: const Color(0xff9a9297), fontSize: 12.0),
            textAlign: TextAlign.left                
          )
        ],
      )
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

  Widget _buildInfoPair(Widget icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        SizedBox(width: 12),
        Text(
          text ?? '-',
          style: TextStyle(color: Skin.black, fontSize: 14.0),
          textAlign: TextAlign.center,
        ),
      ]
    );
  }
}
