import 'package:bntu_app/pages/facultyInf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class MainPage extends StatefulWidget {

  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp().whenComplete(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height;
    const Color main_color = Color.fromARGB(255, 0, 138, 94);
    Color sec_color = Color.fromRGBO(0, 79, 0, 0.3);
    return Scaffold(
        appBar: AppBar(
          title: Text('Список факультетов'),
          elevation: 3,
        ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // FirebaseFirestore.instance.collection('faculties').add({
//             //   'name': 'Машиностроительный факультет',
//             //   'shortName': 'МСФ',
//             // });
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'ФИТР',
//               'name' : 'Факультет информационных технологий и робототехники',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/fitr.jpg?alt=media&token=f8069c12-8866-4a0a-b315-44d8007c6886',
//               'about' : '''Подготовка высококвалифицированных специалистов для нашей страны достигается исключительным профессионализмом профессорско-преподавательского состава, оснащением лабораторий и кафедр факультета современным оборудованием и вычислительной техникой, внедрением в учебный процесс инновационных методов обучения и активным участием студентов в научных исследованиях. Наши выпускники востребованы в проектно-конструкторских бюро, научно-исследовательских институтах, на предприятиях различных форм собственности как универсальные специалисты с высоким уровнем подготовки. Мы не шагаем в ногу со временем – мы его опережаем.
// ''',});
//
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'АТФ',
//               'name' : 'Автотракторный факультет',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/atf.png?alt=media&token=543e8a09-f0e5-4a6b-93a7-380797930ac5',
//               'about' : '''Ведущий факультет в области подготовки специалистов для всех сфер народного хозяйства, так или иначе связанных с автомобильным транспортом. Проектирование и эксплуатация транспортных средств, организация инфраструктуры, планирование и оценка стоимости и экономической эффективности в сфере автомобильного транспорта - всё это мы.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'МСФ',
//               'name' : 'Машиностроительный факультет',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/msf.jpg?alt=media&token=1f7ed743-0bfb-4807-8b82-cca9b5cb6110',
//               'about' : '''Машиностроительный факультет является одним из старейших факультетов Белорусского национального технического университета. Его история началась 10 декабря 1920 г. с открытия специальности «Станки, инструменты и механическая обработка металлов» в первом созданном в республике высшем техническом учебном заведении. Новую жизнь факультет получил в 1934 г. как механический факультет образованного в 1933 г. Белорусского политехнического института (БПИ). В 1958 г. механический факультет был переименован в машиностроительный.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'ФММП',
//               'name' : 'Факультет маркетинга, менеджмента, предпринимательства',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/fmmp.jpg?alt=media&token=6c270851-cf9a-418d-94f1-eca8342d1e7e',
//               'about' : '''Факультет маркетинга, менеджмента, предпринимательства БНТУ – это единственный экономический факультет в Республике Беларусь, студенты которого наряду с экономикой, менеджментом, маркетингом, иностранными языками изучают основы инженерного дела и конструкторско-технологического обеспечения производства. Сочетание экономической, инженерной и языковой подготовки обеспечивают выпускникам стабильно высокий спрос на рынке дипломированных специалистов.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'ИПФ',
//               'name' : 'Инженерно-педагогический факультет',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/ipf.png?alt=media&token=0a253750-97b2-4a22-ad4d-be492230181f',
//               'about' : '''Особенность факультета состоит в уникальной концепции подготовки специалистов: студенты в процессе обучения получают фундаментальные знания в области гуманитарных, социально-экономических, естественных наук в сочетании с глубокой психолого-педагогической, инженерной и производственной (рабочая профессия) подготовкой.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'АФ',
//               'name' : 'Архитектурный факультет',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/af.jpg?alt=media&token=cf4f595c-8a10-469c-bb83-baf96bd98ca9',
//               'about' : '''Более 50 лет факультет является ведущей архитектурной школой Беларуси. В настоящее время факультет осуществляет научно-методическое обеспечение высшего и среднего специального архитектурного образования республики. За всю историю существования архитектурного факультета было подготовлено более 4 000 архитекторов, в том числе около 600 для зарубежных стран. На факультете работает 75 преподавателей, из них 8 докторов и 26 кандидатов архитектуры. В настоящее время на факультете обучается около 1000 студентов.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'ПСФ',
//               'name' : 'Приборостроительный факультет',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/psf.jpg?alt=media&token=0a323b77-e9e8-44b7-bab2-56225e7872c3',
//               'about' : '''Начало подготовки специалистов приборостроительного направления в БПИ-БГПА-БНТУ было положено в 1961 году созданием кафедры «Приборы точной механики». Ее первым заведующим, который возглавлял кафедру на протяжении 23 лет, был заслуженный работник высшей школы БССР, профессор С.С. Костюкович.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'ВТФ',
//               'name' : 'Военно-технический факультет',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/vtf.jpg?alt=media&token=ef548f57-f41e-49ca-a8b4-a0fe00dd6f1b',
//               'about' : '''Военно-технический факультет был создан в 2003 году на базе военной кафедры, начавшей отсчет своей славной истории в далеком для нас 1933 г. в Белорусском политехническом институте. Свыше 30 тысяч студентов, которым было присвоено первое воинское звание лейтенант запаса, обучались на военной кафедре. Более трех тысяч из них связали свою служебную карьеру с Вооруженными Силами СССР и Республики Беларусь. Около 80 процентов — офицеры инженерного профиля.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'ФГДЭ',
//               'name' : 'Факультет горного дела и инженерной экологии',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/fgde.jpg?alt=media&token=460bc8c1-f039-45d0-9037-c841ce6676e7',
//               'about' : '''Факультет горного дела и инженерной экологии, созданный в 2002 г., является центром по подготовке и повышению квалификации инженерных кадров в Республике Беларусь для добычи, переработки, рационального использования природных ресурсов, защиты окружающей среды, по экологическому менеджменту.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'МТФ',
//               'name' : 'Факультет информационных технологий и робототехники',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/mtf.png?alt=media&token=c40583fa-9e13-4acd-9aa2-cf6f800c3cd4',
//               'about' : '''Механико-технологический факультет является лидером в Республике Беларусь по подготовке специалистов в области металлургии и технологии литейного производства, обработки металлов давлением, процессов сварки, термической обработки металлов, материаловедения.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'ЭФ',
//               'name' : 'Механико-технологический факультет',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/ef.png?alt=media&token=7393fabc-6c03-4e92-8d78-a2428c5cbf90',
//               'about' : '''Механико-технологический факультет является лидером в Республике Беларусь по подготовке специалистов в области металлургии и технологии литейного производства, обработки металлов давлением, процессов сварки, термической обработки металлов, материаловедения.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'ФТУГ',
//               'name' : 'Факультет технологий управления и гуманитаризации',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/ftug.jpg?alt=media&token=8020d8d8-8414-43dd-bda5-ac8f58116aa2',
//               'about' : '''Факультет технологий управления и гуманитаризации - уникальный факультет в Республике Беларусь, ведущий подготовку специалистов инженерного, экономического, управленческого и дизайнерского профиля. Наши выпускники получают двойную квалификацию и имеют широкое поле для профессиональной самореализации.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'ФЭС',
//               'name' : 'Факультет энергетического строительства',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/fes.jpg?alt=media&token=d4090c29-2169-4042-ab34-0a56d0fc7bbd',
//               'about' : '''Факультет энергетического строительства создан 1 октября 1986 года. Факультет объединил специальности и специализации, связанные со строительством и эксплуатацией объектов энергетики, водного хозяйства, с использованием природных, в первую очередь энергетических, ресурсов.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'СФ',
//               'name' : 'Строительный факультет',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/sf.png?alt=media&token=ce1f28c4-2c8d-4691-afc7-5ccd2497bc10',
//               'about' : '''Строительный факультет — один из старейших в Белорусском национальном техническом университете. Факультет был сформирован в 1920 году при организации первого в Белоруссии технического вуза.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'ФТК',
//               'name' : 'Факультет транспортных коммуникаций',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/ftk.jpg?alt=media&token=2d8237db-6ecf-49f3-8473-addc24308909',
//               'about' : '''Факультет транспортных коммуникаций — один из старейших факультетов БНТУ, который не стоит на месте и выпускает специалистов, широко востребованных в транспортной, строительной и машиностроительной отраслях.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'СТФ',
//               'name' : 'Спортивно-технический факультет',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/stf.jpg?alt=media&token=78798380-3d56-4acf-8474-f1297cc93705',
//               'about' : '''Спортивно-технический факультет – самый молодой в Белорусском национальном техническом университете и первый инженерный факультет в вузах стран СНГ, на котором осуществляется подготовка специалистов инженерного профиля для сферы спортивной индустрии. С его открытием отечественная физкультурно-спортивная отрасль станет получать квалифицированных специалистов, способных участвовать в научно-исследовательской, производственно-технической и организационно-управленческой деятельности на предприятиях и в организациях промышленного и физкультурно-спортивного комплексов, специализирующихся на выпуске и обслуживании спортивных тренажеров, судейско-информационных систем, инвентаря, приборов и оборудования специального назначения.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'Филиал Солигорск',
//               'name' : 'Филиал Солигорск',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/soligorsk.jpg?alt=media&token=11f821dd-886e-4161-9e9f-a8d750400db1',
//               'about' : '''Филиал создан в 2004 году. Процесс обучения специалистов максимально приближен к производству. Студенты филиала имеют возможность реализовать свой научный потенциал посредством вовлечения в разработки ведущих специалистов кафедры.
// ''',});
//             FirebaseFirestore.instance.collection('faculties').add({
//               'shortName' : 'МИДО',
//               'name' : 'Международный институт дистанционного образования',
//               'imagePath' : 'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/mido.png?alt=media&token=a7f1ef37-7903-4ef3-9ff1-3b67b2da1209',
//               'about' : '''Международный институт дистанционного образования является структурным подразделением БНТУ. Институт основан в 2000 году. Ежегодно дипломы БНТУ государственного образца получают более 300 выпускников института. Выпускники МИДО востребованы на рынке труда специалистов нашей страны в областях экономики, менеджмента и информационных технологий, многие работают в США, Сингапуре, Арабских Эмиратах, странах Европы, Российской Федерации. МИДО располагает современной материально-технической базой для организации учебного процесса (программное обеспечение, базы данных, парк компьютеров, объединенных в локальную сеть, каналы передачи информации, доступ в Интернет). Для обучающихся проводятся видеолекции, online консультации и лабораторные занятия.
// ''',});
//
//
//
//           },
//           tooltip: 'Increment',
//           child: Icon(Icons.add),
//         ),
        body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('faculties')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: main_color,
                        ),
                      ),
                    );

                  return ListView.builder(
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
                          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                          child: Container(
                            width: c_width * 0.3,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(main_color),
                                minimumSize:
                                    MaterialStateProperty.all(Size(200, 50)),
                                elevation: MaterialStateProperty.all(10),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: main_color),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FacultyPage(
                                      faculty: item,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                key: Key(snapshot.data!.docs[index].id),
                                leading: Container(
                                  alignment: Alignment.centerLeft,
                                  width: 70,
                                  child: Text(
                                    snapshot.data!.docs[index].get('shortName'),
                                    style: TextStyle(
                                      color: main_color,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                trailing: Container(
                                  width: 24,
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: main_color,
                                  ),
                                ),
                                title: Text(
                                  snapshot.data!.docs[index].get('name'),
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
              )
            ]));
  }
}
