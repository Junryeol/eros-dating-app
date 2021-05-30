import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:eros/configs/skin.dart';
import 'package:flutter/material.dart';

import 'package:image_crop/image_crop.dart';

import 'package:eros/widgets/components/scaffolds.dart';
import 'package:eros/widgets/components/buttons.dart';
import 'package:image_picker/image_picker.dart';

class ImageCropPage extends StatefulWidget {
  ImageCropPage({Key key, @required this.file}) : super(key: key);

  final File file;

  @override
  _ImageCropPageState createState() => _ImageCropPageState();
}

class _ImageCropPageState extends State<ImageCropPage> {
  final cropKey = GlobalKey<CropState>();
  File _file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _file = widget.file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 1.0, 
                    child: Crop.file(_file, key: cropKey, aspectRatio: 1.0)
                  ),
                  const SizedBox(height: 20),
                  // MiniMap
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.file(widget.file, width: 100),
                      Icon(Icons.arrow_right, color: Skin.white, size: 40,),
                      Image.file(_file, width: 100),
                    ],
                  )
                ],
              )
            ),
          ),
          Positioned(
            left:0, right: 0, bottom: 0,
            child: Row(
                children: <Widget>[
                  const SizedBox(width: 50),
                  Flexible(child: InkWell(
                    child: Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: const Text(
                        '자르기',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      )
                    ),
                    onTap: () => _cropImage(),
                  )),
                  const SizedBox(width: 50),
                  Flexible(child:InkWell(
                    child: Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: Text(
                        tr('complete'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      )
                    ),
                    onTap: () => Navigator.pop(context, _file),
                  )),
                  const SizedBox(width: 50),
                ],
              ),
          )
          
        ]
      ),
    );
  }


  Future<void> _cropImage() async {
    final file = await ImageCrop.cropImage(file: _file, area: cropKey.currentState.area);
    setState(() {
      _file = file;
    });
  }
}
