import 'package:bntu_app/core/provider/theme_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacultyShortItem extends StatelessWidget {
  final String shortName;
  final User? user;
  final GestureTapCallback onTap;
  final GestureTapCallback onEditPressed;

  const FacultyShortItem({
    Key? key,
    required this.shortName,
    required this.user,
    required this.onTap,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainColor = Constants.mainColor;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      tileColor: themeProvider.brightness == CustomBrightness.light
          ? Colors.white
          : Colors.grey[900],
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: mainColor),
      ),
      trailing: user != null
          ? Container(
              width: 24,
              child: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: onEditPressed,
                icon: Icon(
                  Icons.edit,
                  color: mainColor,
                ),
              ),
            )
          : Container(
              width: 24,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                color: mainColor,
              ),
            ),
      title: Text(
        shortName,
        style: TextStyle(
          color: mainColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
