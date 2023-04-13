import 'package:flutter/material.dart';
import 'package:play_game_machine_test/view/play_screen.dart';

import '../widget/coustem_fromfilde.dart';

//user_info_page----------------------------------------------------------------
class IntroScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController rowTextController = TextEditingController();
  final TextEditingController columnTextController = TextEditingController();
  final TextEditingController alphabetTextController = TextEditingController();

  IntroScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Play Game'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Enter the Number of Cloumn,Row and The Alphabet",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FromFilde(
                          textController: rowTextController,
                          commend: 'Please enter your Row number',
                          titel: 'Row',
                          keytype: TextInputType.number,
                        ),
                      ),
                      Expanded(
                        child: FromFilde(
                          textController: columnTextController,
                          commend: 'Please enter your Column number',
                          titel: 'Column',
                          keytype: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  FromFilde(
                    textController: alphabetTextController,
                    keytype: TextInputType.name,
                    commend: 'Please enter your alphabet',
                    titel: 'Alphabet',
                  ),
//grid create button------------------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String input = alphabetTextController.text.trim();
                          List<String> contents = input.split('');
                          contents.removeWhere((element) => element.isEmpty);
                          contents = List.from(Set.from(contents))
                              .cast<String>()
                              .toList();
                          validation(
                              int.parse(rowTextController.text),
                              int.parse(columnTextController.text),
                              alphabetTextController.text.length,
                              context,
                              contents);
                        }
                      },
                      icon: const Icon(Icons.grid_3x3),
                      label: const Text('MakeGrid'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//validation check function-----------------------------------------------------
  void validation(int onetext, int twotext, int maintext, BuildContext context,
      List<String> contents) {
    if (maintext == onetext * twotext) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PlayScreen(
            columns: onetext,
            rows: twotext,
            contents: contents,
          ),
        ),
      );
    } //warning massege snack---------------------------------------------------
    else {
      final snackBar = SnackBar(
        padding: const EdgeInsets.all(20),
        backgroundColor: Colors.red,
        content: Text(
            "only ${onetext * twotext} alphabet needed now It's $maintext"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
