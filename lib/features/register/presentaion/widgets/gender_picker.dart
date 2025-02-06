import 'package:flutter/material.dart';

class GenderPicker extends StatefulWidget {
  final TextEditingController genderController;
  const GenderPicker({super.key, required this.genderController});

  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

String dropDownValue = 'Gender';

class _GenderPickerState extends State<GenderPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 165,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: DropdownButton<String>(
            value: dropDownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropDownValue = newValue!;
                widget.genderController.text = newValue;
              });
            },
            items: [
              DropdownMenuItem<String>(
                value: 'Gender',
                child: Text('Gender', style: TextStyle(color: Colors.black)),
              ),
              DropdownMenuItem<String>(
                value: 'male',
                child: Row(
                  children: [
                    Text('male'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.male,
                      color: Colors.redAccent,
                    )
                  ],
                ),
              ),
              DropdownMenuItem<String>(
                value: 'female',
                child: Row(
                  children: [
                    Text('female'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.female,
                      color: Colors.lightBlueAccent,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
