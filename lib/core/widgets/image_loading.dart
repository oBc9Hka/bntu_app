import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageLoading extends StatelessWidget {
  const ImageLoading(
      {Key? key, required this.onLoadPressed, required this.image, this.item})
      : super(key: key);

  final GestureTapCallback onLoadPressed;
  final XFile? image;
  final item;

  @override
  Widget build(BuildContext context) {
    const C_WIDTH = 200.0;
    const C_HEIGHT = 100.0;

    try {
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
          else if (item != null && item!.imagePath != '')
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
                        image: Image.network(item!.imagePath.toString()).image,
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
    } catch (e) {
      throw 'Данный объект не поддерживает загрузку изображений';
    }
  }
}
