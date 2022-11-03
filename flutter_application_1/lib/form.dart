import 'dart:ffi';
//import 'dart:html';

import 'questions.dart';

class MyForm {
  int _questionNumber = 0;

  List<Question> _questionList = [
    Question(qtn: 'fgfdgd', ans: "", nyes: "1", nno: "2"),
    // Question(qtn: 'La navigation vous-a plu ?', ans: "", nyes: "", nno: ""),
    // Question(
    //     qtn: 'Avez-vous aimer le design du site ?', ans: "", nyes: "", nno: ""),
    // Question(qtn: 'Etes-vous majeur ?', ans: "", nyes: "", nno: ""),
    // Question(qtn: 'Vous avez plus de trente ans ?', ans: "", nyes: "", nno: ""),
    // Question(qtn: 'Etes-vous marié\(e\) ?', ans: "", nyes: "", nno: ""),
    // Question(qtn: 'Avez-vous des enfants ?', ans: "", nyes: "", nno: ""),
  ];

  dynamic nextQuestion(String ans) {
    if (_questionList[_questionNumber].NextOnYes == "" &&
        _questionList[_questionNumber].NextOnNo == "") return true;
    print(_questionNumber);
    if (ans == "oui") {
      print(_questionList[_questionNumber].NextOnYes);
      _questionNumber = int.parse(_questionList[_questionNumber].NextOnYes);
    } else {
      _questionNumber = int.parse(_questionList[_questionNumber].NextOnNo);
    }
    return false;
  }

  setQuestion(String quest, String nyes, String nno, String ans) {
    _questionList.add(Question(qtn: quest, ans: ans, nyes: nyes, nno: nno));
  }

  setQuestionAt(String quest, String nyes, String nno, String ans, int idx) {
    _questionList[idx] = Question(qtn: quest, ans: ans, nyes: nyes, nno: nno);
  }

  String getQuestionText() {
    return _questionList[_questionNumber].questionText;
  }

  List<Question> getAllQuestions() {
    print("printing question list");
    for (var i in _questionList) {
      print("question: " + i.questionText);
      print("next on no: " + i.NextOnNo);
      print("next on yes: " + i.NextOnYes);
    }
    return _questionList;
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
