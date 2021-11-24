import 'dart:io';

import 'package:bntu_app/ui/widgets/greeting/app_bar.dart';
import 'package:bntu_app/ui/widgets/greeting/greeting_drawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'greeting_body_wide.dart';

class WideLayout extends StatelessWidget {
  const WideLayout({
    Key? key,
    required this.textSection,
    required this.buttonSection,
    required this.signOut,
  }) : super(key: key);
  final textSection;
  final buttonSection;
  final GestureTapCallback signOut;

  @override
  Widget build(BuildContext context) {

    DateTime? backButtonPressedTime;
    Future<bool> onWillPop() async {
      var currentTime = DateTime.now();
      var backButton = backButtonPressedTime == null ||
          currentTime.difference(backButtonPressedTime!) > Duration(seconds: 2);
      await Fluttertoast.showToast(
        msg: 'Нажмите ещё раз для выхода',
      );

      if (backButton) {
        backButtonPressedTime = currentTime;
        return false;
      }
      exit(0);
    }

    return Scaffold(
      appBar: CustomAppBar(
        signOut: signOut,
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Row(
          children: [
            Expanded(
              child: Container(decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 0), // changes position of shadow
                  ),
                ],
              ),
                  child: GreetingDrawer()),
            ),
            Expanded(
              flex: 2,
              child: GreetingBodyWide(
                textSection: textSection,
                buttonSection: buttonSection,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
