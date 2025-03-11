import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class CustomMailService {
  final gmailsmtp = gmail(
    dotenv.env['GMAIL_MAIL']!,
    dotenv.env['GMAIL_PASSWORD']!,
  );

  Future sendEmail(text) async {
    final message = Message()
      ..from = Address(dotenv.env['GMAIL_MAIL']!)
      ..recipients.add(dotenv.env['GMAIL_MAIL']!)
      ..subject = "Requesting To Sell Property"
      ..html = text;

    try {
      final sendReport = await send(message, gmailsmtp);
      print('message i will use ....... ${sendReport}');
      return sendReport;
    } catch (e) {
      return e.toString();
    }
  }
}
