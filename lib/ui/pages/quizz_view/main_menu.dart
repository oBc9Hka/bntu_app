import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_screen.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var mainColor = Constants.mainColor;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Тест'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 48.0,
          horizontal: 12.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: height / 3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset((themeProvider.brightness == CustomBrightness.light) ? 'assets/bntu_logo.png' : 'assets/bntu_logo_dark.png').image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Пройди тест и узнай, какие специальности тебе подходят',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
                  style: Constants.customElevatedButtonStyle,
                  child: const Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      'Начать тест',
                      style: TextStyle(
                        fontSize: 26.0,
                        // color: mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
