import 'dart:io';

import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/util/auth_service.dart';
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
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthService _authService = AuthService();
  User? _user;
  static const _url = 'https://bntu.by';

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

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
        _loginController.text, _passwordController.text) as User;
    if (_authService.hasError) {
      _formKey.currentState!.validate();
    } else {
      _getUser();
      Navigator.of(context).pop();
      _formKey.currentState!.reset();
    }
    setState(() {});
  }

  void _showAlertDialog(BuildContext context) {
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
                    validator: (value) {
                      if (value == '') {
                        return 'Введите почту';
                      }
                      if (!validateEmail(value!)) {
                        return 'Поле email заполнено не корректно';
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
                _signIn();
              },
              child: Text('Войти'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
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

    List<Map<String, String>> _buttons = [
      {'text': 'Выбери факультет', 'link': '/main_page'},
      {'text': 'Узнай как поступить', 'link': '/info'},
    ];

    Widget buttonSection = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ..._buttons.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ButtonTheme(
              minWidth: 220.0,
              height: 50.0,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, item['link'].toString());
                },
                label: Text(item['text'].toString()),
                icon: Icon(Icons.account_balance_outlined),
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
          // _authService.isAdmin
          _user != null
              ? ElevatedButton.icon(
                  onPressed: () {
                    _signOut();
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: mainColor,
                  ),
                  label: const Text(
                    'Выход',
                    style: TextStyle(color: mainColor),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(0, 0, 0, 0),
                    ),
                    shadowColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(0, 0, 0, 0),
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
                    padding: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
                    child: Text(
                      'Меню абитуриента',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      _launchURL();
                    },
                    title: Text('На сайт БНТУ'),
                    trailing: Icon(Icons.open_in_browser),
                  ),
                  ListTile(
                    onTap: () {
                      //TODO: handle message errors by users
                    },
                    title: Text('Сообщить об ошибке'),
                    trailing: Icon(Icons.mail),
                  ),
                ],
              ),
              TextButton(
                //TODO: add gesture detector
                onPressed: () {
                  if (_user == null) {
                    _showAlertDialog(context);
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Вы уже в режиме администратора');
                  }
                },
                child: Text(
                  'About text',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
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
      ),
    );
  }
}
