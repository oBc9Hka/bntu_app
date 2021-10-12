import 'package:bntu_app/models/info_cards_model.dart';
import 'package:bntu_app/providers/app_provider.dart';
import 'package:bntu_app/ui/pages/admission_info/info_form.dart';
import 'package:bntu_app/ui/widgets/edit_buttons_section.dart';
import 'package:bntu_app/ui/widgets/remove_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AdmissionInfoEdit extends StatefulWidget {
  const AdmissionInfoEdit({Key? key, required this.infoCard}) : super(key: key);
  final InfoCard infoCard;

  @override
  _AdmissionInfoEditState createState() => _AdmissionInfoEditState();
}

class _AdmissionInfoEditState extends State<AdmissionInfoEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color mainColor = Color.fromARGB(255, 0, 138, 94);

  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();

  // void showAlertDialog(
  //     BuildContext context, QueryDocumentSnapshot<Object?> item) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: Container(
  //           height: 22,
  //           child: const Center(
  //               child: Text(
  //                 'Хотите удалить карточку?',
  //                 style: TextStyle(fontSize: 18),
  //               )),
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               _info.removeCard(item.id);
  //               Navigator.pop(context);
  //               Navigator.pop(context);
  //             },
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.all(Colors.red),
  //             ),
  //             child: const Text('Удалить', style: TextStyle(color: Colors.white),),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               setState(() {});
  //             },
  //             style: ButtonStyle(
  //               backgroundColor: MaterialStateProperty.all(Colors.black38),
  //             ),
  //             child: const Text('Отмена', style: TextStyle(color: Colors.white),),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  void _onSubmit(String id, AppProvider state) {
    if (_formKey.currentState!.validate()) {
      state.editInfoCard(
        _titleController.text,
        _subtitleController.text,
        id,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _titleController = TextEditingController(text: widget.infoCard.title);
    _subtitleController = TextEditingController(text: widget.infoCard.subtitle);

    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать карточку'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoForm(
              formKey: _formKey,
              titleController: _titleController,
              subtitleController: _subtitleController,
            ),
            Consumer<AppProvider>(
              builder: (context, state, child) {
                return EditButtonsSection(
                  onEditPressed: () {
                    _onSubmit(widget.infoCard.docId.toString(), state);
                  },
                  onRemovePressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RemoveItem(
                          itemName: 'карточку',
                          onRemovePressed: () {
                            state.removeInfoCard(
                                widget.infoCard.docId.toString());
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(msg: 'Карточка успешно удалена');
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
