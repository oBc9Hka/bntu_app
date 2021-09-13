import 'package:bntu_app/models/speciality_model.dart';
import 'package:bntu_app/pages/speciality_views/speciality_edit.dart';
import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/themes/material_themes.dart';
import 'package:bntu_app/util/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecialityCard extends StatelessWidget {
  const SpecialityCard({Key? key, required this.item, this.user}) : super(key: key);
  final QueryDocumentSnapshot<Object?> item;
  final User? user;
  static const Color mainColor = Color.fromARGB(255, 0, 138, 94);
  static const Color inactiveColor = Colors.grey;

  static Color _secColor = Colors.grey;
  static Color _titleBackColor = Colors.white;

  showAlertDialog(BuildContext context, QueryDocumentSnapshot<Object?> item) {
    Widget okButton = TextButton(
      child: Text(
        "Понял!",
        style: TextStyle(
          color: mainColor,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(item.get('name')),
      content: SingleChildScrollView(
        child: Text(item.get('about')),
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
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      Text(
                        item.get('name') + ':',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        item.get('number'),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  user != null
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    SpecialityAdd(speciality: item)));
                          },
                          icon: Icon(Icons.edit))
                      : Container(),
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
                    item.get('qualification'),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              specGridCard(
                  list: Speciality().admissionsCurrentYearList,
                  title: 'План приёма 2021',
                  dbField: 'admission',
                  icon: Icons.emoji_people,
                  context: context),
              specGridCard(
                  list: Speciality().passScorePrevYearList,
                  title: 'Проходные баллы 2020',
                  dbField: 'passScore',
                  context: context),
              specGridCard(
                  list: Speciality().admissionsPrevYearList,
                  title: 'План приёма 2020',
                  dbField: 'admission',
                  icon: Icons.emoji_people,
                  isNotActive: true,
                  context: context),
              specGridCard(
                  list: Speciality().passScoreBeforeLastYearList,
                  title: 'Проходные баллы 2019',
                  dbField: 'passScore',
                  isNotActive: true,
                  context: context),
              Row(
                children: [
                  if (item.get('trainingDurationDayFull') != '' ||
                      item.get('trainingDurationCorrespondenceFull') != '')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 80,
                          color: _secColor,
                          child: Text('ПОЛНОЕ'),
                        ),
                        if (item.get('trainingDurationDayFull') != '')
                          Text('Срок обучения:'),
                        Text(
                          item.get('trainingDurationDayFull'),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (item.get('trainingDurationCorrespondenceFull') !=
                            '')
                          Text('Срок обучения:'),
                        Text(
                          item.get('trainingDurationCorrespondenceFull'),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  if (item.get('trainingDurationDayShort') != '' ||
                      item.get('trainingDurationCorrespondenceShort') != '')
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
                          if (item.get('trainingDurationDayShort') != '')
                            Text('Срок обучения:'),
                          Text(
                            item.get('trainingDurationDayShort'),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (item.get('trainingDurationCorrespondenceShort') !=
                              '')
                            Text('Срок обучения:'),
                          Text(
                            item.get('trainingDurationCorrespondenceShort'),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              if (item.get('entranceTestsFull').isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Вступительные экзамены (полное)'),
                    Text(
                      getStringFromList('entranceTestsFull'),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              if (item.get('entranceShort').isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Вступительные экзамены (сокращенное)'),
                    Text(
                      getStringFromList('entranceShort'),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  String getStringFromList(String field) {
    List temp = item.get(field);
    String tempString = '';
    for (int i = 0; i < temp.length; i++) {
      tempString += '_${temp[i]}';
    }

    String newTempString = tempString.replaceFirst('_', ' ');
    newTempString = newTempString.trim();
    return newTempString.replaceAll('_', ' • ');
  }

  Widget specGridCard({
    required List<Map<String, String>> list,
    required String title,
    required String dbField,
    IconData? icon,
    bool isNotActive = false,
    required BuildContext context,
  }) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 3,),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(
                    color: isNotActive ? inactiveColor : mainColor, width: 2.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        ...list.map(
                          (spec) => (item.get('${spec[dbField]}') != '')
                              ? Container(
                                  width: 76,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.get('${spec[dbField]}'),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color:
                                                  isNotActive ? inactiveColor : null,
                                            ),
                                          ),
                                          icon != null
                                              ? Icon(
                                                  icon,
                                                  color: isNotActive
                                                      ? inactiveColor
                                                      : null,
                                                )
                                              : Container(),
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
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  )
                ],
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
