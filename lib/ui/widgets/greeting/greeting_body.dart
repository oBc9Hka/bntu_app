import 'package:flutter/material.dart';

class GreetingBody extends StatelessWidget {
  const GreetingBody({
    Key? key,
    required this.textSection,
    required this.buttonSection,
  }) : super(key: key);
  final textSection;
  final buttonSection;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'БЕЛОРУССКИЙ НАЦИОНАЛЬНЫЙ ТЕХНИЧЕСКИЙ УНИВЕРСИТЕТ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          width: double.infinity,
          height: height / 2.5,
          alignment: Alignment.center,
          child: Image.asset('assets/man.png'),
        ),
        textSection,
        buttonSection,
      ],
    );
  }
}
