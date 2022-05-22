import 'package:bntu_app/features/faculties/domain/models/faculty_model.dart';
import 'package:bntu_app/features/specialties/domain/models/speciality_model.dart';
import 'package:bntu_app/features/specialties/ui/speciality_add.dart';
import 'package:bntu_app/core/provider/theme_provider.dart';
import 'package:bntu_app/features/specialties/ui/speciality_edit.dart';
import 'package:bntu_app/features/specialties/ui/widgets/speciality_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/provider/app_provider.dart';
import '../provider/specialties_provider.dart';

class SpecialtiesScreen extends StatelessWidget {
  final Faculty faculty;
  final String? qualificationNeedToShow;

  SpecialtiesScreen({
    Key? key,
    required this.faculty,
    this.qualificationNeedToShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainColor = Constants.mainColor;
    var themeProvider = Provider.of<ThemeProvider>(context);
    final appState = context.watch<AppProvider>();

    return Consumer<SpecialtiesProvider>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(faculty.shortName.toString()),
            actions: [
              appState.user != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              state.setSpecialityInEdit(
                                Speciality(
                                  facultyBased: faculty.shortName,
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SpecialityAdd(),
                                ),
                              );
                            },
                            icon: Icon(Icons.add)),
                        IconButton(
                            onPressed: () {
                              state.getSpecialties(
                                qualificationNeedToShow:
                                    qualificationNeedToShow != null
                                        ? [qualificationNeedToShow!]
                                        : null,
                              );
                            },
                            icon: Icon(Icons.refresh)),
                      ],
                    )
                  : Container()
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 600,
                  ),
                  child: Column(
                    children: [
                      if (faculty.imagePath == '')
                        Text('Нет фото')
                      else
                        Stack(
                          children: [
                            Container(
                              height: 180,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    '${faculty.imagePath}',
                                  ).image,
                                ),
                              ),
                            ),
                          ],
                        ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          faculty.about.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      state.isLoading
                          ? SizedBox(
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : state.specialties.isEmpty
                              ? Center(
                                  child: Text('Список специальностей пуст'),
                                )
                              : Column(
                                  children: [
                                    if (faculty.shortName != 'ВТФ')
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Text(
                                          'Наши специальности',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.specialties.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (state.specialties[index]
                                                  .facultyBased ==
                                              faculty.shortName) {
                                            return SpecialityCard(
                                              currentYear: int.parse(
                                                  state.currentAdmissionYear),
                                              item: state.specialties[index],
                                              user: appState.user,
                                              onEditPressed: () {
                                                state.setSpecialityInEdit(
                                                  state.specialties[index],
                                                );
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SpecialityEdit(),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                          return Container();
                                        }),
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                  ],
                                )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: (themeProvider.brightness == CustomBrightness.dark)
                          ? Colors.black
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 0.1,
                          blurRadius: 5,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Горячая линия',
                            style: TextStyle(color: Colors.red)),
                        Text(faculty.hotLineNumber.toString(),
                            style: TextStyle(fontSize: 20)),
                        Text(faculty.hotLineMail.toString()),
                        Text('\nПо вопросам получения справок',
                            style: TextStyle(color: mainColor)),
                        Text(faculty.forInquiriesNumber.toString(),
                            style: TextStyle(fontSize: 20)),
                        Text('\nПо вопросам заселения в общежитие',
                            style: TextStyle(color: mainColor)),
                        Text(faculty.forHostelNumber.toString(),
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
