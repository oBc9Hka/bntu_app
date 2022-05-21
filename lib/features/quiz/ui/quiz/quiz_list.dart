import 'package:bntu_app/core/widgets/info_dialog.dart';
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
import '../quiz_main_menu.dart';

class QuizList extends StatefulWidget {
  const QuizList({Key? key}) : super(key: key);

  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
              var canBeSaved = true;
              for (var item in quizState.quizList) {
                if (settingsState.quizIds.contains(item!.docId) &&
                    item.questions.isEmpty) {
                  canBeSaved = false;
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return InfoDialog(
                        icon: Icon(
                          Icons.info,
                          size: 50,
                          color: Constants.mainColor,
                        ),
                        message:
                            '"${item.quizName}" не имеет вопросов, поэтому не может быть отображен для всех.',
                      );
                    },
                  );
                  break;
                }
              }
              if (canBeSaved) {
                settingsState.saveCheckedQuizIds();
                Fluttertoast.showToast(msg: 'Изменения сохранены');
                Navigator.of(context).pop();
              }
            });
          });
    }

    return true;
  }

  Future<void> theFirstInit() async {
    settingsState = context.watch<SettingsProvider>();
    quizState = context.watch<QuizProvider>();
    initCheckedIds = settingsState.quizIds.map((e) => e).toList();
    await quizState.getAllQuizList();
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
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            key: _scaffoldKey,
            floatingActionButton: IconButton(
              tooltip: 'Удалёные тесты',
              iconSize: 40,
              icon: CircleAvatar(
                radius: 50,
                backgroundColor: Constants.mainColor,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                // ignore: unawaited_futures
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: LinearProgressIndicator(
                        color: Constants.mainColor,
                      ),
                    );
                  },
                );
                await quizState.getDeletedQuizList();
                Navigator.of(context).pop();
                await showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: quizState.deletedQuizList.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 40,
                                    color: Constants.mainColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Container(
                                      child: Text(
                                        'Список удалённых тестов пуст',
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
                                  'Список удалённых тестов',
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
                                    for (var quiz in quizState.deletedQuizList)
                                      ListTile(
                                        title: Text(quiz!.quizName),
                                        trailing: ElevatedButton(
                                          child: Text('Восстановить'),
                                          onPressed: () async {
                                            // ignore: unawaited_futures
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  child:
                                                      LinearProgressIndicator(
                                                    color: Constants.mainColor,
                                                  ),
                                                );
                                              },
                                            );
                                            await quizState.recoverQuiz(
                                                quiz: quiz);
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                    );
                  },
                );
              },
            ),
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
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: quizState.quizList.length,
                              itemBuilder: ((context, index) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
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
                                        title: Text(quizState
                                            .quizList[index]!.quizName),
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
                                    IconButton(
                                      onPressed: () async {
                                        await quizState.setActiveQuiz(
                                          docId:
                                              quizState.quizList[index]!.docId,
                                          quizIds: quizState.quizList
                                              .map((e) => e!.docId)
                                              .toList(),
                                        );
                                        await Navigator.of(
                                                _scaffoldKey.currentContext!)
                                            .push(
                                          MaterialPageRoute(
                                            builder: (newContext) =>
                                                QuizMainMenu(),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.play_arrow,
                                        color: Constants.mainColor,
                                        size: 36,
                                      ),
                                    )
                                  ],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }
}
