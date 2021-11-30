
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/widgets/greeting/narrow_layout.dart';
import 'package:bntu_app/ui/widgets/greeting/wide_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mainColor = Constants.mainColor;

    var _buttons = <Map<String, dynamic>>[
      {
        'text': 'Выбери специальность',
        'link': '/main_page',
        'icon': Icon(Icons.account_balance_outlined),
      },
      {
        'text': 'Узнай как поступить',
        'link': '/info',
        'icon': Icon(Icons.info_outline),
      },
    ];

    Widget buttonSection = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ..._buttons.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 50,
                maxHeight: 50,
                minWidth: 150,
                maxWidth: 300,
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, item['link'].toString());
                },
                label: Text(
                  item['text'].toString(),
                  style: TextStyle(inherit: false, color: mainColor),
                ),
                icon: item['icon'],
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(mainColor),
                  minimumSize: MaterialStateProperty.all(Size(220, 50)),
                  elevation: MaterialStateProperty.all(10),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: mainColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    Widget textSection = Container(
      constraints: BoxConstraints(
        minWidth: 300,
        maxWidth: 300,
      ),
      alignment: Alignment.center,
      child: const ListTile(
        title: Text('АБИТУРИЕНТ?',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700)),
        subtitle: Text(
          'Приходи, ждём!',
          style: TextStyle(
              color: mainColor, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
    );

    return Consumer<AppProvider>(
      builder: (context, state, child) {
        void _signOut() async {
          state.signOut();
          Navigator.of(context).pop();
          await Fluttertoast.showToast(msg: 'Вы вышли из режима редактора');
        }

        if (MediaQuery.of(context).size.width > 920) {
          return WideLayout(
            textSection: textSection,
            buttonSection: buttonSection,
            signOut: () {
              _signOut();
            },
          );
        } else {
          return NarrowLayout(
            textSection: textSection,
            buttonSection: buttonSection,
            // onWillPop: onWillPop,
            signOut: () {
              _signOut();
            },
          );
        }
      },
    );
  }
}
