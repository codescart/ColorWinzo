import 'dart:convert';

import 'package:ColorWinzo/widgets/walletapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/colorpredication/home.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/widgets/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class popup extends StatefulWidget {
  final name;
  final color;
  final int num;
  popup({required this.name, required this.color, required this.num, });
  @override
  State<popup> createState() => _popupState();
}
bool _loading =false;
class _popupState extends State<popup> {
  bool showvalue = true;
  final amount = TextEditingController();
  List<int> dataItems = [10, 100, 1000];
  int selectedCard = 10;
  int plusminus = 1;
  @override
  Widget build(BuildContext context) {
    int amos = selectedCard * plusminus;
    amount.text = amos.toString();
    return AlertDialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      backgroundColor: Colors.transparent,
      content: Container(

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        height: 345.h,
        width: 500.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50.h,
              width: 400.w,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.w),
                  topRight: Radius.circular(15.w),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.h),
                child: Text(
                  widget.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '    Contract Money',
                style: TextStyle(
                    color: kBlackColor900,
                    fontWeight: FontWeight.w900,
                    fontSize: 12.sp),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50.h,
                width: 220.w,
                child: ListView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: dataItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCard = dataItems[index] as int;
                          });
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding:  EdgeInsets.all(8.0.r),
                              child: Container(
                                height: 45.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  border: Border.all(
                                      color: selectedCard == dataItems[index]
                                          ? custonbtn
                                          : kGreenLightColor,
                                      width: 2.5),
                                  color: selectedCard == dataItems[index]
                                      ? kRedLightColor
                                      : kGreenLightColor,
                                ),
                                child: Center(
                                  child: Text(
                                    dataItems[index].toString(),
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: selectedCard == dataItems[index]
                                    ? Container(
                                        height: 12.r,
                                        width: 12.r,
                                        child:  CircleAvatar(
                                          child: Icon(
                                            Icons.check_outlined,
                                            size: 10.sp,
                                          ),
                                        ),
                                      )
                                    : Container()),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding:  EdgeInsets.only(left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        plusminus--;
                        int amo = selectedCard * plusminus;
                        if (amo <= 10) {
                          setState(() {
                            amount.text = amo.toString();
                          });
                        } else {
                          amount.text = '10';
                        }
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      color: Colors.grey.shade200,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: custonbtn, width: 2),
                          color: kRedLightColor,
                        ),
                        height: 40.h,
                        width: 65.w,
                        child: Center(child: Icon(Icons.remove)),
                      ),
                    ),
                  ),
                  Container(
                    width: 50.w,
                    child: TextField(
                      controller: amount,
                      readOnly: true,
                      style: TextStyle(color: kBlackColor900),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        plusminus++;
                        int amo = selectedCard * plusminus;
                        amount.text = amo.toString();
                      });

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      color: Colors.grey.shade200,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: custonbtn, width: 2),
                          color: kRedLightColor,
                        ),
                        height: 40.h,
                        width: 65.w,
                        child: Center(child: Icon(Icons.add)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 15.w),
                  child: Text('Total Contract money is '+amount.text,
                    style: TextStyle(
                      fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      color: kBlackColor900
                    ),),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: Checkbox(
                    checkColor: Colors.grey,
                    activeColor: Colors.white,
                    value: this.showvalue,
                    onChanged: (bool? value) {
                      setState(() {
                        this.showvalue = value!;
                        print(showvalue);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'I agree',
                          style: TextStyle(
                              color: kGreyColor800,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900)),
                      TextSpan(
                          text: '  PRESALE RULE',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: custonbtn,
                              fontWeight: FontWeight.w900))
                    ]),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        popups=false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                          color: kGreyColor800),
                    ),
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  showvalue == true
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              popups=false;
                            });
                            bet(amount.text);

                          },
                          child: Text(
                            'CONFIRM',
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: custonbtn,
                                fontWeight: FontWeight.w900),
                          ))
                      : TextButton(
                          onPressed: () {},
                          child: Text(
                            'CONFIRM',
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: kGreyColor400,
                                fontWeight: FontWeight.w900),
                          ))
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
  bet(String amount) async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    setState(() {
      _loading = true;
    });

    final response = await http.get(
      Uri.parse(Apiconst.bet+'=$userid&amount=$amount&number=${widget.num.toString()}'),

    );

    var data = jsonDecode(response.body);
    print(data);
    print('aaaaaaaaaaaaaaaaa');
    print('rrrrrrrrrrrrrrrrrr');


    if (data["error"] == "200") {
      qwe(0);
      setState(() {
        fetchwalletview();
        _loading = false;
      });

      print('qqqqqqqqqqqqqqqq');
      print('rrrrrrrrrrrrrr');
Navigator.pop(context);
    } else {
      setState(() {
        _loading = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, kBlackColor900);
      print("Error");
    }
  }
}
