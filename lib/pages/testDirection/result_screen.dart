import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main_menu.dart';

class ResultScreen extends StatefulWidget {
  int score1Arxitech, score2Fitr, score3Tech, score4Sport, score5Gum, score6Nature;

  ResultScreen(this.score1Arxitech, this.score2Fitr, this.score3Tech, this.score4Sport,
      this.score5Gum, this.score6Nature,
      {Key? key})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final Color mainColor = Color.fromARGB(255, 0, 138, 94); // green color
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('Tест'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              "Результат теста:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "ты набрал \n${widget.score1Arxitech} - для поступления на архитектурный "
                "\n${widget.score2Fitr} - на Фитр \n${widget.score3Tech} - на АТФ, МТФ, ПСФ\n"
                "${widget.score4Sport} - На военный или спортивно-технический\n"
                "${widget.score5Gum} - на ФММП/ управления и гуманитризации"
                "\n${widget.score6Nature} - на горное дело",
            style: TextStyle(
              color: mainColor,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          RawMaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainMenu(),
                  ));
            },
            fillColor: Colors.white,
            elevation: 10,
            shape: StadiumBorder(),
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Reapeat the quizz",
              style: TextStyle(color: mainColor),
            ),
          ),
        ],
      ),
    );
  }
}
