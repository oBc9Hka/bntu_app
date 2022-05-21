import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class GreetingBodyWide extends StatelessWidget {
  const GreetingBodyWide({
    Key? key,
    required this.textSection,
    required this.buttonSection,
  }) : super(key: key);
  final textSection;
  final buttonSection;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          right: -1 / MediaQuery.of(context).size.width * 300000,
          child: Container(
            height: height,
            constraints: BoxConstraints(
              maxWidth: 800,
              minHeight: 600,
            ),
            child: Image.asset(
              'assets/man.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'БЕЛОРУССКИЙ НАЦИОНАЛЬНЫЙ ТЕХНИЧЕСКИЙ УНИВЕРСИТЕТ',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Text('АБИТУРИЕНТ?',
                  style: TextStyle(fontSize: 55, fontWeight: FontWeight.w700)),
              Text(
                'Приходи, ждём!',
                style: TextStyle(
                    color: Constants.mainColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              buttonSection,
            ],
          ),
        ),
      ],
    );
  }
}
