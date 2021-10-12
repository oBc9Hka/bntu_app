import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/widgets/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'info_add.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants.mainColor;
    double height = MediaQuery.of(context).size.height;

    return Consumer<AppProvider>(builder: (context, state, child) {
      return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Text('Как поступить?'),

          actions: [
            state.user != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdmissionInfoAdd(),
                              ),
                            );
                          },
                          icon: Icon(Icons.add)),
                      IconButton(
                          onPressed: () {
                            state.initInfoCards();
                          },
                          icon: Icon(Icons.refresh)),
                    ],
                  )
                : Container()
          ],
        ),
        body: ListView(
          // scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "БЕЛОРУССКИЙ НАЦИОНАЛЬНЫЙ ТЕХНИЧЕСКИЙ УНИВЕРСИТЕТ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: height / 3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset('assets/bntu_logo.png').image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'СТАНЬ СТУДЕНТОМ БНТУ!',
                style: TextStyle(
                    color: mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            InfoCardWidget(
                list: state.infoCards,
                user: state.user,
              ),
          ],
        ),
      );
    });
  }
}
