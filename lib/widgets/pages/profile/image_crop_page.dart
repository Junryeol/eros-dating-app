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
              child: _buildCroppingImage(),
            ),
            Positioned(
              right: 30, top: 30,
              child: TextButton(
                child: Text(
                  tr('complete'),
                  style: TextStyle(
                    color: Skin.white,
                    fontSize: 18
                  ),
                ),
                onPressed: () => Navigator.pop(context, _file),
              )
            )
          ]),
    );
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_file, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                child: const Text(
                  'Crop Image',
                ),
                onPressed: () => _cropImage(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _cropImage() async {
    log('crop!');
  }
}
