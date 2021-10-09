import 'dart:io';

import 'package:bntu_app/models/faculty_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageLoading extends StatelessWidget {
  const ImageLoading(
      {Key? key,
      required this.onLoadPressed,
      required this.image,
      this.faculty})
      : super(key: key);

  final GestureTapCallback onLoadPressed;
  final XFile? image;
  final Faculty? faculty;

  @override
  Widget build(BuildContext context) {
    const double C_WIDTH = 200;
    const double C_HEIGHT = 100;

    return Column(
      children: [
        ElevatedButton(
            onPressed: onLoadPressed, child: Text('Загрузить изображение')),
        if (image != null)
          Center(
            child: Stack(
              children: [
                SizedBox(
                  width: C_WIDTH,
                  height: C_HEIGHT,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Container(
                  width: C_WIDTH,
                  height: C_HEIGHT,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.file(File(image!.path)).image),
                  ),
                ),
              ],
            ),
          )
        else if (faculty != null && faculty!.imagePath != '')
          Center(
            child: Stack(
              children: [
                SizedBox(
                  width: C_WIDTH,
                  height: C_HEIGHT,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Container(
                  width: C_WIDTH,
                  height: C_HEIGHT,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.network(faculty!.imagePath.toString()).image,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          Text('Изображение не загружено'),
      ],
    );
  }
}
