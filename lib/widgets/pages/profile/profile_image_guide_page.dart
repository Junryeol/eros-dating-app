import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:eros/widgets/components/Images.dart';
import 'package:eros/widgets/components/app_bars.dart';
import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/texts.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ProfileImageGuidePage extends StatelessWidget {
  
  Size _getTextSize(String text, {FontWeight fontWeight=FontWeight.w500, double fontSize=14.0}) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: text, 
          style: TextStyle(
            color:  Color(0xff706569),
            fontWeight: fontWeight,
            fontSize: fontSize,
          )
        ), 
        maxLines: 1,
        textDirection: ui.TextDirection.ltr
      )
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  Widget underlinedText(BuildContext context, String text) {
    return Container(
      height: 18,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: _getTextSize(text, fontSize: 16.0).width+24,
              height: 9,
              decoration: BoxDecoration(
                color: const Color(0xffffeeee)
              ),
            )
          ),
          Texts.basic(
            context: context,
            height: 18,
            text: text,
            fontSize: 16,
            textAlign: TextAlign.center
          )
        ],
      )
    );
  }

  Widget imageWithMessage(BuildContext context, String id, {width=100}) {
    return Column(
      children: [
        Images.asset(
            context: context,
            width: width, height: width,
            borderRadius: 10.0,
            path: 'assets/images/error.png'
         ),
        SizedBox(height: 12),
        Text(
          tr(id),
          style: TextStyle(
            color: Skin.bordergrey,
            fontWeight: FontWeight.w500,
            fontSize: 12.0
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = 52.0;
    double marginBetween = 36.0;
    double imageWidth = (MediaQuery.of(context).size.width-(paddingHorizontal*2+marginBetween))/2;
    return Scaffolds.scroll(
      context: context,
      appBar: AppBars.popup(
        context: context,
        title: tr("guide")
      ),
      body: Padding(
        padding: EdgeInsets.only(left: paddingHorizontal, right: paddingHorizontal),
        child: Column(
          children: [
            SizedBox(height: 48),
            Texts.basic(
              context: context,
              height: 26,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              text: tr("profile_image_accept_standard"),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Texts.secondary(
              context: context,
              height: 88,
              fontSize: 13,
              fontWeight: FontWeight.w300,
              text: tr("profile_image_accept_standard_message"),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 48),
            underlinedText(context, tr('suitable_image')),
            SizedBox(height: 24),
            Row(
              children: [
                imageWithMessage(context, "suitable_image_guide_1", width: imageWidth),
                SizedBox(width: marginBetween),
                imageWithMessage(context, "suitable_image_guide_2", width: imageWidth),
              ],
            ),
            SizedBox(height: 48),
            underlinedText(context, tr('unsuitable_image')),
            SizedBox(height: 24),
            Row(
              children: [
                imageWithMessage(context, "unsuitable_image_guide_1", width: imageWidth),
                SizedBox(width: marginBetween),
                imageWithMessage(context, "unsuitable_image_guide_2", width: imageWidth),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                imageWithMessage(context, "unsuitable_image_guide_3", width: imageWidth),
                SizedBox(width: marginBetween),
                imageWithMessage(context, "unsuitable_image_guide_4", width: imageWidth),
              ],
            ),
            SizedBox(height: 48)
          ],
        )    
      )
    );
  }
}