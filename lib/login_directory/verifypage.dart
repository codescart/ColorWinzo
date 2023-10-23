

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/home_directory/homePage.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:ColorWinzo/widgets/flushbar.dart';
import 'package:pinput/pinput.dart';


class veryfy extends StatefulWidget {
  final String mobile;
  final String pin;
  final String userid;


  veryfy({super.key, required this.mobile, required this.pin, required this.userid,});

  @override
  State<veryfy> createState() => _veryfyState();
}

class _veryfyState extends State<veryfy> {
  bool _loading =false;
   Color focusedBorderColor = kBlackColor900;
   Color fillColor = kRedLightColor;
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
  TextEditingController phoneController = TextEditingController();



  var code = "";

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image:AssetImage(background)
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
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
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Text(
                    PASSWORD,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp,
                      color: kBlackColor900
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding:  EdgeInsets.only(top: 5.h),
                    child: Text(pinenter,
                      style: TextStyle(color:kBlackColor800),),
                  ),
                ),
                Center(
                  child: Padding(
                    padding:  EdgeInsets.only(top: 5.h),
                    child: Text('+91'+"${widget.mobile}",
                      style: TextStyle(color:kBlackColor800),),
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.only(left: 18,right: 18),
                  child: Center(
                    child: Container(
                      height: 40.h,
                      child: Pinput(
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
                SizedBox(height: 25.h,),
                _loading==false?
                CustomButton(
                  text: submit,
                  textColor: kWhiteColor,
                  onTap: () {
                    print(code);
                    print('wwwwwwwwww');
                    login( code);
                  },
                )
                    : Padding(
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


              ],
            )

          ],
        ),
      ),
    );
  }
   login(String code)async {
     setState(() {
       _loading = true;
     });

     print(code);
     print("hhhhhhh");
     print(code);
       if (widget.pin == code) {
         setState(() {
           _loading = false;
         });
         final prefs = await SharedPreferences.getInstance();
         final key = 'userId';
         final userId = widget.userid.toString();
         prefs.setString(key, userId);
         print(userId);
         print('qqqqqqqqqqqqqqqq');
         print('rrrrrrrrrrrrrr');
         Navigator.pushReplacement(
             context, MaterialPageRoute(builder: (context) => homepage()));
       }
     else {
         setState(() {
           _loading = false;
         });
         Utils.flushBarErrorMessage(errorpin, context, kBlackColor900);
       }
     }
   }
