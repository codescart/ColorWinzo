import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/login_directory/login_page.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:ColorWinzo/widgets/flushbar.dart';
import 'package:http/http.dart'as http;

import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class resetchangepassword extends StatefulWidget {
  final String? resetpass;

  const resetchangepassword({Key? key, this.resetpass,}) : super(key: key);

  @override
  State<resetchangepassword> createState() => _resetchangepasswordState();
}

class _resetchangepasswordState extends State<resetchangepassword> {
  TextEditingController New_Password=TextEditingController();
  TextEditingController Change_Password=TextEditingController();
  Color focusedBorderColor = kBlackColor900;
  Color fillColor = kRedLightColor;
  Color borderColor = custonbtn;
  Color activecolor = kGreenLightColor;

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
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }
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
              Resetpassword,
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
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image:AssetImage(background)
              ),
            ),
            child: ListView(
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
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
                  children: [
                    SizedBox(height: 50,),
                    Padding(
                      padding:  EdgeInsets.only(top: 5.h,left: 20.w),
                      child: Text(newepin,
                        style: TextStyle(color:kBlackColor800),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18,right: 18),
                      child: Center(
                        child: Container(

                          height: 40.h,
                          child: Pinput(
                            controller: New_Password,

                            length: 6,
                            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            followingPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: activecolor,
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
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
                    SizedBox(height: 20,),
                    Padding(
                      padding:  EdgeInsets.only(top: 5.h,left: 20.w),
                      child: Text( confPASSWORD,
                        style: TextStyle(color:kBlackColor800),),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 18,right: 18),
                      child: Center(
                        child: Container(

                          height: 40.h,
                          child: Pinput(
                            controller:Change_Password,

                            length: 6,
                            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            followingPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: activecolor,
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
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
                    _loading == false
                        ? Center(
                      child: CustomButton(
                        text: Next,
                        textColor: Colors.white,
                        onTap: () async {
                          Resetpass(New_Password.text,Change_Password.text );

                        },
                      ),
                    )
                        : Center(
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
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
              ],
            ),
          ),
        ));
  }
  Resetpass(String New_Password,String Change_Password ) async {
    setState(() {
      _loading = true;
    });

    final response = await http.post(
      Uri.parse(Apiconst.Reset_Password),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
          "mobile": widget.resetpass.toString(),
          "password":New_Password,
          "con_pass":Change_Password,
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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => login_page()));
    } else {
      setState(() {
        _loading = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, kBlackColor900);


      print("Error");
    }
  }

}