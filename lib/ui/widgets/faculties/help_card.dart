import 'package:bntu_app/ui/constants/constants.dart';
import 'package:flutter/material.dart';

class HelpCard extends StatelessWidget {
  const HelpCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Constants.mainColor),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Не можешь выбрать специальность?',
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(
                Icons.youtube_searched_for,
                size: 36,
                color: Constants.mainColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text('Пройди тест, который поможет тебе в этом!'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/test');
              },
              style: Constants.customElevatedButtonStyle,
              child: Text(
                'Пройти тест',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
