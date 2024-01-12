import 'dart:convert';

import 'package:http/http.dart';

class PostNotificaion {
  final Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  final String key =
      'AAAAV2UV3bE:APA91bFlsxm7PFFroruoeUHP-T42bakR0dh7vRMAYkjs1AiODsC93XRO4NW3ZZ6Flh6ZqE8KhfOdF3kE39gDYpVHooqR-GVVmVhdykPRZ30zFgAa5WmcPtoHyuDVZyS1hGVNPfN4usBE';

  void sendNotification({
    required String title,
    required String token,
    required String email,
    required String sendMoney,
  }) async {
    Map<String, dynamic> body = {
      'to': token,
      "priority": "high",
      'notification': {
        'title': title,
        'body': "Email : $email, Send Money : $sendMoney",
      },
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
    };

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'key=$key'
    };

    Response response =
        await post(url, body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      print('Notification send succsecfull');
    }
  }
}
