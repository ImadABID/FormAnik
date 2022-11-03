import 'dart:ffi';

import 'questions.dart';

class MyForm {
  int _questionNumber = 0;

  List<Question> _questionList = [
    Question(qtn: 'Avez-vous aimer notre site ?', ans: ""),
    Question(qtn: 'La navigation vous-a plu ?', ans: ""),
    Question(qtn: 'Avez-vous aimer le design du site ?', ans: ""),
    Question(qtn: 'Etes-vous majeur ?', ans: ""),
    Question(qtn: 'Vous avez plus de trente ans ?', ans: ""),
    Question(qtn: 'Etes-vous marié\(e\) ?', ans: ""),
    Question(qtn: 'Avez-vous des enfants ?', ans: ""),
  ];

  dynamic nextQuestion() {
    if (_questionNumber < _questionList.length - 1) {
      print(_questionNumber);
      _questionNumber++;
    } else {
      bool completed = true;
      return completed;
    }
  }

  String getQuestionText() {
    return _questionList[_questionNumber].questionText;
  }

  setQuestionAnswer(String ans) {
    _questionList[_questionNumber].questionAnswer = ans;
  }

  String getQuestionAnswer() {
    return _questionList[_questionNumber].questionAnswer;
  }

  int startOver() {
    return _questionNumber = 0;
  }
}
