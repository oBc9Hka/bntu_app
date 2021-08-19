import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget firstCard = SizedBox (
      width: 300,
      height: 150,
      child: Card (
        margin: EdgeInsets.all(10),
        color: Colors.white,
        shadowColor: Colors.green,
        elevation: 10,
        shape: RoundedRectangleBorder(
            side:  BorderSide(color: Colors.green,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon (
                  Icons.check_box_outlined,
                  color: Colors.green,
                  size: 45
              ),
              title: Text(
                "Определиться с будущей профессией",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text('\nВ этом поможет отдел профориентационной работы БНТУ.'),
            ),
          ],
        ),
      ),
    );

    Widget secondCard = SizedBox (
      width: 300,
      height: 300,
      child: Card (
        margin: EdgeInsets.all(10),
        color: Colors.white,
        shadowColor: Colors.green,
        elevation: 10,
        shape: RoundedRectangleBorder(
            side:  BorderSide(color: Colors.green,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon (
                  Icons.check_box_outlined,
                  color: Colors.green,
                  size: 45
              ),
              title: Text(
                "Сдать вступительные испытания",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text('\nЭто может быть централизованное тестирование (ЦТ), '
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

    Widget thirdCard = SizedBox (
      width: 300,
      height: 100,
      child: Card (
        margin: EdgeInsets.all(10),
        color: Colors.white,
        shadowColor: Colors.green,
        elevation: 10,
        shape: RoundedRectangleBorder(
            side:  BorderSide(color: Colors.green,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon (
                  Icons.check_box_outlined,
                  color: Colors.green,
                  size: 45
              ),
              title: Text(
                "Собрать необходимый пакет документов",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );

    Widget fourthCard = SizedBox (
      width: 300,
      height: 300,
      child: Card (
        margin: EdgeInsets.all(10),
        color: Colors.white,
        shadowColor: Colors.green,
        elevation: 10,
        shape: RoundedRectangleBorder(
            side:  BorderSide(color: Colors.green,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon (
                  Icons.check_box_outlined,
                  color: Colors.green,
                  size: 45
              ),
              title: Text(
                "Подать документы в установленные сроки",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text('\nДля обучения за счет средств республиканского бюджета – с 20.07 по 26.07'
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

    Widget fivethCard = SizedBox (
      width: 300,
      height: 450,
      child: Card (
        margin: EdgeInsets.all(10),
        color: Colors.white,
        shadowColor: Colors.green,
        elevation: 10,
        shape: RoundedRectangleBorder(
            side:  BorderSide(color: Colors.green,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon (
                  Icons.notifications_active_rounded,
                  color: Colors.green,
                  size: 45
              ),
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


    Widget textSection = Container(
      child:
      const ListTile(
        title: Text('Стань студентом БНТУ!',  style: TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.w700
        )
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
          Text("БЕЛОРУССКИЙ НАЦИОНАЛЬНЫЙ ТЕХНИЧЕСКИЙ УНИВЕРСИТЕТ", style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          ),

          Container(
            width: double.infinity,
            height: height/3,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/bntu.png?alt=media&token=5c28bbf8-4344-4882-b295-24fa09ee8343'),
                fit: BoxFit.cover,

              ),
            ),
          ),

          Text('СТАНЬ СТУДЕНТОМ БНТУ!',  style: TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.w700
          )
          ),
          firstCard,
          secondCard,
          thirdCard,
          fourthCard,
          fivethCard
        ],
      ),
    );
  }
}
