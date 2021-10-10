import 'dart:math';

import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color mainColor = Constants().mainColor;
  TextEditingController _yearController = TextEditingController();
  TextEditingController _keyController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _showAlertDialog(GestureTapCallback onPressed) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Подтвердить изменения?'),
            actions: [
              ElevatedButton(
                onPressed: onPressed,
                child: Text('Изменить'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Отмена'),
              ),
            ],
          );
        });
  }

  _saveSettings(AppProvider state) {
    if (_formKey.currentState!.validate()) {
      state.editSettings(
        _yearController.text.trim(),
        _keyController.text.trim(),
      );
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Настройки успешно изменены');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<AppProvider>(
      builder: (context, state, child) {
        _yearController =
            TextEditingController(text: state.currentAdmissionYear);
        _keyController = TextEditingController(text: state.secretKey);
        String _unseenCount = state.unseenCount;

        return Scaffold(
          appBar: AppBar(
            title: Text('Настройки'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed('/messages');
                          },
                          title: Text('Сообщения об ошибках'),
                          trailing: Container(
                            decoration: BoxDecoration(
                                color: (_unseenCount == '0')
                                    ? Colors.grey
                                    : mainColor,
                                border: Border.all(
                                    color: (_unseenCount == '0')
                                        ? Colors.grey
                                        : mainColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'новых: $_unseenCount',
                                style: TextStyle(
                                    color: (_themeProvider.brightness ==
                                            CustomBrightness.dark)
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Текущий год приёма'),
                          subtitle: Text(
                              'Отображается в плане набора, проходных баллах'),
                          trailing: Container(
                            width: 50,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: _yearController,
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Ключ входа в режим администратора'),
                          subtitle: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  var _chars =
                                      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                                  Random _rnd = Random();
                                  _keyController.text = String.fromCharCodes(
                                      Iterable.generate(
                                          10,
                                          (_) => _chars.codeUnitAt(
                                              _rnd.nextInt(_chars.length))));
                                  setState(() {});
                                },
                                child: Text('Сгенерировать'),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(0))),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 100,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: _keyController,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Clipboard.setData(new ClipboardData(
                                        text: _keyController.text));
                                    Fluttertoast.showToast(
                                        msg: 'Скопировано в буфер обмена');
                                  },
                                  icon: Icon(Icons.copy))
                            ],
                          ),
                        ),
                        Divider(),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed('/testList');
                          },
                          title: Text('Список вопросов'),
                          trailing: Icon(Icons.question_answer_outlined),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showAlertDialog(
                          () {
                            _saveSettings(state);
                          },
                        );
                      },
                      child: Text('Изменить'),
                      style: ButtonStyle(
                        // foregroundColor: MaterialStateProperty.all(mainColor),
                        minimumSize: MaterialStateProperty.all(Size(150, 50)),
                        elevation: MaterialStateProperty.all(10),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        minimumSize: MaterialStateProperty.all(Size(150, 50)),
                        elevation: MaterialStateProperty.all(10),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: mainColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
