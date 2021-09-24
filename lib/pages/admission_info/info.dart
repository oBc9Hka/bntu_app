import 'package:bntu_app/models/info_cards_model.dart';
import 'package:bntu_app/pages/admission_info/info_edit.dart';
import 'package:bntu_app/util/auth_service.dart';
import 'package:bntu_app/util/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'info_add.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  AuthService _authService = AuthService();
  User? _user;

  InfoCard _info = InfoCard();

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
    const Color mainColor = Color.fromARGB(255, 0, 138, 94); // green color
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('Как поступить?'),

        actions: [
          _user != null
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdmissionInfoAdd(),
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
                  color: mainColor, fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('infoCards')
                .orderBy('orderId')
                .snapshots(),
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
              _info.getNewOrderId();
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
                    return Card(
                      margin: EdgeInsets.all(10),
                      shadowColor: mainColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: mainColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ListTile(
                          title: Text(item['title'] as String,
                              style: TextStyle(fontSize: 20)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(item['subtitle'] as String),
                          ),
                          leading: _user != null
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
                              : Icon(Icons.check_box_outlined,
                                  color: mainColor, size: 45),
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
