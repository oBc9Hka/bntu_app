import 'package:flutter/material.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key? key, required this.onConfirmPressed}) : super(key: key);
  final GestureTapCallback onConfirmPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 45,
        child: Center(
            child: Text(
              'Хотите выйти из режима редактора?',
              style: TextStyle(fontSize: 18),
            )),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black38),
          ),
          child: const Text(
            'Отмена',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: onConfirmPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          child: const Text(
            'Выйти',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
