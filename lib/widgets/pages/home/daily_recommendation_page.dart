import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:flutter/material.dart';

class DailyRecommendatonPage extends StatefulWidget {
  DailyRecommendatonPage({Key key}) : super(key: key);

  @override
  _DailyRecommendatonPageState createState() => _DailyRecommendatonPageState();
}

class _DailyRecommendatonPageState extends State<DailyRecommendatonPage> {

  List<List<String>> imagePaths;
  List<String> dates;
  String time;

  @override
  void initState() {
    super.initState();
    imagePaths = List.filled(2, []..length=6);
    dates = List.generate(2, (index) => "2021/02/${21-index} (일)");
    time = "23:59:59";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: ListView.separated(
        itemCount: imagePaths.toList().length,
        itemBuilder: (BuildContext context, int index) {
          return buildRecommendation(date: dates[index], images: imagePaths[index]);
        }, 
        separatorBuilder: (BuildContext context, int index) {
          return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return Images.asset(
              context: context,
              width: constraints.maxWidth,
              height: constraints.maxWidth*11/35,
              path: 'assets/images/pick.png',
            );
          });
        }
      ),
    );
  }

  Widget buildRecommendation({@required String date, @required List<String> images}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36.0),
      child:  Column(
        children: [
          Row(
            children: [
              buildDateWidget(date),
              // TODO: date가 오늘이면 보여줌
              Expanded(child: Container(
                alignment: Alignment.centerRight, 
                child: Text(
                  "${tr("until_next_introduction")} $time",
                  style: TextStyle(color: Skin.bordergrey, fontSize: 12.0),
                )
              ))
            ],
          ),
          SizedBox(height: 12),
          buildImageSet(images),
          SizedBox(height: 24),
          buildButtonWithBadge(badge: buildBadge()),
        ]
      )
    );
  }

  Widget buildDateWidget(String date, { double width=130, double height=28, double borderWidth=1.2, double fontSize=12.0 }) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(height/2)),
        border: Border.all(color: Skin.secondary, width: borderWidth),
      ),
      child: Text(
        date,
        style: TextStyle(
            color: Skin.secondary,
            fontWeight: FontWeight.w700,
            fontSize: fontSize
        ),
        textAlign: TextAlign.center                
      )
    );
  }

  Widget buildImageSet(List<String> images) {
    return LayoutBuilder(builder: (BuildContext _context, BoxConstraints _constraints) {
      double width = _constraints.maxWidth;
      return Column(
        children: [
          buildImageWithProfile(width: width, height: width, imagePath: images[0]),
          SizedBox(height: 24),
          buildImageWithProfile(width: width, height: width, imagePath: images[1]),
          SizedBox(height: 24),
          Container(child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 24.0,
            crossAxisSpacing: 24.0,
            crossAxisCount: 2,
            shrinkWrap: true,
            children: images.sublist(2).map((e) => buildImageWithProfile(
              imagePath: e, 
              size: 12.0
            )).toList(),
          ))
        ]
      );
    });
  }

  Widget buildImageWithProfile({
    double width, 
    double height, 
    String imagePath, 
    String profileName="이름은최대열글자까지",
    String profileLocation="서울",
    double profileHeight=173.0,
    double size=22.0
    }) {
    return Images.asset(
      context: context,
      width: width, height: width,
      path: imagePath,
      borderRadius: 15.0,
      widget: Stack(
        children: [
          Positioned(
            left: size*0.75, bottom: size*0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileName,
                  style: TextStyle(
                    color: Skin.white,
                    fontWeight: FontWeight.w700,
                    fontSize: size
                  ),
                ),
                SizedBox(height: size/3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: size, color: Skin.primary),
                    SizedBox(width: size/8),
                    Text(
                      profileLocation,
                      style: TextStyle(color: Skin.white, fontSize: size*0.7)
                    ),
                    SizedBox(width: size/2),
                    ImageIcon(AssetImage('assets/icons/height.png'), size: size, color: Skin.primary),
                    SizedBox(width: size/8),
                    Text(
                      "${profileHeight.floor()} cm",
                      style: TextStyle(color: Skin.white, fontSize: size*0.7)
                    )
                  ],
                )
              ]
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

  Widget buildButtonWithBadge({@required Container badge, double buttonHeight=64.0, Function onPress}) {
    double badgeHeight = badge.constraints.maxHeight/2;
    return Container(
      height: buttonHeight+badgeHeight,
      child: Stack(
        children: [
          Positioned(right: badgeHeight, child: badge),
          Container(
            margin: EdgeInsets.only(top: badgeHeight),
            child: Buttons.primary(
              context: context,
              text: tr("introduced_immediately"),
              onPressed: onPress ?? () {},
              fontSize: 20.0
            )
          )
        ],
      )
    );
  }
}