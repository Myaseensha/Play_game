import 'package:flutter/material.dart';

class FromFilde extends StatelessWidget {
  const FromFilde(
      {super.key, 
      required this.textController,
      required this.commend,
      required this.keytype,
      required this.titel});

  final TextEditingController textController;
  final String titel;
  final String commend;
  final TextInputType keytype;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: keytype,
        controller: textController,
        decoration: InputDecoration(
          labelText: titel,
          labelStyle: const TextStyle(color: Colors.green),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              width: 2.0,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return commend;
          } else {
            return null;
          }
        },
      ),
    );
  }
}
