import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/login_directory/register_page.dart';
import 'package:ColorWinzo/login_directory/resetchangepassword.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:ColorWinzo/widgets/flushbar.dart';
import 'package:pinput/pinput.dart';

class veryfyresetpassword extends StatefulWidget {
  final String? resetpass;
  final String? pin;

  veryfyresetpassword({Key? key, this.resetpass, required this.pin,});

  @override
  State<veryfyresetpassword> createState() => _veryfyresetpasswordState();
}

class _veryfyresetpasswordState extends State<veryfyresetpassword> {
  TextEditingController _otpController=TextEditingController();
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
  var code = "";
  int _counter = 180;
  late Timer _timer;
  _startTimer() {
    _counter = 180; //time counter
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }
  @override
  void initState() {
    // loginWithPhone();
    _startTimer();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  height: 200.r,
                  width: 200.r,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image:AssetImage(applogo)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [

                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        verifyphone,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp,
                            color: kBlackColor900
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 5.h),
                        child: Text(codeissend,
                          style: TextStyle(color:kBlackColor800),),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 5.h),
                        child: Text('+91'+"${widget.resetpass}",
                          style: TextStyle(color:kBlackColor800),),
                      ),
                      SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.only(left: 18,right: 18),
                        child: Center(
                          child: Container(

                            height: 40.h,
                            child: Pinput(
                              controller: _otpController,
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
                      CustomButton(
                        text: submit,
                        textColor: kWhiteColor,
                        onTap: () {
                          if(_otpController.text.isEmpty){
                            print('hhhh');
                          }
                          else if(_otpController.text.length != 6){
                            print('wwwww');
                          }
                          else{
                            verifyOTP(code);
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('OTP Not Recived ?  ',
                              style:
                              TextStyle(fontSize: 15.sp, color: Colors.blue),
                            ),

                            _counter<1?TextButton(
                              onPressed: _counter < 1
                                  ? () {
                                _startTimer();
                                // loginWithPhone();
                                // widget.verificationInteractor.verifyNumber();
                              } : null,
                              child: Text("Resend OTP".toUpperCase(),),


                            ):  Text(
                              '0:${_counter.toString().padLeft(2, '0')} ' + "second left",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  bool _loading =false;
  verifyOTP(String code)async {
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

      print('qqqqqqqqqqqqqqqq');
      print('rrrrrrrrrrrrrr');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => resetchangepassword(resetpass: widget.resetpass,),));
    }
    else {
      setState(() {
        _loading = false;
      });
      Utils.flushBarErrorMessage(errorpin, context, kBlackColor900);
    }
  }
}