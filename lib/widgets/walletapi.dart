import 'dart:convert';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';



var walt;

Future<void> fetchwalletview() async {
  final prefs = await SharedPreferences.getInstance();
  final userid = prefs.getString("userId");
  final url = Uri.parse(Apiconst.walletamount + 'userid=$userid');

  final response = await http.get(
    url,
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body)['data'];
    print(responseData);

    walt = responseData['wallet'];
    print(walt);
    //return UserProfile.fromJson(responseData);
  } else {
    throw Exception("Failed to fetch notifications");
  }
}
