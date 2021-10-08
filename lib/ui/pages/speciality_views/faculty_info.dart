import 'package:bntu_app/models/faculty_model.dart';
import 'package:bntu_app/providers/theme_provider.dart';
import 'package:bntu_app/ui/pages/speciality_views/speciality_add.dart';
import 'package:bntu_app/ui/widgets/speciality_card.dart';
import 'package:bntu_app/util/auth_service.dart';
import 'package:bntu_app/util/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacultyPage extends StatefulWidget {
  final Faculty faculty;

  FacultyPage({Key? key, required this.faculty}) : super(key: key);

  @override
  _FacultyPageState createState() => _FacultyPageState();
}

class _FacultyPageState extends State<FacultyPage> {
  AuthService _authService = AuthService();
  User? _user;
  String _currentYear = '';

  Future<void> _getUser() async {
    final user = await _authService.getCurrentUser();
    setState(() {
      _user = user as User;
    });
  }

  Future<void> _getSettingsData() async {
    _currentYear = await Data()
        .getCurrentAdmissionYear()
        .whenComplete(() => setState(() {}));
}

  @override
  void initState() {
    _getUser();
    _getSettingsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color.fromARGB(255, 0, 138, 94); // green color;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.faculty.shortName.toString()),
        actions: [
          _user != null
              ? IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SpecialityAdd(
                    //       faculty: widget.faculty,
                    //     ),
                    //   ),
                    // );
                  },
                  icon: Icon(Icons.add))
              : Container()
        ],
      ),
      //TODO: show at map
      body: SingleChildScrollView(
        child: Column(
          children: [
            (widget.faculty.imagePath == '')
                ? Text('Нет фото')
                : Container(
                    height: 150,
                    child: Image.network(
                      '${widget.faculty.imagePath}',
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: mainColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                widget.faculty.about.toString(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            if (widget.faculty.shortName != 'ВТФ')
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  'Наши специальности',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('specialties')
                  .orderBy('name')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  );
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Object?> item =
                        snapshot.data!.docs[index];
                    if (widget.faculty.shortName ==
                        item.get('facultyBased')) {
                      return SpecialityCard(
                        item: item,
                        user: _user,
                        currentYear: int.parse(_currentYear),
                      );
                    }

                    return Container();
                  },
                );
              },
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
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
                    Text('Горячая линия', style: TextStyle(color: Colors.red)),
                    Text(widget.faculty.hotLineNumber.toString(),
                        style: TextStyle(fontSize: 20)),
                    Text(widget.faculty.hotLineMail.toString()),
                    Text('\nПо вопросам получения справок',
                        style: TextStyle(color: mainColor)),
                    Text(widget.faculty.forInquiriesNumber.toString(),
                        style: TextStyle(fontSize: 20)),
                    Text('\nПо вопросам заселения в общежитие',
                        style: TextStyle(color: mainColor)),
                    Text(widget.faculty.forHostelNumber.toString(),
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
