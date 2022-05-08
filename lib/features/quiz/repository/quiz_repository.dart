import 'package:bntu_app/core/enums/question__types.dart';
import 'package:bntu_app/core/enums/quiz_types.dart';
import 'package:bntu_app/features/quiz/domain/models/coeff_result_model.dart';
import 'package:bntu_app/features/quiz/domain/models/quiz_model.dart';
import 'package:bntu_app/features/quiz/domain/models/question_model.dart';
import 'package:bntu_app/features/quiz/domain/models/result_model.dart';
import 'package:bntu_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizFirestoreRepository extends QuizRepository {
  final dbRef = FirebaseFirestore.instance.collection('quizV2');
  final trashDbRef = FirebaseFirestore.instance.collection('quizV2Trash');

  @override
  Future<bool> addQuiz({required QuizModel quiz}) async {
    await dbRef.add({
      'quizName': quiz.quizName,
      'quizType': quiz.quizType.asString,
      'questions': [],
      'coefficients': quiz.coefficients,
      'coeffResults': quiz.coeffResults
          .map(
            (e) => CoeffResult(
              name: e.name,
              results: e.results
                  .map(
                    (e) => Result(
                      speciality: e.speciality,
                      faculty: e.faculty,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
      'isVisible': false,
      'needPrintResults': quiz.needPrintResults,
    });

    return true;
  }

  @override
  Future<bool> deleteQuiz({required QuizModel quiz}) async {
    await trashDbRef.add({
      'quizName': quiz.quizName,
      'quizType': quiz.quizType.asString,
      'questions': [],
      'coefficients': quiz.coefficients,
      'coeffResults': quiz.coeffResults
          .map(
            (e) => CoeffResult(
              name: e.name,
              results: e.results
                  .map(
                    (e) => Result(
                      speciality: e.speciality,
                      faculty: e.faculty,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
      'isVisible': false,
      'needPrintResults': quiz.needPrintResults,
    });

    await dbRef.doc(quiz.docId).delete();

    return true;
  }

  @override
  Future<bool> editQuiz({required QuizModel quiz}) async {
    await dbRef.doc(quiz.docId).update({
      'quizName': quiz.quizName,
      'quizType': quiz.quizType.asString,
      'questions': quiz.questions
          .map((e) => {
                'question': e.question,
                'questionType': e.questionType.asString,
                'answers': e.answers
                    .map((e) => {
                          'text': e.text,
                          'coefficients': e.coefficients
                              .map((e) => {
                                    'key': e.key,
                                    'weight': e.weight,
                                  })
                              .toList()
                        })
                    .toList(),
              })
          .toList(),
      'coefficients': quiz.coefficients,
      'coeffResults': quiz.coeffResults
          .map((e) => {
                'name': e.name,
                'results': e.results
                    .map((e) => {
                          'speciality': e.speciality,
                          'faculty': e.faculty,
                        })
                    .toList(),
              })
          .toList(),
      'isVisible': false,
      'needPrintResults': quiz.needPrintResults,
    });

    return true;
  }

  @override
  Future<List<QuizModel?>> getQuizList({required List<String> quizIds}) async {
    final response = await dbRef.get();
    final list = <QuizModel?>[];
    if (quizIds.isNotEmpty) {
      for (var i = 0; i < response.docs.length; i++) {
        if (quizIds.contains(response.docs[i].id)) {
          final e = response.docs[i];
          list.add(QuizModel(
            docId: e.id,
            quizName: e['quizName'],
            quizType: quizTypeFromString(e['quizType']),
            questions: qList(e['questions']),
            coefficients: [...e['coefficients'].map((e) => e as String)],
            coeffResults: [
              ...e['coeffResults'].map(
                (e) => CoeffResult(
                  name: e['name'],
                  results: [
                    ...e['results'].map(
                      (e) => Result(
                        speciality: e['speciality'],
                        faculty: e['faculty'],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            needPrintResults: e['needPrintResults'],
            isChecked: false,
          ));
        }
      }
    }

    return list;
  }

  List<QuestionModel> qList(List data) {
    print(data);

    return data.map((e) => QuestionModel.fromMap(e)).toList();
  }
}
