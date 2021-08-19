import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color main_color = Color.fromRGBO(0, 94, 66, 0.8);

    Widget buttonSection = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Padding(padding: EdgeInsets.only(left: 30)),
            Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: 20),
                child: ButtonTheme(
                  minWidth: 220.0,
                  height: 50.0,
                  child:
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/main_page');},
                    label: Text('Выбери факультет'),
                    icon: Icon(Icons.account_balance_outlined),
                    color: Colors.white,
                    textColor: main_color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: main_color)
                    ),

                    elevation: 10,
                  ),
                ),),

                ButtonTheme(
                  minWidth: 220.0,
                  height: 50.0,
                  child:
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/info');},
                    label: Text('Узнай как поступить'),
                    icon: Icon(Icons.article_outlined),
                    color: Colors.white,
                    textColor: main_color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: main_color)
                    ),
                    elevation: 10,
                  ),
                ),

                ButtonTheme(
                  minWidth: 220.0,
                  height: 50.0,
                  child:
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/map');},
                    label: Text('Карта корпусов'),
                    icon: Icon(Icons.article_outlined),
                    color: Colors.white,
                    textColor: main_color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: main_color)
                    ),
                    elevation: 10,
                  ),
                ),
              ],
            ),
            // Padding(padding: EdgeInsets.only(left: 70)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ButtonTheme(
                  minWidth: 50.0,
                  height: 50.0,
                  child:
                  RaisedButton.icon(
                    onPressed: () {
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text ('Наш телефон',  style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700 ) ),
                          content: Text('+375449652698',  style: TextStyle(
                              color: main_color,
                              fontSize: 15,
                              fontWeight: FontWeight.w700 )),);
                      });},
                    label: Text(''),
                    icon: Icon(Icons.call),
                    color: Colors.white,
                    textColor: main_color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: main_color)
                    ),

                    elevation: 10,
                  ),

                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                ButtonTheme(
                  minWidth: 50.0,
                  height: 50.0,
                  child:
                  RaisedButton.icon(
                    onPressed: () {
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text ('Наша почта',  style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700 )),
                          content: Text('bntu@gmail.com', style: TextStyle(
                              color: main_color,
                              fontSize: 15,
                              fontWeight: FontWeight.w700 )),);
                      });},
                    label: Text(''),
                    icon: Icon(Icons.mail),
                    color: Colors.white,
                    textColor: main_color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: main_color)
                    ),

                    elevation: 10,
                  ),

                ),
              ],
            ),
          ],
        )
    );

    Widget textSection = Container(
      padding: const EdgeInsets.fromLTRB(30,0,50,30),
      child:
      const ListTile(
        title: Text('АБИТУРИЕНТ?',  style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.w700
        )
        ),

        subtitle: Text('Приходи, ждём!',  style: TextStyle(
            color: main_color,
            fontSize: 25,
            fontWeight: FontWeight.w500),
        ),
      ),
    );

    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/bntu.png?alt=media&token=5c28bbf8-4344-4882-b295-24fa09ee8343'
              ),
            ),
          ],
        ),

      ),

      body: ListView(
        children: [
          // Padding(padding: EdgeInsets.only(left: 40)),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("БЕЛОРУССКИЙ НАЦИОНАЛЬНЫЙ ТЕХНИЧЕСКИЙ УНИВЕРСИТЕТ",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: height/2.3,
            alignment: Alignment.center,
            child: Image.network('https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/man.jpg?alt=media&token=088ad587-837c-4d41-85b0-25bd3c595bf4',
              fit: BoxFit.cover,
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
          textSection,
          buttonSection,
        ],
      ),
    );
  }
}
