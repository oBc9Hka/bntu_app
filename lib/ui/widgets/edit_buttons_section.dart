import 'package:bntu_app/ui/constants/constants.dart';
import 'package:flutter/material.dart';

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
    final mainColor = Constants().mainColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: onEditPressed,
            child: Text('Изменить'),
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
          ElevatedButton(
            onPressed: onRemovePressed,
            child: Icon(Icons.delete),
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
          ),
        ],
      ),
    );
  }
}
