import 'package:flutter/material.dart';
import 'package:tura_app/features/contact%20us/presentaion/widgets/contactInput.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

TextEditingController emailController = new TextEditingController();
TextEditingController namesController = new TextEditingController();
TextEditingController messageController = new TextEditingController();
final _contactFormKey = GlobalKey<FormState>();

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.secondary,
            )),
        title: Text(
          'Contact Us',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Get In Touch',
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                child: Form(
                  key: _contactFormKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      contactInput(
                          context: context,
                          hintText: 'Name',
                          isMessage: false,
                          textEditingController: namesController),
                      contactInput(
                          context: context,
                          hintText: 'Email',
                          isMessage: false,
                          textEditingController: emailController),
                      contactInput(
                          context: context,
                          hintText: 'Message',
                          isMessage: true,
                          textEditingController: messageController),
                      GestureDetector(
                        onTap: () {
                          _contactFormKey.currentState!.validate();
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: screenHeight * 0.06,
                          width: screenWidth * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Send Message",
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.008,
              ),
              Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.008,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    color: Theme.of(context).colorScheme.secondary,
                    Icons.phone,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '+250-782-788-401',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'support@turaestates.com',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Center(
                child: Text(
                  'Follow Us',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      '././lib/images/facebookNew.png',
                      color: Theme.of(context).colorScheme.secondary,
                      height: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      '././lib/images/instagram.png',
                      color: Theme.of(context).colorScheme.secondary,
                      height: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      '././lib/images/twitter-alt.png',
                      color: Theme.of(context).colorScheme.secondary,
                      height: 30,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
