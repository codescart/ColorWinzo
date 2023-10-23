import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/home_directory/homePage.dart';
import 'package:ColorWinzo/login_directory/registrationotp.dart';
import 'package:ColorWinzo/login_directory/verifypage.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:ColorWinzo/widgets/flushbar.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';




class registerpage extends StatefulWidget {
final mobile;
registerpage( {required this.mobile,});

  @override
  State<registerpage> createState() => _registerpageState();
}
var code = "";
class _registerpageState extends State<registerpage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController referalController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  bool _loading =false;

  FocusNode focusNode = FocusNode();

  Color focusedBorderColor = kBlackColor900;
  Color fillColor = kRedLightColor;
  Color activecolor = textfield;
  Color borderColor = custonbtn;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: kWhiteColor),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity.h,
            width: double.infinity.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image:AssetImage(background)
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Container(
                    height: 150.r,
                    width: double.infinity.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image:AssetImage(bg_theme)
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 200.r,
                    width: 200.r,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image:AssetImage(applogo)
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 55.w,right: 55.w),
                  child: Column(
                    children: [
                      Container(
                        height: 35.h,


                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(loginfield)
                            )
                        ),

                        child: Center(
                          child: TextField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            textAlignVertical: TextAlignVertical.bottom,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: const Color(0xFF075E54),
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: const EdgeInsets.only(bottom: 13.0,left: 10),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Colors.white, width: 1),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Colors.white, width: 1),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Color(0xFFF65054)),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Color(0xFFF65054)),
                              ),
                              prefixIcon: Icon(Icons.person, color: kWhiteColor,),
                              hintText: username,
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        height: 35.h,

                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                                image: AssetImage(loginfield)
                            )
                        ),

                        child: Center(
                          child: TextField(
                            controller: ageController,

                            keyboardType: TextInputType.name,
                            textAlignVertical: TextAlignVertical.bottom,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: const Color(0xFF075E54),
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: const EdgeInsets.only(bottom: 13.0,left: 10),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Colors.white, width: 1),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Colors.white, width: 1),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Color(0xFFF65054)),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Color(0xFFF65054)),
                              ),
                              prefixIcon: Icon(Icons.person, color: kWhiteColor,),
                              hintText: age,
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        height: 35.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(loginfield)
                            )
                        ),

                        child: Center(
                          child: TextField(
                            controller: referalController,
                            keyboardType: TextInputType.name,
                            textAlignVertical: TextAlignVertical.bottom,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: const Color(0xFF075E54),
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: const EdgeInsets.only(bottom: 13.0,left: 10),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Colors.white, width: 1),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Colors.white, width: 1),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Color(0xFFF65054)),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Color(0xFFF65054)),
                              ),
                              prefixIcon: Icon(Icons.person, color: kWhiteColor,),
                              hintText: referal,
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          createPASSWORD,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 40.h,
                          child: Pinput(
                            controller: pinController,

                            onChanged: (value) {
                              setState(() {
                                code = value;
                              });
                            },
                            length: 6,

                            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            followingPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: activecolor,
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            errorPinTheme: defaultPinTheme.copyBorderWith(

                              border: Border.all(color: Colors.redAccent),
                            ),
                            disabledPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),

                      _loading==false?
                      Center(
                        child: CustomButton(

                          text: Next,
                          textColor: Colors.white,
                          onTap: ()async {
                            Register(nameController.text,code,ageController.text,referalController.text);
                          },
                        ),
                      )
                          :
                      Center(
                        child: Padding(
                          padding:  EdgeInsets.all(4.0),
                          child: Container(
                            height: 30.r,
                            width: 30.r,
                            child: CircularProgressIndicator(
                                color: custonbtn,
                                strokeWidth: 4,
                                valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)),
                          ),
                        ),
                      )
                    ],
                  ),
                )


              ],
            ),
          ),
        )
    );
  }
  Register(
      String nameController,
      String code,
      String ageController,
      String referalController) async {
    final mob = '${widget.mobile}';
    setState(() {
      _loading = true;
    });
print(widget.mobile);
print(code);
print('gggggggggggggggggggggg');
    final response = await http.post(
      Uri.parse(Apiconst.register),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        "name": nameController,
        "mobile": mob.toString(),
        "pin": code,
        "age": ageController,
        "refid": referalController,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print('aaaaaaaaaaaaaaaaa');
    print('rrrrrrrrrrrrrrrrrr');

    if (data["error"] == "200") {
      setState(() {
        _loading = false;
      });
      final prefs = await SharedPreferences.getInstance();
      final key = 'userId';
      final userId =data['id'].toString() ;
      prefs.setString(key, userId);
      print(userId);
      print('qqqqqqqqqqqqqqqq');
      print('rrrrrrrrrrrrrr');
      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context)=>homepage()));
    } else {
      setState(() {
        _loading = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, kBlackColor900);
      print("Error");
    }
  }
}
