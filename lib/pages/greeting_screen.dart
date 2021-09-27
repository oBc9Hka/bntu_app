import 'dart:io';

import 'package:bntu_app/models/error_message_model.dart';
import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/util/auth_service.dart';
import 'package:bntu_app/util/data.dart';
import 'package:bntu_app/util/validate_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  _GreetingScreenState createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _errorFormKey = GlobalKey<FormState>();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _errorDescriptionController = TextEditingController();
  AuthService _authService = AuthService();
  User? _user;
  static const _url = 'https://bntu.by';
  String _key = 'secretKey';

  void _initKey() async {
    _key = await Data()
        .getFieldData('secretKey')
        .whenComplete(() => setState(() {}));
  }

  @override
  void initState() {
    _getUser();
    _initKey();
    super.initState();
  }

  void _handleErrorMessageByUser() {
    if (_errorFormKey.currentState!.validate()) {
      if (_errorDescriptionController.text == _key) {
        Navigator.of(context).pop();
        if (_user == null) {
          _showAlertDialog();
        } else {
          Fluttertoast.showToast(msg: 'Вы уже в режиме администратора');
        }
      } else {
        ErrorMessage().submitErrorMessage(_errorDescriptionController.text);
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: 'Сообщение отправлено в поддержку',
        );
      }
      _errorDescriptionController.text = '';
      _errorFormKey.currentState!.reset();
    }
  }

  static const Color mainColor = Color.fromARGB(255, 0, 138, 94);

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
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: mainColor, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.red, width: 2),
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
            ),
            ElevatedButton(
              onPressed: () {
                _handleErrorMessageByUser();
              },
              child: Text('Отправить'),
            ),
          ],
        );
      },
    );
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Future<void> _getUser() async {
    final user = await _authService.getCurrentUser();
    setState(() {
      _user = user as User;
    });
  }

  void _signOut() async {
    await _authService.signOut().whenComplete(() {
      _getUser();
      setState(() {});
    });
  }

  Future<void> _signIn() async {
    _formKey.currentState!.save();
    _formKey.currentState!.validate();
    _user = await _authService.singIn(
        _loginController.text.trim(), _passwordController.text.trim()) as User;
    if (_authService.hasError) {
      _formKey.currentState!.validate();
    } else {
      _getUser();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      _formKey.currentState!.reset();
    }
    setState(() {});
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
                      if (_authService.hasEmailError) {
                        return _authService.errorEmailMessage;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Логин'),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == '' && !_authService.hasEmailError) {
                        return 'Введите пароль';
                      }
                      if (_authService.hasPasswordError) {
                        return _authService.errorPasswordMessage;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Пароль'),
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
            ),
            ElevatedButton(
              onPressed: () {
                _showLoadingDialog();
                _signIn();
              },
              child: Text('Войти'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    const Color mainColor = Color.fromARGB(255, 0, 138, 94); // green color

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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: Image.asset('assets/bntu.png').image,
        ),
        actions: [
          _user != null
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      if (themeProvider.brightness == CustomBrightness.dark) {
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
                    title: Text('Пройти тестирование'),
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
                  if (_user != null)
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
  }
}
