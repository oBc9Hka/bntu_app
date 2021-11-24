import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_bar.dart';
import 'greeting_body.dart';
import 'greeting_drawer.dart';

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({
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
      appBar: CustomAppBar(signOut: signOut,),
      drawer: Drawer(
        child: SafeArea(
          child: GreetingDrawer(),
        ),
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: GreetingBody(
          buttonSection: buttonSection,
          textSection: textSection,
        ),
      ),
    );
  }
}
