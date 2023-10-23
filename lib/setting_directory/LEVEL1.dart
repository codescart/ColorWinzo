import 'dart:convert';

import 'package:ColorWinzo/Api_controller/level3controller.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class levelone extends StatefulWidget {
  const levelone({Key? key}) : super(key: key);

  @override
  State<levelone> createState() => _leveloneState();
}

class _leveloneState extends State<levelone> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w,),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(amtlevel1==null?'0.0':
                  amtlevel1.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp),
                )),
          ),

          Padding(
            padding:EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            child: FutureBuilder<List<level3>>(
                future: qwe(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 700,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(nodatafound),
                                )),
                          ),
                          Text(
                            "No LEVEL 1 History",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp,
                                color: kBlackColor900
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child:ListTile(

                                leading:
                                snapshot.data![index].userimg==null? CircleAvatar(
                                  backgroundImage: AssetImage('assets/Avatar10.png'),
                                ):
                                CircleAvatar(
                                  backgroundImage: NetworkImage(Apiconst.imgurl+'${snapshot.data![index].userimg}'),
                                ),
                                title: Text(
                                  '${snapshot.data![index].username}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp),
                                ),
                                trailing: Text('Comission : '+'${snapshot.data![index].amount}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.sp),
                                ),
                              )
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future<List<level3>> qwe() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    final response =
    await http.get(Uri.parse(Apiconst.reflevel1+'$userid'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['level1'] as List<dynamic>;
      print(response);
      print(jsonData);
      print('ttttttttttttttttt');
      return jsonData.map((item) => level3.fromJson(item)).toList();

    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  void initState() {
    teamcommision();
    super.initState();

  }
  var amtlevel1;


  teamcommision() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.post(
      Uri.parse(Apiconst.reftotalcommision+'$userid'),

    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['error'] == '200') {
      setState(() {
        amtlevel1 = data['amtlevel1'];

      });
    }
  }
}
