import 'package:flutter/material.dart';

class Myinput extends StatefulWidget {
  const Myinput({
    super.key,
    required this.myBool,
    required this.hintText,
    required this.isPassword,
    required this.controller,
  });
  final myBool;
  final hintText;
  final isPassword;
  final controller;

  @override
  State<Myinput> createState() => _MyinputState();
}

class _MyinputState extends State<Myinput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.myBool,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: widget.hintText,
          suffixIcon: (widget.isPassword)
              ? IconButton(
                  onPressed: () {},
                  icon: (widget.myBool)
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.visibility_off_outlined),
                )
              : Icon(Icons.email),
        ),
      ),
    );
  }
}
