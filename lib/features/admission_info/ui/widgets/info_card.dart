import 'package:bntu_app/features/admission_info/domain/models/info_cards_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/admission_info_provider.dart';
import '../info_edit.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({
    Key? key,
    required this.list,
    required this.user,
  }) : super(key: key);

  final List<InfoCard> list;
  final user;

  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants.mainColor;

    Widget customTile(
      String title,
      String subtitle,
      InfoCard item,
    ) {
      return ListTile(
        title: Text(title, style: TextStyle(fontSize: 20)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(subtitle),
        ),
        leading: user != null
            ? IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdmissionInfoEdit(
                        infoCard: item,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: mainColor,
                ),
              )
            : Icon(Icons.check_box_outlined, color: mainColor, size: 45),
      );
    }

    Widget _customTileWithoutSubtitle(
      String title,
      InfoCard item,
    ) {
      return ListTile(
        title: Text(title, style: TextStyle(fontSize: 20)),
        leading: user != null
            ? IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdmissionInfoEdit(
                        infoCard: item,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: mainColor,
                ),
              )
            : Icon(Icons.check_box_outlined, color: mainColor, size: 45),
      );
    }

    return Consumer<AdmissionInfoProvider>(
      builder: (context, state, child) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: EdgeInsets.all(10),
              shadowColor: mainColor,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: mainColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    if (list[index].subtitle != '')
                      customTile(list[index].title.toString(),
                          list[index].subtitle.toString(), list[index])
                    else
                      _customTileWithoutSubtitle(
                          list[index].title.toString(), list[index]),
                    if (user != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              try {
                                state.moveUpInfoCard(
                                  state.infoCards[index].docId.toString(),
                                  state.infoCards[index - 1].docId.toString(),
                                );
                              } catch (e) {}
                            },
                            tooltip: 'Поднять в списке',
                            icon: Icon(
                              Icons.arrow_upward,
                              color: mainColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              try {
                                state.moveDownInfoCard(
                                  state.infoCards[index].docId.toString(),
                                  state.infoCards[index + 1].docId.toString(),
                                );
                              } catch (e) {}
                            },
                            tooltip: 'Опустить в списке',
                            icon: Icon(
                              Icons.arrow_downward,
                              color: mainColor,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
