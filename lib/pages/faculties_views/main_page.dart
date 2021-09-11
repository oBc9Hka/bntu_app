import 'package:bntu_app/pages/faculties_views/faculty_add.dart';
import 'package:bntu_app/pages/faculties_views/faculty_edit.dart';
import 'package:bntu_app/pages/speciality_views/faculty_info.dart';
import 'package:bntu_app/util/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    const Color mainColor = Color.fromARGB(255, 0, 138, 94);
    return Scaffold(
      appBar: AppBar(
        title: Text('Список факультетов'),
        elevation: 3,
        actions: [
          _user != null
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FacultyAdd(),
                      ),
                    );
                  },
                  icon: Icon(Icons.add))
              : Container()
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('faculties').orderBy('shortName').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  ),
                );

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  // scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Object?> item =
                        snapshot.data!.docs[index];
                    if (index != snapshot.data!.docs.length)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      );
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        key: Key(snapshot.data!.docs[index].id),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FacultyPage(
                                faculty: item,
                              ),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: mainColor),
                        ),
                        leading: Container(
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text(
                            snapshot.data!.docs[index].get('shortName'),
                            style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        trailing: _user != null
                            ? IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FacultyEdit(
                                        faculty: item,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: mainColor,
                                ),
                              )
                            : Container(
                                width: 24,
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: mainColor,
                                ),
                              ),
                        title: Text(
                          snapshot.data!.docs[index].get('name'),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
