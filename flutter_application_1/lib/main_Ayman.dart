import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import "dart:async";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form dechotomie Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

enum SingingCharacter { yes, no }

Future<String> getJson() {
  return rootBundle.loadString('test.json');
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
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
  var _values = [];
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
        var tmp = element[count.toString()];
        Question.insert(0, tmp["question"]);
        _values_yes.insert(0, tmp["yes_next"]);
        _values_no.insert(0, tmp["no_next"]);
      }
      // print(Question);
      // print(_values_yes);
      // print(_values_yes);
    });
  }

  SingingCharacter? _character;
  var counter = 0;
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Center(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(Question[counter].toString()),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            onPressed: () {
              setState(() {
                if (counter < Question.length - 2) {
                  _values.insert(counter, "yes");
                  //getData();
                  counter = int.parse(_values_yes[counter]) - 1;
                }
              });
            },
            child: Text('YES'),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
            onPressed: () {
              setState(() {
                if (counter < Question.length - 2) {
                  _values.insert(counter, "no");
                  //getData();
                  counter = int.parse(_values_no[counter]) - 1;
                }
              });
            },
            child: Text('NO'),
          )
        ],
      ),
    );
  }
}
