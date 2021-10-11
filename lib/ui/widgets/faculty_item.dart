import 'package:bntu_app/ui/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FacultyItem extends StatelessWidget {
  final String name;
  final String shortName;
  final User? user;
  final GestureTapCallback onTap;
  final GestureTapCallback onEditPressed;

  const FacultyItem({
    Key? key,
    required this.name,
    required this.shortName,
    required this.user,
    required this.onTap,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants.mainColor;

    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: mainColor),
      ),
      leading: Container(
        alignment: Alignment.centerLeft,
        width: 70,
        child: Text(
          shortName,
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      trailing: user != null
          ? IconButton(
              onPressed: onEditPressed,
              icon: Icon(
                Icons.edit,
                color: mainColor,
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
        name,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
