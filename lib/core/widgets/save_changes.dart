import 'package:bntu_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class SaveChanges extends StatelessWidget {
  const SaveChanges({
    Key? key,
    required this.onSavePressed,
    this.onNoPressed,
  }) : super(key: key);
  final GestureTapCallback onSavePressed;
  final Function()? onNoPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 40,
        child: Center(
            child: Text(
          'Хотите сохранить изменения?',
          style: TextStyle(fontSize: 18),
        )),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            if (onNoPressed != null) {
              onNoPressed!();
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black38),
          ),
          child: const Text(
            'Нет',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: onSavePressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Constants.mainColor),
          ),
          child: const Text(
            'Сохранить',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
