import 'package:bntu_app/features/settings/ui/widgets/error_message_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/remove_item.dart';
import '../provider/settings_provider.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Сообщения об ошибках'),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 600,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.errorMessages.length,
                    itemBuilder: (BuildContext context, index) {
                      var item = state.errorMessages[index];
                      return ErrorMessageCard(
                        item: item,
                        onTap: () {
                          state.changeViewedState(item.id!);
                          Fluttertoast.showToast(msg: 'Прочитано');
                        },
                        onRemovePressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RemoveItem(
                                itemName: 'сообщение',
                                onRemovePressed: () {
                                  state.removeErrorMessage(item.id!);
                                  Navigator.of(context).pop();
                                  Fluttertoast.showToast(
                                      msg: 'Сообщение удалено');
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
