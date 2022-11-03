class Question {
  late String questionText;
  late String questionAnswer;
  late String NextOnYes;
  late String NextOnNo;

  Question(
      {required String qtn,
      required String ans,
      required String nyes,
      required String nno}) {
    questionText = qtn;
    questionAnswer = ans;
    NextOnYes = nyes;
    NextOnNo = nno;
  }
}
