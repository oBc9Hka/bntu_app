import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/constants/constants.dart';
import 'package:bntu_app/ui/widgets/info_card.dart';
import 'package:bntu_app/util/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'info_add.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  AuthService _authService = AuthService();
  User? _user;


  Future<void> _getUser() async {
    final user = await _authService.getCurrentUser();
    setState(() {
      _user = user as User;
    });
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants().mainColor;
    double height = MediaQuery.of(context).size.height;

    return Consumer<AppProvider>(builder: (context, state, child) {
      return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Text('Как поступить?'),

          actions: [
            _user != null
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
                user: _user,
              ),
          ],
        ),
      );
    });
  }
}
