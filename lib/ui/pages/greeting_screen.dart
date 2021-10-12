import 'dart:io';

import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/util/validate_email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    const Color mainColor = Constants.mainColor;
    const _url = Constants.url;


    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final GlobalKey<FormState> _errorFormKey = GlobalKey<FormState>();
    TextEditingController _loginController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _errorDescriptionController =
    TextEditingController();

    List<Map<String, dynamic>> _buttons = [
      {
        'text': 'Выбери факультет',
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

    DateTime? backButtonPressedTime;
    Future<bool> onWillPop() async {
      DateTime currentTime = DateTime.now();
      bool backButton = backButtonPressedTime == null ||
          currentTime.difference(backButtonPressedTime!) > Duration(seconds: 2);
      Fluttertoast.showToast(
        msg: 'Нажмите ещё раз для выхода',
      );

      if (backButton) {
        backButtonPressedTime = currentTime;
        return false;
      }
      exit(0);
    }

    return Consumer<AppProvider>(
      builder: (context, state, child) {

        customElevatedButtonStyle() {
          return ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: mainColor),
              ),
            ),
          );
        }

        void _showLoadingDialog() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: LinearProgressIndicator(
                  color: mainColor,
                ),
              );
            },
          );
        }

        Future<void> _signIn() async {
          _formKey.currentState!.save();
          if (state.errorsMap['hasError']) {
            print('HAS ERROR BLOCK');
            print('hasError? ${state.errorsMap['hasError']}');
            _showLoadingDialog();
            await state
                .signIn(_loginController.text.trim(),
                    _passwordController.text.trim())
                .whenComplete(() {
              print('still hasError? ${state.errorsMap['hasError']}');
              if (state.errorsMap['hasError']) {
                _formKey.currentState!.validate();
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                _formKey.currentState!.reset();
                Fluttertoast.showToast(msg: 'Вы в режиме редактора');
              }
            });
          } else if (!state.errorsMap['hasError'] &&
              _formKey.currentState!.validate()) {
            print('VALIDATE BLOCK');
            _showLoadingDialog();
            await state
                .signIn(_loginController.text.trim(),
                    _passwordController.text.trim())
                .whenComplete(() {
              print(state.errorsMap['hasError']);
              if (state.errorsMap['hasError']) {
                print(state.errorsMap['hasError']);
                _formKey.currentState!.validate();
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                _formKey.currentState!.reset();
                Fluttertoast.showToast(msg: 'Вы в режиме редактора');
              }
            });
          }
        }

        void _showAlertDialog() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Вход в режим администратора'),
                content: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _loginController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == '') {
                              return 'Введите почту';
                            }
                            if (!validateEmail(value!.trim())) {
                              return 'Почта заполнена некорректно';
                            }
                            state.initErrorsMap();
                            print(
                                'hasEmailError ${state.errorsMap['hasEmailError']}');
                            if (state.errorsMap['hasEmailError']) {
                              return state.errorsMap['errorEmailMessage'];
                            }
                            return null;
                          },
                          decoration: const InputDecoration(labelText: 'Логин'),
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == '') {
                              return 'Введите пароль';
                            }
                            state.initErrorsMap();
                            print(
                                'hasPasswordError ${state.errorsMap['hasPasswordError']}');
                            if (state.errorsMap['hasPasswordError']) {
                              return state.errorsMap['errorPasswordMessage'];
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(labelText: 'Пароль'),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Отмена'),
                    style: customElevatedButtonStyle(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _signIn();
                    },
                    child: Text('Войти'),
                    style: customElevatedButtonStyle(),
                  ),
                ],
              );
            },
          );
        }

        void _handleErrorMessageByUser() {
          if (_errorFormKey.currentState!.validate()) {
            if (_errorDescriptionController.text == state.secretKey) {
              Navigator.of(context).pop();
              if (state.user == null) {
                _showAlertDialog();
              } else {
                Fluttertoast.showToast(msg: 'Вы уже в режиме редактора');
              }
            } else {
              state.submitErrorMessage(_errorDescriptionController.text);
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                msg: 'Сообщение отправлено в поддержку',
              );
            }
            _errorDescriptionController.text = '';
            _errorFormKey.currentState!.reset();
          }
        }

        void _sendErrorMessage(BuildContext context) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: Text('Сообщить об ошибке'),
                content: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Form(
                    key: _errorFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            'Если вы обнаружили ошибку, пожалуйста, подробно опишите её, чтобы мы могли её скорее исправить'),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                          child: TextFormField(
                            controller: _errorDescriptionController,
                            validator: (value) {
                              if (value == '') {
                                return 'Введите текст ошибки';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Текст ошибки',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1),
                              ),
                            ),
                            minLines: 1,
                            maxLines: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Отмена'),
                    style: customElevatedButtonStyle(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _handleErrorMessageByUser();
                    },
                    child: Text('Отправить'),
                    style: customElevatedButtonStyle(),
                  ),
                ],
              );
            },
          );
        }

        void _launchURL() async => await canLaunch(_url)
            ? await launch(_url)
            : throw 'Could not launch $_url';

        void _signOut() async {
          state.signOut();
          Fluttertoast.showToast(msg: 'Вы вышли из режима редактора');
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: Image.asset('assets/bntu.png').image,
            ),
            actions: [
              state.user != null
                  ? Container(
                      constraints: BoxConstraints(
                        minWidth: 100,
                        maxWidth: 110,
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _signOut();
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                          color: mainColor,
                        ),
                        label: const Text(
                          'Выход',
                          style: TextStyle(inherit: false, color: mainColor),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(0, 0, 0, 0),
                          ),
                          shadowColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(0, 0, 0, 0),
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 20, bottom: 5),
                        child: Text(
                          'Меню абитуриента',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/map');
                        },
                        title: Text('Карта корпусов'),
                        trailing: Icon(Icons.map_rounded),
                      ),
                      ListTile(
                        onTap: () {
                          if (themeProvider.brightness ==
                              CustomBrightness.dark) {
                            themeProvider.toggle(CustomBrightness.light);
                          } else {
                            themeProvider.toggle(CustomBrightness.dark);
                          }
                        },
                        title: Text(
                          'Dark Mode',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        trailing: themeProvider.currentIcon,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/test');
                        },
                        title: Text('Помощь с выбором факультета'),
                        trailing: Icon(Icons.speaker_notes_rounded),
                      ),
                      ListTile(
                        onTap: () {
                          _launchURL();
                        },
                        title: Text('На сайт БНТУ'),
                        trailing: Icon(Icons.open_in_browser),
                      ),
                      ListTile(
                        onTap: () {
                          _sendErrorMessage(context);
                        },
                        title: Text('Сообщить об ошибке'),
                        trailing: Icon(Icons.mail),
                      ),
                      if (state.user != null)
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed('/settings');
                          },
                          title: Text('Общие настройки'),
                          trailing: Icon(Icons.settings),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'БНТУ 2021',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: WillPopScope(
            onWillPop: onWillPop,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "БЕЛОРУССКИЙ НАЦИОНАЛЬНЫЙ ТЕХНИЧЕСКИЙ УНИВЕРСИТЕТ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: height / 2.5,
                  alignment: Alignment.center,
                  child: Image.asset('assets/man.png'),
                ),
                textSection,
                buttonSection,
              ],
            ),
          ),
        );
      },
    );
  }
}
