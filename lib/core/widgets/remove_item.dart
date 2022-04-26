import 'package:flutter/material.dart';

class RemoveItem extends StatelessWidget {
  const RemoveItem(
      {Key? key, required this.itemName, required this.onRemovePressed})
      : super(key: key);
  final String itemName;
  final GestureTapCallback onRemovePressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 40,
        child: Center(
            child: Text(
          'Хотите удалить ${itemName.toLowerCase()}?',
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
          onPressed: onRemovePressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          child: const Text(
            'Удалить',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
