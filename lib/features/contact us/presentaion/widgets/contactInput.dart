import 'package:flutter/material.dart';

Widget contactInput(
    {required BuildContext context,
    required String hintText,
    required bool isMessage,
    required TextEditingController textEditingController}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    child: TextFormField(
      validator: (value) =>
          value!.isEmpty ? "$hintText  can not be empty," : null,
      controller: textEditingController,
      maxLines: null,
      minLines: (isMessage) ? 6 : 1,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        errorStyle: TextStyle(color: Colors.white),
        hintText: hintText,
      ),
    ),
  );
}
