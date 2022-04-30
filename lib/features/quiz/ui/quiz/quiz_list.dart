import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:bntu_app/features/quiz/ui/quiz/quiz_add.dart';
import 'package:bntu_app/features/quiz/ui/quiz/quiz_edit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/constants.dart';
import '../../../settings/provider/settings_provider.dart';

class QuizList extends StatefulWidget {
  const QuizList({Key? key}) : super(key: key);

  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  var groupValue = -1;
  bool firstInit = true;
  late SettingsProvider settingsState;
  late QuizProvider quizState;

  Future<bool> _onWillPop() async {
    settingsState.changeCheckedTest(quizState.quizList[groupValue].docId);
    await Fluttertoast.showToast(msg: 'Изменения сохранены');
    return true;
  }

  Future<void> theFirstInit() async {
    settingsState = context.watch<SettingsProvider>();
    quizState = context.watch<QuizProvider>();

    await quizState.getQuizList();
    try {
      final checkedTest = quizState.quizList.firstWhere(
        (element) => element.docId == settingsState.checkedQuizId,
      );

      groupValue = quizState.quizList.indexOf(checkedTest);
    } catch (_) {}

    firstInit = false;
    setState(() {});
    print(groupValue);
  }

  @override
  Widget build(BuildContext context) {
    if (firstInit) {
      theFirstInit();
    }
    return Consumer<QuizProvider>(
      builder: (context, quizState, child) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Редактирование тестов'),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizAdd(),
                        ),
                      );
                    },
                    icon: Icon(Icons.add)),
              ],
            ),
            body: quizState.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : (quizState.quizList.isEmpty)
                    ? Center(
                        child: Text('Список тестов пуст'),
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, left: 10),
                                child: Text(
                                  'Выбор отображаемого теста:',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: quizState.quizList.length,
                            itemBuilder: ((context, index) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio(
                                    activeColor: Constants.mainColor,
                                    value: index,
                                    groupValue: groupValue,
                                    onChanged: (T) {
                                      setState(() {
                                        groupValue = T as int;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                          quizState.quizList[index].quizName),
                                      trailing: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: ((context) => QuizEdit(
                                                  quiz: quizState
                                                      .quizList[index])),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }
}
