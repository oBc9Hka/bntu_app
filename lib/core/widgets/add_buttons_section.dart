import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class AddButtonsSection extends StatelessWidget {
  const AddButtonsSection({
    Key? key,
    required this.onAddPressed,
  }) : super(key: key);
  final GestureTapCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final mainColor = Constants.mainColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: onAddPressed,
            style: ButtonStyle(
              // foregroundColor: MaterialStateProperty.all(mainColor),
              minimumSize: MaterialStateProperty.all(Size(120, 50)),
              elevation: MaterialStateProperty.all(10),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: mainColor),
                ),
              ),
            ),
            child: Text('Добавить'),
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
        ],
      ),
    );
  }
}
