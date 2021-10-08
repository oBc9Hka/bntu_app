import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/pages/speciality_views/faculty_info.dart';
import 'package:bntu_app/ui/widgets/faculty_item.dart';
import 'package:bntu_app/util/auth_service.dart';
import 'package:bntu_app/util/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'faculty_add.dart';
import 'faculty_edit.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
    return Consumer<AppProvider>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Список факультетов'),
            elevation: 3,
            // actions: [
            //   _user != null
            //       ? IconButton(
            //           onPressed: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) => FacultyAdd(),
            //               ),
            //             );
            //           },
            //           icon: Icon(Icons.add))
            //       : Container()
            // ],
          ),
          body: (!state.isFacultiesLoaded)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: state.faculties.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: FacultyItem(
                        shortName: state.faculties[index].shortName.toString(),
                        name: state.faculties[index].name.toString(),
                        user: _user,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FacultyPage(
                                faculty: state.faculties[index],
                              ),
                            ),
                          );
                        },
                        onEditPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => FacultyEdit(
                          //       faculty: item,
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
