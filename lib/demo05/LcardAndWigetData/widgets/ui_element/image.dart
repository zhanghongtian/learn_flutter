import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/models/common.dart';
import 'package:flutter_app2/demo05/LcardAndWigetData/scoped_models/main_scope_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class ImageInput extends StatefulWidget {
  ImageInput({Key key, this.setImage, this.initImage}) : super(key: key);
  final Function setImage;
  final Function initImage;

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  String _imageFile;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainScopeModel>(
      builder: (context, child, model) {
        return Column(children: [
          OutlinedButton(
            style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                    style: BorderStyle.solid))),
            onPressed: () {
              openImagePicker(context, model);
            },
            child: Text(
              "选择图片",
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          buildImagePreView(model)
        ]);
      },
    );
  }

  Widget buildImagePreView(MainScopeModel model) {
    if (_imageFile != null) {
      return Image.file(
        File(_imageFile),
        fit: BoxFit.cover,
        height: 300,
      );
    } else if (model.selectedNewsId != null) {
      widget.initImage(model.selectedNews.imageUrl);
      return Image.network(
        CommonConfig.HOST + model.selectedNews.imageUrl,
        fit: BoxFit.cover,
        height: 300,
      );
    } else {
      return Center(
        child: Text(
          '请选择图片',
          style: TextStyle(fontSize: 10),
        ),
      );
    }
  }

  void getImage(ImageSource source, MainScopeModel model) {
    picker
        .getImage(
            source: source,
            maxWidth: 400,
            preferredCameraDevice: CameraDevice.front)
        .then((PickedFile imageFile) {
      print(imageFile.path);
      setState(() {
        _imageFile = imageFile.path;
      });
      widget.setImage(File(imageFile.path), model);
      Navigator.pop(context);
    });
  }

  void openImagePicker(BuildContext context, MainScopeModel model) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10),
            height: 140,
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      getImage(ImageSource.camera, model);
                    },
                    child: Text('相机')),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      getImage(ImageSource.gallery, model);
                    },
                    child: Text('相册'))
              ],
            ),
          );
        });
  }
}
