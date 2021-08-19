import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FacultyPage extends StatefulWidget {
  var title = 'название';

  QueryDocumentSnapshot<Object?> faculty;

  FacultyPage({Key? key, required this.faculty}) : super(key: key);

  @override
  _FacultyPageState createState() => _FacultyPageState();
}

class _FacultyPageState extends State<FacultyPage> {
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();

    initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    double c_height = 150;
    double c_width = MediaQuery.of(context).size.width * 0.8;
    Color main_color = Color.fromRGBO(0, 94, 62, 0.8);
    Color sec_color = Color.fromRGBO(0, 79, 0, 0.3);

    showAlertDialog(BuildContext context, QueryDocumentSnapshot<Object?> item) {

      // set up the button
      Widget okButton = TextButton(
        child: Text("Понял!",
        style: TextStyle(
          color: main_color,
        ),),
        onPressed: () { Navigator.pop(context);},
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(item.get('name')),
        content: SingleChildScrollView(
          child: Text(item.get('about')),
        ),

        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.faculty.get('shortName')),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              (widget.faculty.get('imagePath') == '')
                  ? Text('Нет фото')
                  : Container(
                      // width: c_width,
                      height: c_height,
                      child: Image.network('${widget.faculty.get('imagePath')}',
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: main_color,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },

                      ),
                    ),
              Padding(padding: EdgeInsets.all(5.0),
                child: Text(widget.faculty.get('about'),
                  style: TextStyle(
                    fontSize: 16,
                  ),),),
              if(widget.faculty.get('shortName') != 'ВТФ')
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text('Наши специальности',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('specialties')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return Center(
                      child: CircularProgressIndicator(color: main_color,),
                    );
                    return ListView.builder(
                        // scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          QueryDocumentSnapshot<Object?> item =
                              snapshot.data!.docs[index];
                          if (widget.faculty.get('shortName') ==
                              item.get('facultyBased')) {
                            return Container(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Card(
                                    shadowColor: Colors.green,
                                    elevation: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // constraints: BoxConstraints.expand(),
                                          // width: c_width * 0.5,

                                          child: Wrap(
                                            children: [ Text(
                                                  item.get('name') + ':',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              Text(item.get('number'),style: TextStyle(
                                                fontSize: 18,
                                              ),),
                                            ],
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          child: ElevatedButton(onPressed: (){
                                            showAlertDialog(context, item);}, 
                                            style: ElevatedButton.styleFrom(primary: main_color),
                                            child: Text('Описание специальности'),
                                            ),),

                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Квалификация:'),
                                              Text(
                                                item.get('qualification'),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(5.0),
                                                side: BorderSide(
                                                  color: Color.fromRGBO(
                                                      0, 79, 0, 0.8),
                                                  width: 2.0,
                                                ),
                                              ),
                                              child:
                                              Column(
                                                children: [
                                                  Text('План приема 2021', style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 79, 0, 0.8),
                                                  ),),

                                                  Wrap(
                                                    alignment: WrapAlignment.center,
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      if(item.get('admission21_budget_full') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child: Container(
                                                            width: 70,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(item.get(
                                                                        'admission21_budget_full'),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                      ),),
                                                                    Icon(Icons.emoji_people)
                                                                  ],
                                                                ),
                                                                Text('Бюджет дневное')
                                                              ],
                                                            ),
                                                          ),),
                                                      if(item.get('admission21_paid_full') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child:
                                                          Container(
                                                            width: 70,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(item.get(
                                                                        'admission21_paid_full'),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                      ),),
                                                                    Icon(Icons.emoji_people)
                                                                  ],
                                                                ),
                                                                Text('Платное дневное')
                                                              ],
                                                            ),
                                                          ),),
                                                      if(item.get('admission21_budget_full_correspondence') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child:
                                                          Container(
                                                            width: 70,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(item.get(
                                                                        'admission21_budget_full_correspondence'),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                      ),),
                                                                    Icon(Icons.emoji_people)
                                                                  ],
                                                                ),
                                                                Text('Бюджет заочное')
                                                              ],
                                                            ),
                                                          ),),
                                                      if(item.get('admission21_paid_full_correspondence') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child:
                                                          Container(
                                                            width: 70,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(item.get(
                                                                        'admission21_paid_full_correspondence'),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                      ),),
                                                                    Icon(Icons.emoji_people)
                                                                  ],
                                                                ),
                                                                Text('Платное заочное')
                                                              ],
                                                            ),
                                                          ),),
                                                      if(item.get('admission21_budget_short') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child:
                                                          Container(
                                                            width: 100,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(item.get(
                                                                        'admission21_budget_short'),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                      ),),
                                                                    Icon(Icons.emoji_people)
                                                                  ],
                                                                ),
                                                                Text('Бюджет заочное (сокращенное)')
                                                              ],
                                                            ),
                                                          ),),
                                                      if(item.get('admission21_paid_short') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child:
                                                          Container(
                                                            width: 100,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(item.get(
                                                                        'admission21_paid_short'),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                      ),),
                                                                    Icon(Icons.emoji_people)
                                                                  ],
                                                                ),
                                                                Text('Платное заочное (сокращенное)')
                                                              ],
                                                            ),
                                                          ),),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(5.0),
                                                side: BorderSide(
                                                  color: Color.fromRGBO(
                                                      0, 79, 0, 0.8),
                                                  width: 2.0,
                                                ),
                                              ),
                                              child:Column(
                                                children: [
                                                  Text('Проходной балл 2020', style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 79, 0, 0.8),
                                                  ),),

                                                  Wrap(
                                                    alignment: WrapAlignment.center,
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      if(item.get('admission21_budget_full') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child: Container(
                                                            width: 70,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    (item.get('passScore20_budget_full')=='')
                                                                        ?Text('-')
                                                                    :Text(item.get('passScore20_budget_full'),
                                                                              style: TextStyle(fontSize: 18,),)

                                                                  ],
                                                                ),
                                                                Text('Бюджет дневное')
                                                              ],
                                                            ),
                                                          ),),
                                                      if(item.get('admission21_paid_full') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child:
                                                          Container(
                                                            width: 70,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    (item.get('passScore20_paid_full')=='')
                                                                    ?Text('-')
                                                                    :Text(item.get(
                                                                        'passScore20_paid_full'),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                      ),)
                                                                  ],
                                                                ),
                                                                Text('Платное дневное')
                                                              ],
                                                            ),
                                                          ),),
                                                      if(item.get('admission21_budget_full_correspondence') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child:
                                                          Container(
                                                            width: 70,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    (item.get('passScore20_budget_full_correspondence')=='')
                                                                    ?Text('-')
                                                                    :Text(item.get(
                                                                        'passScore20_budget_full_correspondence'),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                      ),)

                                                                  ],
                                                                ),
                                                                Text('Бюджет заочное')
                                                              ],
                                                            ),
                                                          ),),
                                                      if(item.get('admission21_paid_full_correspondence') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child:
                                                          Container(
                                                            width: 70,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    (item.get('passScore20_paid_full_correspondence')=='')
                                                                    ?Text('-')
                                                                    :Text(item.get(
                                                                        'passScore20_paid_full_correspondence'),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                      ),)

                                                                  ],
                                                                ),
                                                                Text('Платное заочное')
                                                              ],
                                                            ),
                                                          ),),
                                                      if(item.get('admission21_budget_short') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child:
                                                          Container(
                                                            width: 100,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    (item.get('passScore20_budget_short')=='')
                                                                    ?Text('-')
                                                                    :Text(item.get(
                                                                        'passScore20_budget_short'),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                      ),)

                                                                  ],
                                                                ),
                                                                Text('Бюджет заочное (сокращенное)')
                                                              ],
                                                            ),
                                                          ),),
                                                      if(item.get('admission21_paid_short') != '')
                                                        Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                          child:
                                                          Container(
                                                            width: 100,
                                                            child: Column(

                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    (item.get('passScore20_paid_short')=='')
                                                                    ?Text('-')
                                                                    :Text(item.get(
                                                                        'passScore20_paid_short'),
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                      ),)

                                                                  ],
                                                                ),
                                                                Text('Платное заочное (сокращенное)')
                                                              ],
                                                            ),
                                                          ),),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Padding(padding: EdgeInsets.only(left: 5),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    if(item.get('trainingDuration_full')!='')
                                                      Column(children: [
                                                        Padding(padding: EdgeInsets.all(5),
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            width: 80,
                                                            color: sec_color,
                                                            child: Text('ПОЛНОЕ'),
                                                          ),),
                                                        Text('Срок обучения:'),
                                                        Text(item.get('trainingDuration_full'),
                                                        style: TextStyle(fontWeight: FontWeight.bold),),
                                                        if(item.get('trainingDuration_full_correspondence') != '')
                                                          Text(item.get('trainingDuration_full_correspondence'),
                                                            style: TextStyle(fontWeight: FontWeight.bold),),
                                                      ],),
                                                    if(item.get('trainingDuration_short')!='')
                                                      Column(mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                        Padding(padding: EdgeInsets.all(5),
                                                          child: Container(
                                                            alignment: Alignment.center,
                                                            width: 130,
                                                            color: sec_color,
                                                            child: Text('СОКРАЩЕННОЕ'),
                                                          ),),
                                                        Text('Срок обучения:'),
                                                        Text(item.get('trainingDuration_short'),
                                                          style: TextStyle(fontWeight: FontWeight.bold),),
                                                        if(item.get('trainingDuration_short_correspondence') != '')
                                                          Text(item.get('trainingDuration_short_correspondence'),
                                                            style: TextStyle(fontWeight: FontWeight.bold),),
                                                      ],),
                                                  ],
                                                ),

                                              ],
                                            ),)

                                        ),
                                        if(item.get('entranceTests_full')!='')
                                        Padding(padding: EdgeInsets.only(top: 10, left: 5, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Вступительные испытания (полное):'),
                                              Text(item.get('entranceTests_full'),
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              )
                                            ],
                                          ),),
                                        if(item.get('entranceTests_short')!='')
                                        Padding(padding: EdgeInsets.only(left: 5, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Вступительные испытания (сокращенное):'),
                                              Text(item.get('entranceTests_short'),
                                                style: TextStyle(fontWeight: FontWeight.bold),)
                                            ],
                                          ),),
                                      ],
                                    ),
                                  )),

                            );
                          }

                          return Container();
                        });
                  })
            ],
          ),
        ));
  }
}
