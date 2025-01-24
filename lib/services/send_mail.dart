import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void sendEmail(String recipientEmail, String eventName) async {
  String username = 'ejohdaryl@gmail.com';  
  String password = 'pkqa iroc rfof sxdp';   

  final smtpServer = gmail(username, password);  
  final message = Message()
    ..from = Address(username, 'Event Connect')  
    ..recipients.add(recipientEmail) 
    ..subject = 'Invitation Letter for  $eventName'    
    ..text = 'Hope you will be there! '; 
    

  try {
    final sendReport = await send(message, smtpServer);
    print('Email sent successfully: ${sendReport.toString()}');
  } catch (e) {
    print('Error sending email: $e');
  }
}