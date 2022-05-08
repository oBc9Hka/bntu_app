import 'package:bntu_app/core/widgets/save_changes.dart';
import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:bntu_app/features/quiz/ui/quiz/quiz_add.dart';
import 'package:bntu_app/features/quiz/ui/quiz/quiz_edit.dart';
import 'package:flutter/foundation.dart';
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
  List<String> initCheckedIds = [];
  bool firstInit = true;
  late SettingsProvider settingsState;
  late QuizProvider quizState;

  Future<bool> _onWillPop() async {
    var doneQuizList = settingsState.quizIds.map((e) => e).toList();
    initCheckedIds.sort();
    doneQuizList.sort();
    if (!listEquals(initCheckedIds, doneQuizList)) {
      await showDialog(
          context: context,
          builder: (context) {
            return SaveChanges(onSavePressed: () {
              settingsState.saveCheckedQuizIds();
              Fluttertoast.showToast(msg: 'Изменения сохранены');
              Navigator.of(context).pop();
            });
          });
    }

    return true;
  }

  Future<void> theFirstInit() async {
    settingsState = context.watch<SettingsProvider>();
    quizState = context.watch<QuizProvider>();
    initCheckedIds = settingsState.quizIds.map((e) => e).toList();
    await quizState.getQuizList(quizIds: settingsState.allQuizIds);
    try {
      quizState.quizList.map((e) {
        if (settingsState.quizIds.contains(e!.docId)) {
          e = e.copyWith(isChecked: true);
        }
      });
    } catch (_) {}

    firstInit = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (firstInit) {
      theFirstInit();
    }
    return Consumer<QuizProvider>(
      builder: (context, quizState, child) {
        print(quizState.quizList.isEmpty);
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Редактирование тестов'),
              actions: [
                IconButton(
                    onPressed: () {
                      quizState.setNewQuizInEdit();
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
                                  Checkbox(
                                    checkColor: Constants.mainColor,
                                    value: settingsState.quizIds.contains(
                                        quizState.quizList[index]!.docId),
                                    onChanged: (value) {
                                      final list = settingsState.quizIds;
                                      if (!value!) {
                                        final remove = list.firstWhere(
                                            (element) =>
                                                element ==
                                                quizState
                                                    .quizList[index]!.docId);
                                        list.remove(remove);
                                        settingsState.editCheckedQuizIds(
                                          newList: list,
                                        );
                                      } else {
                                        list.add(
                                            quizState.quizList[index]!.docId);
                                        settingsState.editCheckedQuizIds(
                                          newList: list,
                                        );
                                      }
                                    },
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                          quizState.quizList[index]!.quizName),
                                      trailing: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          quizState.setQuizInEdit(
                                            quizState.quizList[index]!,
                                          );
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: ((context) =>
                                                  QuizEdit()),
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
