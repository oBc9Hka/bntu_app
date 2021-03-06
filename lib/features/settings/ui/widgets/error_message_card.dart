import 'package:bntu_app/core/domain/models/error_message_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class ErrorMessageCard extends StatelessWidget {
  const ErrorMessageCard(
      {Key? key,
      required this.onTap,
      required this.onRemovePressed,
      required this.item})
      : super(key: key);
  final ErrorMessage item;
  final GestureTapCallback onTap;
  final GestureTapCallback onRemovePressed;

  @override
  Widget build(BuildContext context) {
    var mainColor = Constants.mainColor;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: item.viewed! ? Colors.grey : mainColor),
        ),
        onTap: onTap,
        title: Text(item.message.toString()),
        trailing: IconButton(
          onPressed: onRemovePressed,
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
