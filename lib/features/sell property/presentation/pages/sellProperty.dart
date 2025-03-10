import 'package:flutter/material.dart';
import 'package:tura_app/features/contact%20us/presentaion/widgets/contactInput.dart';

class Sellproperty extends StatefulWidget {
  const Sellproperty({super.key});

  @override
  State<Sellproperty> createState() => _SellpropertyState();
}

class _SellpropertyState extends State<Sellproperty> {
  TextEditingController name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Property'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Fill this form to list your property',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          contactInput(
            context: context,
            hintText: 'Enter your Names',
            isMessage: false,
            textEditingController: name,
          ),
          contactInput(
            context: context,
            hintText: 'Enter your Phone Number',
            isMessage: false,
            textEditingController: name,
          ),
          contactInput(
            context: context,
            hintText: 'Enter your Email',
            isMessage: false,
            textEditingController: name,
          ),
          contactInput(
            context: context,
            hintText: 'Property Location',
            isMessage: false,
            textEditingController: name,
          ),
          contactInput(
            context: context,
            hintText: 'Number of Properties',
            isMessage: false,
            textEditingController: name,
          ),
          contactInput(
            context: context,
            hintText: 'Price of Property in FRW',
            isMessage: false,
            textEditingController: name,
          ),
          contactInput(
            context: context,
            hintText: 'Message',
            isMessage: true,
            textEditingController: name,
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: BorderRadius.circular(12)),
            child: Text(
              'Send Form',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
