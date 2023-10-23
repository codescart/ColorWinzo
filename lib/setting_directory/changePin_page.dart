import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:ColorWinzo/widgets/flushbar.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({Key? key}) : super(key: key);

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  bool _loading =false;
  Color focusedBorderColor = kBlackColor900;
  Color fillColor = kRedLightColor;
  Color activeColor = ktealcolor;
  Color borderColor = custonbtn;
  TextEditingController oldpincontroller = TextEditingController();
  TextEditingController newpincontroller = TextEditingController();
  TextEditingController confirmpincontroller = TextEditingController();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(appbarbg), opacity: 0.8),
            ),
          ),
          leading: IconButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              icon: Image.asset(
                closebtn,
                height: 70,
                width: 70,
              )),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          title: Text(
            AAPBARchangepin,
            style: GoogleFonts.aclonica(
              textStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Container(
          height: double.infinity.h,
          width: double.infinity.w,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image:AssetImage(background)
            ),
          ),
          child:   ListView(
          shrinkWrap: true,
            children: [
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
              Padding(
                padding:  EdgeInsets.only(top: 5.h,left: 25.w,bottom: 7.h),
                child: Text(oldpin,
                  style: TextStyle(color:kBlackColor800),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18,right: 18),
                child: Center(
                  child: Container(
                    height: 40.h,
                    child: Pinput(
                      controller: oldpincontroller,
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
                          color: activeColor,
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
              ),
              Padding(
                padding:  EdgeInsets.only(top: 5.h,left: 25.w,bottom: 7.h),
                child: Text(newepin,
                  style: TextStyle(color:kBlackColor800),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18,right: 18),
                child: Center(
                  child: Container(
                    height: 40.h,
                    child: Pinput(
                      controller: newpincontroller,
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
                          color: activeColor,
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
              ),
              Padding(
                padding:  EdgeInsets.only(top: 5.h,left: 25.w,bottom: 7.h),
                child: Text(confirmpin,
                  style: TextStyle(color:kBlackColor800),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18,right: 18),
                child: Center(
                  child: Container(
                    height: 40.h,
                    child: Pinput(
                      controller: confirmpincontroller,
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
                          color: activeColor,
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
              ),
              SizedBox(height: 40.h,),

              _loading==false?
              Center(
                child: CustomButton(
                  text: submit,
                  textColor: kWhiteColor,
                  onTap: () {

                   Changepin(
                     oldpincontroller.text,
                       newpincontroller.text,
                       confirmpincontroller.text,

                   );

                  },
                ),
              )
                  : Center(
                    child: Padding(
                padding:  EdgeInsets.all(4.0),
                child: Container(
                    height: 30.r,
                    width: 30.r,
                    child: CircularProgressIndicator(
                        color: custonbtn,
                        strokeWidth: 4,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(custonbtn)),
                ),
              ),
                  )


            ],
          ),
        ),

      ),
    );
  }


  Changepin(String oldpincontroller,String newpincontroller,String confirmpincontroller ) async {

    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    print(oldpincontroller);
    print(newpincontroller);
    print(confirmpincontroller);
    setState(() {
      _loading = true;
    });

    final response = await http.post(
      Uri.parse(Apiconst.change_password),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": '${userid}',
        "old_password":oldpincontroller,
        "new_password": newpincontroller,
        "confirm_password": confirmpincontroller,
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
