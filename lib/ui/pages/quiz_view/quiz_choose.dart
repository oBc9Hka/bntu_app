import 'package:bntu_app/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';

class QuizChoose extends StatefulWidget {
  const QuizChoose({Key? key}) : super(key: key);

  @override
  _QuizChooseState createState() => _QuizChooseState();
}

class _QuizChooseState extends State<QuizChoose> {
  var groupValue;
  bool firstInit = true;
  late AppProvider state;

  Future<bool> _onWillPop() async {
    if (groupValue == 0) {
      state.editQuizChecked(true);
    } else if (groupValue == 1) {
      state.editQuizChecked(false);
    }
    Fluttertoast.showToast(msg: 'Изменения сохранены');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (firstInit) {
      setState(() {
        state = context.watch<AppProvider>();
        groupValue = state.isFacultiesQuiz ? 0 : 1;
        firstInit = false;
      });
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Редактирование вопросов'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Text(
                    'Выбор отображаемого теста:',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: 0,
                  groupValue: groupValue,
                  onChanged: (T) {
                    setState(() {
                      groupValue = T as int;
                    });
                  },
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Определение факультета'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(context, '/test-faculties-edit');
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: 1,
                  groupValue: groupValue,
                  onChanged: (T) {
                    setState(() {
                      groupValue = T as int;
                    });
                  },
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Определение специальности'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(context, '/test-specialties-edit');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
