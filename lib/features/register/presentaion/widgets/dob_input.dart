import 'package:flutter/material.dart';

class DobInput extends StatefulWidget {
  final TextEditingController dobController;

  const DobInput({super.key, required this.dobController});

  @override
  State<DobInput> createState() => _DobInputState();
}

class _DobInputState extends State<DobInput> {
  @override
  Widget build(BuildContext context) {
    Future<void> selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1970),
        lastDate: DateTime(2100),
        initialDate: DateTime.now(),
      );

      if (picked != null) {
        setState(() {
          widget.dobController.text = picked.toString().split(" ")[0];
        });
      }
    }

    return SizedBox(
      width: 170,
      child: TextFormField(
        controller: widget.dobController,
        decoration: InputDecoration(
          label: Text(
            'DOB',
            style: TextStyle(color: Colors.black),
          ),
          prefixIcon: Icon(Icons.calendar_month),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
        readOnly: true,
        onTap: () => selectDate(),
      ),
    );
  }
}
