import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class EditButtonsSection extends StatelessWidget {
  const EditButtonsSection({
    Key? key,
    required this.onEditPressed,
    required this.onRemovePressed,
  }) : super(key: key);
  final GestureTapCallback onEditPressed;
  final GestureTapCallback onRemovePressed;

  @override
  Widget build(BuildContext context) {
    final mainColor = Constants.mainColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: onEditPressed,
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(mainColor),
              minimumSize: MaterialStateProperty.all(Size(150, 50)),
              elevation: MaterialStateProperty.all(10),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: mainColor),
                ),
              ),
            ),
            child: Text('Изменить'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(mainColor),
              minimumSize: MaterialStateProperty.all(Size(120, 50)),
              elevation: MaterialStateProperty.all(10),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: mainColor),
                ),
              ),
            ),
            child: Text('Назад'),
          ),
          ElevatedButton(
            onPressed: onRemovePressed,
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.red),
              minimumSize: MaterialStateProperty.all(Size(50, 50)),
              elevation: MaterialStateProperty.all(10),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red),
                ),
              ),
            ),
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
