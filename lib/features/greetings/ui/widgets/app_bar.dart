import 'package:bntu_app/ui/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../../../ui/widgets/user_exit_dialog.dart';
import '../../provider/greetings_provider.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.signOut}) : super(key: key);
  final GestureTapCallback signOut;

  @override
  Widget build(BuildContext context) {
    const mainColor = Constants.mainColor;

    return AppBar(
      centerTitle: true,
      title: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: Image.asset('assets/bntu.png').image,
      ),
      actions: [
        context.watch<GreetingsProvider>().user != null
            ? Container(
                constraints: BoxConstraints(
                  minWidth: 100,
                  maxWidth: 110,
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ExitDialog(onConfirmPressed: () {
                            signOut();
                          });
                        });
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: mainColor,
                  ),
                  label: const Text(
                    'Выход',
                    style: TextStyle(inherit: false, color: mainColor),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(0, 0, 0, 0),
                    ),
                    shadowColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(5, 0, 0, 0),
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  @override
  Size get preferredSize => Size(20, 50);
}
