import 'package:bntu_app/models/speciality_model.dart';
import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/ui/themes/material_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecialityCard extends StatelessWidget {
  const SpecialityCard(
      {Key? key,
      required this.item,
      required this.user,
      required this.currentYear})
      : super(key: key);
  final Speciality item;
  final user;
  static const Color mainColor = Color.fromARGB(255, 0, 138, 94);
  static const Color inactiveColor = Colors.grey;
  final int currentYear;

  static Color _secColor = Colors.grey;
  static Color _titleBackColor = Colors.white;

  showAlertDialog(BuildContext context, Speciality item) {
    Widget okButton = TextButton(
      child: Text(
        "Закрыть",
        style: TextStyle(
          color: mainColor,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(item.name.toString()),
      content: SingleChildScrollView(
        child: Text(item.about.toString()),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    (themeProvider.brightness == CustomBrightness.light)
        ? _secColor = Color.fromRGBO(0, 79, 0, 0.3)
        : _secColor = Colors.black12;
    (themeProvider.brightness == CustomBrightness.light)
        ? _titleBackColor = Colors.white
        : _titleBackColor = themeDark.cardColor;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    children: [
                      Text(
                        item.name! + ':',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        item.number.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showAlertDialog(context, item);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: mainColor,
                    ),
                    child: Text(
                      'Описание специальности',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Квалификация:'),
                      Text(
                        item.qualification.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  specGridCard(
                      list: _getAdmissionsCurrentYearList(),
                      title: 'План приёма $currentYear',
                      icon: Icons.emoji_people,
                      context: context),
                  specGridCard(
                      list: _getPassScorePrevYearList(),
                      title: 'Проходные баллы ${currentYear - 1}',
                      context: context),
                  specGridCard(
                      list: _getAdmissionsPrevYearList(),
                      title: 'План приёма ${currentYear - 1}',
                      icon: Icons.emoji_people,
                      isNotActive: true,
                      context: context),
                  specGridCard(
                      list: _getPassScoreBeforeLastYearList(),
                      title: 'Проходные баллы ${currentYear - 2}',
                      isNotActive: true,
                      context: context),
                  Row(
                    children: [
                      if (item.trainingDurationDayFull != '' ||
                          item.trainingDurationCorrespondenceFull != '')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 80,
                              color: _secColor,
                              child: Text('ПОЛНОЕ'),
                            ),
                            Text('Срок обучения:'),
                            if (item.trainingDurationDayFull != '')
                              Text(
                                '${item.trainingDurationDayFull} (дневное)',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            if (item.trainingDurationCorrespondenceFull != '')
                              Text(
                                '${item.trainingDurationCorrespondenceFull} (заочное)',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                          ],
                        ),
                      if (item.trainingDurationDayShort != '' ||
                          item.trainingDurationCorrespondenceShort != '')
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 130,
                                color: _secColor,
                                child: Text('СОКРАЩЕННОЕ'),
                              ),
                              Text('Срок обучения:'),
                              if (item.trainingDurationDayShort != '')
                                Text(
                                  '${item.trainingDurationDayShort} (дневное)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              if (item.trainingDurationCorrespondenceShort !=
                                  '')
                                Text(
                                  '${item.trainingDurationCorrespondenceShort} (заочное)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                            ],
                          ),
                        )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  if (item.entranceTestsFull!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Вступительные экзамены (полное)'),
                        Text(
                          getStringFromList(item.entranceTestsFull),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  if (item.entranceShort!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Вступительные экзамены (сокращенное)'),
                        Text(
                          getStringFromList(item.entranceShort),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          if (user != null)
            Positioned(
              right: 5,
              child: IconButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => SpecialityAdd(faculty: item)));
                  },
                  icon: Icon(Icons.edit)),
            ),
        ],
      ),
    );
  }

  String getStringFromList(List<dynamic>? temp) {
    String tempString = '';
    for (int i = 0; i < temp!.length; i++) {
      tempString += '_${temp[i]}';
    }

    String newTempString = tempString.replaceFirst('_', ' ');
    newTempString = newTempString.trim();
    return newTempString.replaceAll('_', ' • ');
  }

  List<Map<String, dynamic>> _getAdmissionsCurrentYearList(){
    return [
      {
        'num': item.admissionCurrentDayFullBudget,
        'description': 'Бюджет дневное'
      },
      {
        'num': item.admissionCurrentDayShortBudget,
        'description': 'Бюджет дневное (сокращенное)'
      },
      {
        'num': item.admissionCurrentDayFullPaid,
        'description': 'Платное дневное'
      },
      {
        'num': item.admissionCurrentDayShortPaid,
        'description': 'Платное дневное (сокращенное)'
      },
      {
        'num': item.admissionCurrentCorrespondenceFullBudget,
        'description': 'Бюджет заочное'
      },
      {
        'num': item.admissionCurrentCorrespondenceShortBudget,
        'description': 'Бюджет заочное (сокращенное)'
      },
      {
        'num': item.admissionCurrentCorrespondenceFullPaid,
        'description': 'Платное заочное'
      },
      {
        'num': item.admissionCurrentCorrespondenceShortPaid,
        'description': 'Платное заочное (сокращенное)'
      },
    ];
  }

  List<Map<String, dynamic>> _getPassScorePrevYearList() {
    return [
      {
        'num': item.passScorePrevYearDayFullBudget,
        'description': 'Бюджет дневное'
      },
      {
        'num': item.passScorePrevYearDayShortBudget,
        'description': 'Бюджет дневное (сокращенное)'
      },
      {
        'num': item.passScorePrevYearDayFullPaid,
        'description': 'Платное дневное'
      },
      {
        'num': item.passScorePrevYearDayShortPaid,
        'description': 'Платное дневное (сокращенное)'
      },
      {
        'num': item.passScorePrevYearCorrespondenceFullBudget,
        'description': 'Бюджет заочное'
      },
      {
        'num': item.passScorePrevYearCorrespondenceShortBudget,
        'description': 'Бюджет заочное (сокращенное)'
      },
      {
        'num': item.passScorePrevYearCorrespondenceFullPaid,
        'description': 'Платное заочное'
      },
      {
        'num': item.passScorePrevYearCorrespondenceShortPaid,
        'description': 'Платное заочное (сокращенное)'
      },
    ];
  }

  List<Map<String, dynamic>> _getAdmissionsPrevYearList() {
    return [
      {
        'num': item.admissionPrevYearDayFullBudget,
        'description': 'Бюджет дневное'
      },
      {
        'num': item.admissionPrevYearDayShortBudget,
        'description': 'Бюджет дневное (сокращенное)'
      },
      {
        'num': item.admissionPrevYearDayFullPaid,
        'description': 'Платное дневное'
      },
      {
        'num': item.admissionPrevYearDayShortPaid,
        'description': 'Платное дневное (сокращенное)'
      },
      {
        'num': item.admissionPrevYearCorrespondenceFullBudget,
        'description': 'Бюджет заочное'
      },
      {
        'num': item.admissionPrevYearCorrespondenceShortBudget,
        'description': 'Бюджет заочное (сокращенное)'
      },
      {
        'num': item.admissionPrevYearCorrespondenceFullPaid,
        'description': 'Платное заочное'
      },
      {
        'num': item.admissionPrevYearCorrespondenceShortPaid,
        'description': 'Платное заочное (сокращенное)'
      },
    ];
  }



  List<Map<String, String>> _getPassScoreBeforeLastYearList() {
    return [
      {
        'num': item.passScoreBeforeLastYearDayFullBudget.toString(),
        'description': 'Бюджет дневное'
      },
      {
        'num': item.passScoreBeforeLastYearDayShortBudget.toString(),
        'description': 'Бюджет дневное (сокращенное)'
      },
      {
        'num': item.passScoreBeforeLastYearDayFullPaid.toString(),
        'description': 'Платное дневное'
      },
      {
        'num': item.passScoreBeforeLastYearDayShortPaid.toString(),
        'description': 'Платное дневное (сокращенное)'
      },
      {
        'num': item.passScoreBeforeLastYearCorrespondenceFullBudget.toString(),
        'description': 'Бюджет заочное'
      },
      {
        'num': item.passScoreBeforeLastYearCorrespondenceShortBudget.toString(),
        'description': 'Бюджет заочное (сокращенное)'
      },
      {
        'num': item.passScoreBeforeLastYearCorrespondenceFullPaid.toString(),
        'description': 'Платное заочное'
      },
      {
        'num': item.passScoreBeforeLastYearCorrespondenceShortPaid.toString(),
        'description': 'Платное заочное (сокращенное)'
      },
    ];
  }

  Widget specGridCard({
    required List<Map<String, dynamic>> list,
    required String title,
    IconData? icon,
    bool isNotActive = false,
    required BuildContext context,
  }) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 3,
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(
                      color: isNotActive ? inactiveColor : mainColor,
                      width: 2.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      ...list.map(
                        (spec) {
                          if (spec['num'].toString() != '')
                            return Container(
                              // color: Colors.green,
                              width: 76,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        spec['num'].toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: isNotActive
                                              ? inactiveColor
                                              : null,
                                        ),
                                      ),
                                      if (icon != null)
                                        Icon(
                                          icon,
                                          color: isNotActive
                                              ? inactiveColor
                                              : null,
                                        ),
                                    ],
                                  ),
                                  Text(
                                    spec['description'].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isNotActive ? inactiveColor : null,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          return SizedBox(
                            height: 1,
                            width: 1,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Center(
              child: Text(
                ' $title ',
                style: TextStyle(
                  color: isNotActive ? inactiveColor : mainColor,
                  backgroundColor: _titleBackColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
