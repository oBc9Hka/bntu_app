import 'package:bntu_app/core/provider/theme_provider.dart';
import 'package:bntu_app/features/quiz/ui/quiz_main_menu.dart';
import 'package:bntu_app/features/settings/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/provider/app_provider.dart';
import '../../../../core/util/validate_email.dart';
import '../../../quiz/provider/quiz_provider.dart';
import '../../provider/greetings_provider.dart';

class GreetingDrawer extends StatelessWidget {
  const GreetingDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppProvider>();
    final greetingState = context.watch<GreetingsProvider>();
    final settingsState = context.watch<SettingsProvider>();
    final quizState = context.watch<QuizProvider>();

    var themeProvider = Provider.of<ThemeProvider>(context);
    const mainColor = Constants.mainColor;
    const _url = Constants.url;

    final _formKey = GlobalKey<FormState>();
    final _errorFormKey = GlobalKey<FormState>();
    var _loginController = TextEditingController();
    var _passwordController = TextEditingController();
    var _errorDescriptionController = TextEditingController();

    ButtonStyle customElevatedButtonStyle() {
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
      if (appState.errorsMap['hasError']) {
        print('HAS ERROR BLOCK');
        print('hasError? ${appState.errorsMap['hasError']}');
        _showLoadingDialog();
        await appState
            .signIn(
                _loginController.text.trim(), _passwordController.text.trim())
            .whenComplete(() {
          print('still hasError? ${appState.errorsMap['hasError']}');
          if (appState.errorsMap['hasError']) {
            _formKey.currentState!.validate();
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            _formKey.currentState!.reset();
            Fluttertoast.showToast(msg: '???? ?? ???????????? ??????????????????');
          }
        });
      } else if (!appState.errorsMap['hasError'] &&
          _formKey.currentState!.validate()) {
        print('VALIDATE BLOCK');
        _showLoadingDialog();
        await appState
            .signIn(
                _loginController.text.trim(), _passwordController.text.trim())
            .whenComplete(() {
          print(appState.errorsMap['hasError']);
          if (appState.errorsMap['hasError']) {
            print(appState.errorsMap['hasError']);
            _formKey.currentState!.validate();
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            _formKey.currentState!.reset();
            Fluttertoast.showToast(msg: '???? ?? ???????????? ??????????????????');
          }
        });
      }
    }

    void _showAlertDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('???????? ?? ?????????? ??????????????????'),
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
                          return '?????????????? ??????????';
                        }
                        if (!validateEmail(value!.trim())) {
                          return '?????????? ?????????????????? ??????????????????????';
                        }
                        appState.initErrorsMap();
                        print(
                            'hasEmailError ${appState.errorsMap['hasEmailError']}');
                        if (appState.errorsMap['hasEmailError']) {
                          return appState.errorsMap['errorEmailMessage'];
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: '??????????'),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == '') {
                          return '?????????????? ????????????';
                        }
                        appState.initErrorsMap();
                        print(
                            'hasPasswordError ${appState.errorsMap['hasPasswordError']}');
                        if (appState.errorsMap['hasPasswordError']) {
                          return appState.errorsMap['errorPasswordMessage'];
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: '????????????'),
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
                style: customElevatedButtonStyle(),
                child: Text('????????????'),
              ),
              ElevatedButton(
                onPressed: () {
                  _signIn();
                },
                style: customElevatedButtonStyle(),
                child: Text('??????????'),
              ),
            ],
          );
        },
      );
    }

    void _handleErrorMessageByUser() {
      if (_errorFormKey.currentState!.validate()) {
        if (_errorDescriptionController.text == settingsState.secretKey) {
          Navigator.of(context).pop();
          if (appState.user == null) {
            _showAlertDialog();
          } else {
            Fluttertoast.showToast(msg: '???? ?????? ?? ???????????? ??????????????????');
          }
        } else {
          greetingState.submitErrorMessage(_errorDescriptionController.text);
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: '?????????????????? ???????????????????? ?? ??????????????????',
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
            title: Text('???????????????? ???? ????????????'),
            content: Padding(
              padding: const EdgeInsets.all(0),
              child: Form(
                key: _errorFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        '???????? ???? ???????????????????? ????????????, ????????????????????, ???????????????? ?????????????? ????, ?????????? ???? ?????????? ???? ???????????? ??????????????????'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 5),
                      child: TextFormField(
                        controller: _errorDescriptionController,
                        validator: (value) {
                          if (value == '') {
                            return '?????????????? ?????????? ????????????';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: '?????????? ????????????',
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: mainColor, width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.red, width: 1),
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
                style: customElevatedButtonStyle(),
                child: Text('????????????'),
              ),
              ElevatedButton(
                onPressed: () {
                  _handleErrorMessageByUser();
                },
                style: customElevatedButtonStyle(),
                child: Text('??????????????????'),
              ),
            ],
          );
        },
      );
    }

    void _launchURL() async => await canLaunch(_url)
        ? await launch(_url)
        : throw 'Could not launch $_url';
    return Container(
      color: themeProvider.brightness == CustomBrightness.dark
          ? Colors.black54
          : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
                child: Text(
                  '???????? ??????????????????????',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/map');
                },
                title: Text('?????????? ????????????????'),
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
                  '???????????? ????????',
                  // style: TextStyle(fontStyle: FontStyle.italic),
                ),
                trailing: themeProvider.currentIcon,
              ),
              ListTile(
                onTap: () async {
                  _showLoadingDialog();
                  await settingsState.initSettings();
                  await quizState.getQuizList(quizIds: settingsState.quizIds);
                  Navigator.of(context).pop();
                  if (settingsState.quizIds.length == 1) {
                    await quizState.setActiveQuiz(
                      docId: settingsState.quizIds.first,
                      quizIds: settingsState.quizIds,
                    );

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizMainMenu(),
                      ),
                    );
                  } else {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: settingsState.quizIds.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/sad_icon.svg',
                                          color: Constants.mainColor,
                                          height: 50,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: Text(
                                              '?????????????????? ?? ?????????????????????? ???????????? ???????? ??????',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        '?????????? ??????????',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                      ListView(
                                        shrinkWrap: true,
                                        children: [
                                          for (var i = 0;
                                              i < settingsState.quizIds.length;
                                              i++)
                                            ListTile(
                                              title: Text(quizState.quizList
                                                  .firstWhere((element) =>
                                                      element!.docId ==
                                                      settingsState.quizIds[i])!
                                                  .quizName),
                                              onTap: () {
                                                quizState.setActiveQuiz(
                                                  docId:
                                                      settingsState.quizIds[i],
                                                  quizIds:
                                                      settingsState.quizIds,
                                                );

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizMainMenu(),
                                                  ),
                                                );
                                              },
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                          );
                        });
                  }
                },
                title: Text(
                  '???????????? ?? ?????????????? ??????????????????????????',
                ),
                trailing: Icon(Icons.speaker_notes_rounded),
              ),
              ListTile(
                onTap: () {
                  _launchURL();
                },
                title: Text('???? ???????? ????????'),
                trailing: Icon(Icons.open_in_browser),
              ),
              ListTile(
                onTap: () {
                  _sendErrorMessage(context);
                },
                title: Text('???????????????? ???? ????????????'),
                trailing: Icon(Icons.mail),
              ),
              if (appState.user != null)
                ListTile(
                  onTap: () {
                    settingsState.initSettings();
                    Navigator.of(context).pushNamed('/settings');
                  },
                  title: Text('?????????? ??????????????????'),
                  trailing: Icon(Icons.settings),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '???????? 2021',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
