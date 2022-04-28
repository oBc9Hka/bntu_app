import 'package:bntu_app/core/enums/quiz_types.dart';
import 'package:bntu_app/core/widgets/add_buttons_section.dart';
import 'package:bntu_app/features/quiz/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class QuizAdd extends StatefulWidget {
  const QuizAdd({Key? key}) : super(key: key);

  @override
  State<QuizAdd> createState() => _QuizAddState();
}

class _QuizAddState extends State<QuizAdd> {
  final TextEditingController quizName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? quizType;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuizProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление теста'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: quizName,
                    validator: (value) {
                      if (value == '') {
                        return 'Введите название';
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Название теста'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Выбрать тип теста'),
                ),
              ],
            ),
            AddButtonsSection(
              onAddPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await state.addQuiz(
                    quizName: quizName.text,
                    quizType: quizType != null
                        ? quizTypeFromString(quizType!)
                        : QuizTypes.single_coeff,
                  );
                  Navigator.pop(context);
                  await Fluttertoast.showToast(msg: 'Тест успешно создан');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
