import 'package:bntu_app/core/provider/theme_provider.dart';
import 'package:bntu_app/features/admission_info/ui/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/provider/app_provider.dart';
import '../provider/admission_info_provider.dart';
import 'info_add.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainColor = Constants.mainColor;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    final appState = context.watch<AppProvider>();

    return Consumer<AdmissionInfoProvider>(builder: (context, state, child) {
      return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Text('Как поступить?'),

          actions: [
            appState.user != null
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
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 650,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'БЕЛОРУССКИЙ НАЦИОНАЛЬНЫЙ ТЕХНИЧЕСКИЙ УНИВЕРСИТЕТ',
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
                        image: Image.asset((themeProvider.brightness ==
                                    CustomBrightness.light)
                                ? 'assets/BNTU_Logo.png'
                                : 'assets/bntu_logo_dark.png')
                            .image,
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
                    user: appState.user,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
