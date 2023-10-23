import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/login_directory/registrationotp.dart';
import 'package:ColorWinzo/login_directory/resetpasswordnumber.dart';
import 'package:ColorWinzo/login_directory/verifypage.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:ColorWinzo/widgets/flushbar.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  bool _loading = false;

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor: Colors.black,
              title: Text('Are you sure?', style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: kBlackColor900,
              ),),
              content: Text('Do you want to exit from App', style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: kBlackColor900,
              ),),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();

                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: SafeArea(
          child: Scaffold(
        body: Container(
          height: double.infinity.h,
          width: double.infinity.w,
          decoration: BoxDecoration(
            image:
                DecorationImage(fit: BoxFit.fill, image: AssetImage(background)),
          ),
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                Container(
                  height: 150.r,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(bg_theme)),
                  ),
                ),
                Center(
                  child: Container(
                    height: 200.r,
                    width: 200.r,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill, image: AssetImage(applogo)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill, image: AssetImage(loginfield))),
                      child: Center(
                        child: IntlPhoneField(
                          disableLengthCheck: true,
                          controller: phoneController,
                          focusNode: focusNode,
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.bottom,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: const Color(0xFF075E54),
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: const EdgeInsets.only(bottom: 13.0),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide: BorderSide(color: Color(0xFFF65054)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide: BorderSide(color: Color(0xFFF65054)),
                            ),
                            hintText: Mobilenumber,
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 15,
                            ),
                          ),
                          languageCode: "IN",
                          initialCountryCode: 'IN',
                          dropdownIcon: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: Colors.white,
                          ),
                          dropdownTextStyle: (TextStyle(color: Colors.white)),
                          dropdownIconPosition: IconPosition.trailing,
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                          onCountryChanged: (country) {
                            print('Country changed to: ' + country.name);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 18.w),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => resetpassphone()));
                      },
                      child: Text(
                        forPASSWORD,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                _loading == false
                    ? Center(
                        child: CustomButton(
                          text: Next,
                          textColor: Colors.white,
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              if (phoneController!.length != 10) {
                                return ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Enter Valid Number')),
                                );
                              }
                              _userlogin(phoneController.text);
                            }
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
          ),
        ),
      )),
    );
  }

  String? validateName(String? value) {
    if (value!.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  _userlogin(String phoneController) async {
    setState(() {
      _loading = true;
    });

    final response = await http.post(
      Uri.parse(Apiconst.Login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "mobile": phoneController,
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
      final pin = data['pin'];
      final userid = data['id'];

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => veryfy(mobile: phoneController, pin: pin,userid:userid)));
    } else {
      setState(() {
        _loading = false;
      });
      final otp = data['otp'];
      Utils.flushBarErrorMessage(data['msg'], context, kBlackColor900);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OtpPage(
                mobile: phoneController, code: otp,
              )));

      print("Error");
    }
  }
}
