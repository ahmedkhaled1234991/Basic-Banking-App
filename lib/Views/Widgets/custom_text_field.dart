import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintName;
  //var onChanged;
  var onSaved;
  final bool keyboardTypeNumber;
  var validator;

  CustomTextField(
      {required this.hintName,
        //this.onChanged,
        this.onSaved,
        this.validator,
        required this.keyboardTypeNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: TextFormField(
        //onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        keyboardType:
        keyboardTypeNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.all(20),
          hintText: hintName,
          hintStyle: TextStyle(
            fontSize: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
