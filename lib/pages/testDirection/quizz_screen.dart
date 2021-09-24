import 'package:flutter/material.dart';
import 'questions_example.dart';
import 'result_screen.dart';
import 'quizz_widget.dart';
import 'question_model.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({Key? key}) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  int question_pos = 0;
  int score1Arxitech = 0;
  int score2Fitr = 0;
  int score3Tech = 0;
  int score4Sport = 0;
  int score5Gum = 0;
  int score6Nature = 0;

  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next Question";
  bool answered = false;

  get selecredIndex => null;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color.fromARGB(255, 0, 138, 94); // green color
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('Tест'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: PageView.builder(
            controller: _controller!,
            onPageChanged: (page) {
              if (page == questions.length - 1) {
                setState(() {
                  btnText = "See Results";
                });
              }
              setState(() {
                answered = false;
              });
            },
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Question ${index + 1}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  Divider(
                    color: mainColor,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 100.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: mainColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      shadowColor: mainColor,
                      elevation: 10,
                      child: Text(
                        "${questions[index].question}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  for (int i = 0; i < questions[index].answers!.length; i++)
                    Container(
                      width: double.infinity,
                      height: 70.0,
                      margin: EdgeInsets.only(bottom: 20.0, left: 12.0, right: 12.0),
                      child: RawMaterialButton(
                        fillColor: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        onPressed: () {
                          if (questions[index].answers!.values.toList()[i] == 1)
                            score1Arxitech++;
                          else if (questions[index].answers!.values.toList()[i] == 2)
                            score2Fitr++;
                          else if (questions[index].answers!.values.toList()[i] == 3)
                            score3Tech++;
                          else if (questions[index].answers!.values.toList()[i] == 4)
                            score4Sport++;
                          else if (questions[index].answers!.values.toList()[i] == 5)
                            score5Gum++;
                          else if (questions[index].answers!.values.toList()[i] == 6)
                            score6Nature++;
                        },
                        /*!answered
                            ? () {
                                if (questions[index]
                                    .answers!
                                    .values
                                    .toList()[i]) {
                                  score++;
                                  print("yes");
                                } else {
                                  print("no");
                                }
                                setState(() {
                                  btnPressed = true;
                                  answered = true;
                                });
                              }
                            : null,*/
                        child: Text(
                          questions[index].answers!.keys.toList()[i],
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 40.0,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      if (_controller!.page?.toInt() == questions.length - 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResultScreen(score1Arxitech, score2Fitr, score3Tech, score4Sport,score5Gum, score6Nature)));
                      } else {
                        _controller!.nextPage(
                            duration: Duration(milliseconds: 250), curve: Curves.easeInExpo);

                        setState(() {
                          btnPressed = false;
                        });
                      }
                    },
                    shape: StadiumBorder(),
                    fillColor: Colors.white,
                    padding: EdgeInsets.all(18.0),
                    elevation: 10.0,
                    child: Text(
                      btnText,
                      style: TextStyle(color: mainColor),
                    ),
                  )
                ],
              );
            },
            itemCount: questions.length,
          )),
    );
  }
}
