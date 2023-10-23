import 'dart:convert';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:http/http.dart'as http;


var telegram;

Future<void> fetchlauncherdata() async {

  final url = Uri.parse(Apiconst.teligramlink);

  final response = await http.get(
    url,
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body)['data'];
    print(responseData);

    telegram = responseData['telegram'];
    print(telegram);
    //return UserProfile.fromJson(responseData);
  } else {
    throw Exception("Failed to fetch notifications");
  }
}
