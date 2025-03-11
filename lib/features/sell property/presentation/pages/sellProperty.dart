import 'package:flutter/material.dart';
import 'package:tura_app/features/contact%20us/presentaion/widgets/contactInput.dart';
import 'package:tura_app/features/sell%20property/data/mailservice.dart';

class Sellproperty extends StatefulWidget {
  const Sellproperty({super.key});

  @override
  State<Sellproperty> createState() => _SellpropertyState();
}

bool mailStatus = true;

class _SellpropertyState extends State<Sellproperty> {
  TextEditingController namesController = new TextEditingController();
  TextEditingController phonesController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController numberPropertiesController =
      new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController messageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Property'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
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
              textEditingController: namesController,
            ),
            contactInput(
              context: context,
              hintText: 'Enter your Phone Number',
              isMessage: false,
              textEditingController: phonesController,
            ),
            contactInput(
              context: context,
              hintText: 'Enter your Email',
              isMessage: false,
              textEditingController: emailController,
            ),
            contactInput(
              context: context,
              hintText: 'Property Location',
              isMessage: false,
              textEditingController: locationController,
            ),
            contactInput(
              context: context,
              hintText: 'Number of Properties',
              isMessage: false,
              textEditingController: numberPropertiesController,
            ),
            contactInput(
              context: context,
              hintText: 'Price of Property in FRW',
              isMessage: false,
              textEditingController: priceController,
            ),
            contactInput(
              context: context,
              hintText: 'Message',
              isMessage: true,
              textEditingController: messageController,
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  mailStatus = false;
                });
                String messageToSend = """
  <html>
    <body style="font-family: Arial, sans-serif; color: #333;">
      <h2 style="color: #2E6C80;">Property Inquiry Details</h2>
      <table style="width: 100%; border-collapse: collapse; border: 1px solid #ddd;">
        <tr style="background-color: #f2f2f2;">
          <td style="padding: 10px; font-weight: bold;">Names:</td>
          <td style="padding: 10px;">${namesController.text}</td>
        </tr>
        <tr style="background-color: #f9f9f9;">
          <td style="padding: 10px; font-weight: bold;">Phone Number:</td>
          <td style="padding: 10px;">${phonesController.text}</td>
        </tr>
        <tr style="background-color: #f2f2f2;">
          <td style="padding: 10px; font-weight: bold;">Email:</td>
          <td style="padding: 10px;">${emailController.text}</td>
        </tr>
        <tr style="background-color: #f9f9f9;">
          <td style="padding: 10px; font-weight: bold;">Location:</td>
          <td style="padding: 10px;">${locationController.text}</td>
        </tr>
        <tr style="background-color: #f2f2f2;">
          <td style="padding: 10px; font-weight: bold;">Number of Properties:</td>
          <td style="padding: 10px;">${numberPropertiesController.text}</td>
        </tr>
        <tr style="background-color: #f9f9f9;">
          <td style="padding: 10px; font-weight: bold;">Price:</td>
          <td style="padding: 10px;">${priceController.text}</td>
        </tr>
        <tr style="background-color: #f2f2f2;">
          <td style="padding: 10px; font-weight: bold;">Message:</td>
          <td style="padding: 10px;">${messageController.text}</td>
        </tr>
      </table>
      
    </body>
  </html>
""";

                final mailResponse =
                    await CustomMailService().sendEmail(messageToSend);
                if (mailResponse != null) {
                  setState(() {
                    mailStatus = true;
                    namesController.clear();
                    phonesController.clear();
                    emailController.clear();
                    locationController.clear();
                    numberPropertiesController.clear();
                    priceController.clear();
                    messageController.clear();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Message Sent Successfully'),
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.yellow[600],
                    borderRadius: BorderRadius.circular(12)),
                child: (mailStatus)
                    ? Text(
                        'Send Form',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: CircularProgressIndicator.adaptive(),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
