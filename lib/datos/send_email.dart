
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

const String user = 'help.fmt.team@gmail.com';
const String pass = 'e53t3CKY_*.';

final smtpServer = gmail(user, pass);

sendEmail(String recipient, String subject, String text) async {
  final message = Message()
    ..from = Address(user)
    ..recipients.add(recipient)
    ..subject = subject
    ..text = text;

  try {
    final sendReport = await send(message, smtpServer);
    return true;
  }on MailerException catch (e) {
    return null;
  }

}