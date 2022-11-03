//import 'dart:html';

import 'package:flutter/material.dart';
import 'form.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import "dart:async";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 242, 226, 226),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: FormPage(),
            ),
          ),
        ),
      ),
    );
  }
}

var counter = 0;

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  List<Icon> questionAnswered = [];

  MyForm formClass = MyForm();

  bool completed = false;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  var Question = [""];
  var _values_yes = [""];
  var _values_no = [""];
  var _values = new Map();
  var count = 0;
  getData() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("lib/test.json");
    setState(() {
      var dJson = json.decode(data);
      //var count = 5;
//which results in dJson being a List<dynamic>
//access the first result
      for (var element in dJson) {
        count++;
      }
      for (var element in dJson) {
        count--;
        var tmp = element[count.toString()];
        print(count.toString());
        print(element);
        Question.insert(0, tmp["question"]);
        _values_yes.insert(0, tmp["yes_next"]);
        _values_no.insert(0, tmp["no_next"]);
      }
      // print(Question);
      print(_values_yes);
      // print(_values_yes);
    });

    for (int i = 0; i < Question.length; i++) {
      if (i == 0) {
        formClass.setQuestionAt(
            Question[i], _values_yes[i], _values_no[i], "", i);
      } else {
        formClass.setQuestion(Question[i], _values_yes[i], _values_no[i], "");
      }
    }
    formClass.getAllQuestions();
    loaded = true;
  }

  void checkAnswer(String userAnswer) {
    while (!loaded) {
      print("loading..");
    }
    print("loaded..");
    //bool answer = formClass.getQuestionAnswer();
    formClass.setQuestionAnswer(userAnswer);
    print(formClass.getQuestionAnswer());
    setState(() {
      if (formClass.nextQuestion(userAnswer) == true) {
        print('next question');
        print(formClass.nextQuestion(userAnswer));
        completed = true;
        questionAnswered.add(Icon(
          Icons.question_mark,
          color: Color.fromARGB(255, 3, 105, 247),
        ));
      } else {
        print('setting marks');
        questionAnswered.add(Icon(
          Icons.question_mark,
          color: Color.fromARGB(255, 3, 105, 247),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildQuestionsPage();
  }

  Column buildQuestionsPage() {
    if (completed) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Fin du formulaire !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 63, 2, 2), fontSize: 25.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueAccent),
                  ),
                  onPressed: () {
                    setState(() {
                      completed = false;
                      questionAnswered = [];
                      formClass.startOver();
                    });
                  },
                  child: Text(
                    'Start Over',
                    style: TextStyle(
                        color: Color.fromARGB(255, 22, 3, 3), fontSize: 20.0),
                  )),
            ),
          ),
          SafeArea(
            child: Row(
              children: questionAnswered,
            ),
          )
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  formClass.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 77, 3, 3), fontSize: 25.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueAccent),
                  ),
                  onPressed: () {
                    checkAnswer("oui");
                  },
                  child: Text(
                    'Oui',
                    style: TextStyle(
                        color: Color.fromARGB(255, 81, 255, 0), fontSize: 20.0),
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueAccent),
                  ),
                  onPressed: () {
                    checkAnswer("non");
                  },
                  child: Text(
                    'Non',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 4), fontSize: 20.0),
                  )),
            ),
          ),
          SafeArea(
            child: Row(
              children: questionAnswered,
            ),
          )
        ],
      );
    }
  }
}
