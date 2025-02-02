import 'package:flutter/material.dart';

class Myinput extends StatefulWidget {
  Myinput(
      {super.key,
      required this.myBool,
      required this.hintText,
      required this.isPassword,
      required this.controller,
      required this.hider});
  bool myBool;
  bool hider;
  final hintText;
  bool isPassword;
  final controller;

  @override
  State<Myinput> createState() => _MyinputState();
}

class _MyinputState extends State<Myinput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Center(
        child: TextFormField(
          validator: (value) =>
              value!.isEmpty ? "${widget.hintText} can not be empty," : null,
          controller: widget.controller,
          obscureText: widget.isPassword,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            errorStyle: TextStyle(color: Colors.white),
            hintText: widget.hintText,
            suffixIcon: (widget.hider)
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.myBool = !widget.myBool;
                        widget.isPassword = !widget.isPassword;
                      });
                    },
                    icon: (widget.myBool)
                        ? Icon(Icons.visibility_off_outlined)
                        : Icon(Icons.remove_red_eye))
                : Icon(
                    Icons.person,
                    size: 1,
                  ),
          ),
        ),
      ),
    );
  }
}
