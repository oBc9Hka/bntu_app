import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color main_color = Color.fromARGB(255, 0, 138, 94); // green color

    Widget firstCard = SizedBox(
      width: 300,
      height: 150,
      child: Card(
        margin: EdgeInsets.all(10),
        shadowColor: main_color,
        elevation: 10,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: main_color, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading:
                  Icon(Icons.check_box_outlined, color: main_color, size: 45),
              title: Text(
                "Определиться с будущей профессией",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                  '\nВ этом поможет отдел профориентационной работы БНТУ.'),
            ),
          ],
        ),
      ),
    );

    Widget secondCard = SizedBox(
      width: 300,
      height: 300,
      child: Card(
        margin: EdgeInsets.all(10),
        shadowColor: main_color,
        elevation: 10,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: main_color, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading:
                  Icon(Icons.check_box_outlined, color: main_color, size: 45),
              title: Text(
                "Сдать вступительные испытания",
                style: TextStyle(fontSize: 20),
              ),
              subtitle:
                  Text('\nЭто может быть централизованное тестирование (ЦТ), '
                      'письменный экзамен или творческие испытания, '
                      'что зависит от законченного ранее учреждения среднего '
                      'образования, а также формы получения образования и '
                      'выбранной специальности. \nПодробнее по специальностям '
                      'смотрите на сайте приемной комиссии БНТУ'),
            ),
          ],
        ),
      ),
    );

    Widget thirdCard = SizedBox(
      width: 300,
      height: 100,
      child: Card(
        margin: EdgeInsets.all(10),
        shadowColor: main_color,
        elevation: 10,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: main_color, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading:
                  Icon(Icons.check_box_outlined, color: main_color, size: 45),
              title: Text(
                "Собрать необходимый пакет документов",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );

    Widget fourthCard = SizedBox(
      width: 300,
      height: 300,
      child: Card(
        margin: EdgeInsets.all(10),
        shadowColor: main_color,
        elevation: 10,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: main_color, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading:
                  Icon(Icons.check_box_outlined, color: main_color, size: 45),
              title: Text(
                "Подать документы в установленные сроки",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                  '\nДля обучения за счет средств республиканского бюджета – с 20.07 по 26.07'
                  '\nДля обучения на платной основе при поступлении '
                  'по результатам экзаменов в БНТУ – с 20.07 по 26.07'
                  '\nДля обучения на платной основе при поступлении '
                  'на основе только сертификатов ЦТ – с 20.07 по 09.08'
                  '\n14.07 и 04.08 – рабочие дни.'),
            ),
          ],
        ),
      ),
    );

    Widget fifthCard = SizedBox(
      width: 300,
      height: 450,
      child: Card(
        margin: EdgeInsets.all(10),
        shadowColor: main_color,
        elevation: 10,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: main_color, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.notifications_active_rounded,
                  color: main_color, size: 45),
              title: Text(
                "Перечень необходимых документов для поступления",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text('\nПаспорт (документ, удостоверяющий личность)'
                  '\nЗаявление (заполняется в вузе)'
                  '\nОригинал документа об образовании и приложения '
                  'к нему (аттестат об окончании школы или диплом'
                  'колледжа/училища/вуза)'
                  '\nОригиналы сертификатов ЦТ (2020-2021 годы)'
                  '\nМедицинская справка о состоянии здоровья'
                  '(1/здр/у-10, срок действия – 6 месяцев) '
                  'с обязательной записью (если нет противопоказаний '
                  'по здоровью) "Годен для обучения в вузе"'
                  '\nДокументы о праве на льготы (если таковые имеются)'
                  '\n4 цветные фотографий 3x4'
                  '\n14.07 и 04.08 – рабочие дни'),
            ),
          ],
        ),
      ),
    );

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: Image.asset('assets/bntu.png').image,
              // backgroundImage: NetworkImage(
              //     'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/bntu.png?alt=media&token=5c28bbf8-4344-4882-b295-24fa09ee8343'),
            ),
          ],
        ),
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
                // image: NetworkImage(
                //     'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/BNTU_Logo.png?alt=media&token=c6b4220f-8cf9-4ef1-b7f1-578926b90a5a'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'СТАНЬ СТУДЕНТОМ БНТУ!',
              style: TextStyle(
                  color: main_color, fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          firstCard,
          secondCard,
          thirdCard,
          fourthCard,
          fifthCard,
        ],
      ),
    );
  }
}
