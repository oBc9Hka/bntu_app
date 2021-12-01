import 'package:bntu_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            'БЕЛОРУССКИЙ НАЦИОНАЛЬНЫЙ ТЕХНИЧЕСКИЙ УНИВЕРСИТЕТ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                height: height / 2.5,
                alignment: Alignment.center,
                child: Image.asset('assets/man.png'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: height * 0.4,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 0),
                      ),
                    ],
                    color: (themeProvider.brightness == CustomBrightness.light)
                        ? Colors.white
                        : Colors.grey[900],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textSection,
                      buttonSection,
                      Padding(padding: EdgeInsets.only(bottom: 5)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
