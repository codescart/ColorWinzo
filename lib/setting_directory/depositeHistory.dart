import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/Api_controller/deposit_controller.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class Deposit_History extends StatefulWidget {
  const Deposit_History({Key? key}) : super(key: key);

  @override
  State<Deposit_History> createState() => _Deposit_HistoryState();
}

class _Deposit_HistoryState extends State<Deposit_History> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<List<deposit_history>>(
          future: qwe(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                          )
                      ),
                    ),
                    Text(
                      "No Deposit History",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.sp,
                        color: kBlackColor900
                      ),
                    ),

                  ],
                ),
              );
            }
            else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: height * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: snapshot.data![index].status=='0'?Colors.red:
                            snapshot.data![index].status=='1'?Colors.orangeAccent:Colors.green,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        // color: Color(0xfffe4d6a),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 15, 0),
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        Text("₹"+"${snapshot.data![index].amount}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20.sp)),
                                        Text(
                                          "Deposit",
                                          style: TextStyle(
                                              fontFeatures: [
                                                FontFeature.superscripts()
                                              ],
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                                Column(mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        Text("${snapshot.data![index].date}",
                                            style: TextStyle(
                                                color: Colors.black.withOpacity(0.5),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp)),
                                        Text(
                                          "Date",
                                          style: TextStyle(
                                              fontFeatures: [
                                                FontFeature.superscripts()
                                              ],
                                              color: Colors.black.withOpacity(0.8),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 8.sp),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        Text("${snapshot.data![index].time}",
                                            style: TextStyle(
                                                color: Colors.black.withOpacity(0.5),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp)),
                                        Text(
                                          "Time",
                                          style: TextStyle(
                                              fontFeatures: [
                                                FontFeature.superscripts()
                                              ],
                                              color: Colors.black.withOpacity(0.8),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 8.sp),
                                        ),
                                      ],
                                    ),
                                    Text("${snapshot.data![index].type}",
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp)),
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        Text(snapshot.data![index].status=='0'?'Failed':
                                        snapshot.data![index].status=='1'?'Pending':"Success",
                                            style: TextStyle(
                                                color: snapshot.data![index].status=='0'?Colors.red:
                                                snapshot.data![index].status=="1"?Colors.orangeAccent:Colors.green,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp)),
                                        Text(
                                          "Status",
                                          style: TextStyle(
                                              fontFeatures: [
                                                FontFeature.superscripts()
                                              ],
                                              color: Colors.black.withOpacity(0.8),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 8.sp),
                                        ),
                                      ],
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
  Future<List<deposit_history>> qwe()  async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    final response = await http
        .get(Uri.parse(Apiconst.Deposit_histry+'user_id=$userid'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      print(response);
      print('kkkkkkkkkkkkkkkkkkkkkkkk');
      return jsonData.map((item) => deposit_history.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

}
