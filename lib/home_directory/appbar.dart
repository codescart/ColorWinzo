import 'dart:convert';
import 'package:ColorWinzo/widgets/launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/colorpredication/balance_recharge.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/setting_directory/setting.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBarTwo extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBarTwo({Key? key})
      : preferredSize = const Size.fromHeight(54.0),
        super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomAppBarTwoState createState() => _CustomAppBarTwoState();
}

class _CustomAppBarTwoState extends State<CustomAppBarTwo> {
  @override
  void initState() {
    viewprofile();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return map == null
        ? AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(appbarbg),
                    opacity: 0.8),
              ),
            ),
          )
        : AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(appbarbg),
                    opacity: 0.8),
              ),
            ),
            automaticallyImplyLeading: false,
            leading: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(sideappbar))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      child: Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 2, left: 5),
                    child: Container(
                      child: Center(
                          child: map['photo'] == null
                              ? CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(avtar),
                                  radius: 20,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 35,
                                      backgroundImage: AssetImage(profilebg)),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      Apiconst.imgurl + map['photo']),
                                  radius: 20,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 35,
                                      backgroundImage: AssetImage(profilebg)),
                                )),
                    ),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          map['full_name'] == null ? name : map['full_name'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          map['mobile'] == null ? number : map['mobile'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            leadingWidth: 180,
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        setState(() {
                          viewprofile();
                        });
                      },
                      icon: Image.asset(
                        refreshbtn,
                        height: 70,
                        width: 70,
                      )),
                  IconButton(
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => balance()));
                      },
                      icon: Image.asset(
                        bank,
                        height: 70,
                        width: 70,
                      )),
                  Text(
                    map['wallet'] == null ? balence : map['wallet'] + '/-',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () async {
                    Launcher.openteligram();
                  },
                  icon: Image.asset(
                    kefu,
                    height: 70,
                    width: 70,
                  )),
              IconButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: Setting_page(),
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500)));
                  },
                  icon: Image.asset(
                    setting,
                    height: 70,
                    width: 70,
                  )),
            ],
          );
  }


  var map;
  viewprofile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.post(
      Uri.parse(Apiconst.profile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": '${userid}',
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['error'] == '200') {
      setState(() {
        map = data['userdata'];
      });
    }
  }
}
