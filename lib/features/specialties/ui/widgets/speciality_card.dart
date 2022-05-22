import 'package:bntu_app/features/specialties/domain/models/speciality_model.dart';
import 'package:bntu_app/core/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/themes/material_themes.dart';
import '../../domain/models/admission_places.dart';

class SpecialityCard extends StatelessWidget {
  const SpecialityCard(
      {Key? key, required this.item, required this.user, this.onEditPressed})
      : super(key: key);
  final Speciality item;
  final user;
  static const Color mainColor = Color.fromARGB(255, 0, 138, 94);
  static const Color inactiveColor = Colors.grey;
  final Function()? onEditPressed;

  static Color _secColor = Colors.grey;
  static Color _titleBackColor = Colors.white;

  void showAlertDialog(BuildContext context, Speciality item) {
    Widget okButton = TextButton(
      child: Text(
        'Закрыть',
        style: TextStyle(
          color: mainColor,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    var alert = AlertDialog(
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
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: getAdmissionsCount(item),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (!item.admissions[index].scores.isEmpty())
                            specGridCard(
                                list: _getInfo(item.admissions[index].scores),
                                title:
                                    'Проходные баллы ${item.admissions[index].year}',
                                context: context),
                          if (!item.admissions[index].places.isEmpty())
                            specGridCard(
                                list: _getInfo(item.admissions[index].places),
                                title:
                                    'План приёма ${item.admissions[index].year}',
                                icon: Icons.emoji_people,
                                context: context),
                        ],
                      );
                    },
                  ),
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
                  if (item.entranceTestsFull.isNotEmpty)
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
                  if (item.entranceShort.isNotEmpty)
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
              child:
                  IconButton(onPressed: onEditPressed, icon: Icon(Icons.edit)),
            ),
        ],
      ),
    );
  }

  int getAdmissionsCount(Speciality item) {
    if (item.admissions.isNotEmpty && item.admissions.length > 1) {
      if (true) {
        return item.admissions.first.scores.isEmpty() ? 3 : 2;
      }
    } else {
      return item.admissions.length;
    }
  }

  String getStringFromList(List<dynamic>? temp) {
    var tempString = '';
    for (var i = 0; i < temp!.length; i++) {
      tempString += '_${temp[i]}';
    }

    var newTempString = tempString.replaceFirst('_', ' ');
    newTempString = newTempString.trim();
    return newTempString.replaceAll('_', ' • ');
  }

  List<Map<String, dynamic>> _getInfo(AdmissionInfo model) {
    return [
      {'num': model.day.fullBudget, 'description': 'Бюджет дневное'},
      {
        'num': model.day.shortBudget,
        'description': 'Бюджет дневное (сокращенное)'
      },
      {'num': model.day.fullPaid, 'description': 'Платное дневное'},
      {
        'num': model.day.shortPaid,
        'description': 'Платное дневное (сокращенное)'
      },
      {'num': model.correspondence.fullBudget, 'description': 'Бюджет заочное'},
      {
        'num': model.correspondence.shortBudget,
        'description': 'Бюджет заочное (сокращенное)'
      },
      {'num': model.correspondence.fullPaid, 'description': 'Платное заочное'},
      {
        'num': model.correspondence.shortPaid,
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
                          if (spec['num'].toString() != '') {
                            return Container(
                              // color: Colors.green,
                              width: 70,
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
                                      fontSize: 9,
                                      color: isNotActive ? inactiveColor : null,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
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
