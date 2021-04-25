import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';

class UploadProfileImagePage extends StatefulWidget {
  UploadProfileImagePage({Key key, this.finish}) : super(key: key);

  final Function finish;

  @override
  _UploadProfileImagePageState createState() => _UploadProfileImagePageState();
}

class _UploadProfileImagePageState extends State<UploadProfileImagePage> {
  
  List<String> _imageList = [];

  void nextPage() {
    // TODO: 프로필 사진 승인 요청
    
    widget.finish();
  }


  Widget guideButton() {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed('/image_guide'),
      child: Container(
        width: 98,
        height: 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(3) 
          ),
          border: Border.all(
            color: Skin.bordergrey,
            width: 1
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(192) 
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
      ),
    );
  }

  void onImageTap(int idx) {
    log("Image [$idx] tapped!");
    setState(() {
      if (idx == _imageList.length) {
        _imageList.add('image');
      } else if (idx < _imageList.length) {
        _imageList[idx] = 'image';
      }
    });
  }

  Widget imageForUpload({
      int index=0,
      double width=228.0, 
      double height=228.0, 
      double borderRadius=10.0, 
      bool active=true
    }) {
    return Images.basic(
      context: context,
      width: width, height: height,
      borderRadius: borderRadius,
      border: active ? Border.all(
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
                index == 0 ? tr('represent') : index.toString(),
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
              imageForUpload(index: 0, width: widthMain,height: widthMain),
              SizedBox(width: marginWidth),
              Column(
                children: [
                  imageForUpload(index: 1, width: widthSub, height: widthSub, active: images.length>0),
                  SizedBox(height: marginWidth),
                  imageForUpload(index: 2, width: widthSub, height: widthSub, active: images.length>1),
                ]
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              imageForUpload(index: 3, width: widthSub, height: widthSub, active: images.length>2),
              SizedBox(width: marginWidth),
              imageForUpload(index: 4, width: widthSub, height: widthSub, active: images.length>3),
              SizedBox(width: marginWidth),
              imageForUpload(index: 5, width: widthSub, height: widthSub, active: images.length>4),
            ]
          )
        ]
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    log(_imageList.toString());
    return Padding(
      padding: EdgeInsets.only(left: 32, right: 32),
      child: Column(
        children: [
          SizedBox(height: 48),
            Texts.basic(
              context: context,
              height: 26,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              text: tr("upload_profile_image"),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Texts.secondary(
              context: context,
              height: 16,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              text: tr("upload_profile_image_message"),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            guideButton(),
            SizedBox(height: 48),
            buildImageSet(_imageList),
            SizedBox(height: 36),
            Buttons.primary(
              context: context,
              text: tr('profile_image_request'),
              fontSize: 20,
              active: _imageList.length > 0,
              onPressed: nextPage
            )
        ],
      )
    );
  }
}