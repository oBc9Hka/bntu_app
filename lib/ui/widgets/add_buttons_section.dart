import 'package:bntu_app/ui/constants/constants.dart';
import 'package:flutter/material.dart';

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
            child: Text('Добавить'),
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
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Назад'),
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
          ),
        ],
      ),
    );
  }
}
