import 'package:bntu_app/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color main_color = Color.fromARGB(255, 0, 138, 94); // green color
    Widget buttonSection = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: ButtonTheme(
            minWidth: 220.0,
            height: 50.0,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/main_page');
              },
              label: Text('Выбери факультет'),
              icon: Icon(Icons.account_balance_outlined),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(main_color),
                minimumSize: MaterialStateProperty.all(Size(220, 50)),
                elevation: MaterialStateProperty.all(10),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: main_color),
                  ),
                ),
              ),
            ),
          ),
        ),
        ButtonTheme(
          minWidth: 220.0,
          height: 50.0,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/info');
            },
            label: Text('Узнай как поступить'),
            icon: Icon(Icons.article_outlined),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(main_color),
              minimumSize: MaterialStateProperty.all(Size(220, 50)),
              elevation: MaterialStateProperty.all(10),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: main_color),
                ),
              ),
            ),
          ),
        ),
        // ButtonTheme(
        //   minWidth: 220.0,
        //   height: 50.0,
        //   child: ElevatedButton.icon(
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/map');
        //     },
        //     label: Text('Карта корпусов'),
        //     icon: Icon(Icons.article_outlined),
        //     style: ButtonStyle(
        //       foregroundColor: MaterialStateProperty.all(main_color),
        //       minimumSize: MaterialStateProperty.all(Size(220, 50)),
        //       elevation: MaterialStateProperty.all(10),
        //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //         RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(18.0),
        //           side: BorderSide(color: main_color),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );

    Widget textSection = Container(
      alignment: Alignment.center,
      // padding: const EdgeInsets.fromLTRB(30, 0, 50, 10),
      child: const ListTile(
        title: Text('АБИТУРИЕНТ?',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700)),
        subtitle: Text(
          'Приходи, ждём!',
          style: TextStyle(
              color: main_color, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
    );

    double height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: Image.asset('assets/bntu.png').image,
              // backgroundImage: NetworkImage(
              //     'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/bntu.png?alt=media&token=5c28bbf8-4344-4882-b295-24fa09ee8343'),
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       if (themeProvider.brightness == CustomBrightness.dark) {
        //         themeProvider.toggle(CustomBrightness.light);
        //       } else {
        //         themeProvider.toggle(CustomBrightness.dark);
        //       }
        //     },
        //     icon: themeProvider.currentIcon,
        //   ),
        // ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/map');
                },
                title: Text('Карта корпусов'),
                trailing: Icon(Icons.map_rounded),
              ),
              ListTile(
                onTap: () {
                  if (themeProvider.brightness == CustomBrightness.dark) {
                    themeProvider.toggle(CustomBrightness.light);
                  } else {
                    themeProvider.toggle(CustomBrightness.dark);
                  }
                },
                title: Text('Dark Mode'),
                trailing: themeProvider.currentIcon,
              )
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Padding(padding: EdgeInsets.only(left: 40)),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "БЕЛОРУССКИЙ НАЦИОНАЛЬНЫЙ ТЕХНИЧЕСКИЙ УНИВЕРСИТЕТ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),

            Container(
              width: double.infinity,
              height: height / 2.5,
              alignment: Alignment.center,
              // child: Image.network(
              //   'https://firebasestorage.googleapis.com/v0/b/bntu-app.appspot.com/o/man.png?alt=media&token=e30fe84b-b63b-49bd-a567-b123ca17e4f9',
              //   fit: BoxFit.cover,
              //   loadingBuilder: (BuildContext context, Widget child,
              //       ImageChunkEvent? loadingProgress) {
              //     if (loadingProgress == null) {
              //       return child;
              //     }
              //     return Center(
              //       child: CircularProgressIndicator(
              //         color: main_color,
              //         value: loadingProgress.expectedTotalBytes != null
              //             ? loadingProgress.cumulativeBytesLoaded /
              //                 loadingProgress.expectedTotalBytes!
              //             : null,
              //       ),
              //     );
              //   },
              // ),
              child: Image.asset('assets/man.png'),
            ),
            textSection,
            buttonSection,
          ],
        ),
      ),
    );
  }
}
