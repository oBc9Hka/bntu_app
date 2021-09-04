import 'package:bntu_app/util/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color.fromARGB(255, 0, 138, 94); // green color
    var _infoCards = Data().infoCards;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('Как поступить?')
            // CircleAvatar(backgroundImage: Image.asset('assets/bntu.png').image),
      ),
      body: ListView(
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
                image: Image.asset('assets/BNTU_Logo.png').image,
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
          ..._infoCards.map((item) => Card(
                margin: EdgeInsets.all(10),
                shadowColor: mainColor,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: mainColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    title: Text(item.title, style: TextStyle(fontSize: 20)),
                    subtitle: Text(item.subtitle),
                    leading: Icon(Icons.check_box_outlined,
                        color: mainColor, size: 45),
                  ),
                ),
              ))
          // firstCard,
          // secondCard,
          // thirdCard,
          // fourthCard,
          // fifthCard,
        ],
      ),
    );
  }
}
