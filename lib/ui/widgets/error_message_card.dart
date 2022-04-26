import 'package:bntu_app/features/greetings/domain/models/error_message_model.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:flutter/material.dart';

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
    Color mainColor = Constants.mainColor;

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
