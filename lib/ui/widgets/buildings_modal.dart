import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imagePath})
      : super(key: key);
  final String title;
  final String subtitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle != ''
                        ? Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                ),
              ),
            ],
          ),
          Expanded(
            child: (imagePath != '')
                ? Stack(
                    children: [
                      Center(child: CircularProgressIndicator()),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(imagePath, loadingBuilder:
                                (BuildContext context, Widget child,
                                    ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return CircularProgressIndicator();
                            }).image,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(child: Text('Изображение отсутствует')),
          ),
        ],
      ),
    );
  }
}
