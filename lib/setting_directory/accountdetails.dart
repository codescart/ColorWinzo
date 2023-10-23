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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Account_details extends StatefulWidget {
  const Account_details({Key? key}) : super(key: key);

  @override
  State<Account_details> createState() => _Account_detailsState();
}

bool _loading = false;

class _Account_detailsState extends State<Account_details> {
  TextEditingController account_no = TextEditingController();
  TextEditingController IFSC = TextEditingController();
  TextEditingController Branch = TextEditingController();
  TextEditingController Bank_Name = TextEditingController();
  TextEditingController UPI = TextEditingController();
  TextEditingController Ac_holder = TextEditingController();

  @override
  void initState() {
    accountview();
    Acdetail();
    super.initState();
  }

  Acdetail() {
    account_no.text = Account == null ? '' : Account['account_no'].toString();
    IFSC.text = Account == null ? '' : Account['ifsc'].toString();
    Branch.text = Account == null ? '' : Account['branch'].toString();
    Bank_Name.text = Account == null ? '' : Account['bank_name'].toString();
    UPI.text = Account == null ? '' : Account['upi'].toString();
    Ac_holder.text = Account == null ? '' : Account['name'].toString();
  }

  var Account;
  accountview() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    final response = await http.post(
      Uri.parse(Apiconst.accountview + 'user_id=$userid'),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['error'] == '200') {
      setState(() async {
        Account = data['userdata'];
        Acdetail();
        final prefs2 = await SharedPreferences.getInstance();
        final key1 = 'acId';
        final acId = Account['id'];
        prefs2.setString(key1, acId);
        print(acId);
        print('nnnnnnnnnnnnnnnnnnnnnnnn');
      });
    }
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
        title: Text(
          AddAccount,
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
          image:
              DecorationImage(fit: BoxFit.fill, image: AssetImage(background)),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20.r),
          children: [
            SizedBox(
              height: 50.h,
            ),
            Container(
              height: 35.h,
              width: 220.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(loginfield))),
              child: TextField(
                controller: Ac_holder,
                // focusNode: focusyear,
                keyboardType: TextInputType.name,
                textAlignVertical: TextAlignVertical.bottom,
                style: const TextStyle(color: Colors.white),
                cursorColor: const Color(0xFF075E54),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: const EdgeInsets.only(bottom: 13.0, left: 10),
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
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: "Ac Holder Name",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 35.h,
              width: 220.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(loginfield))),
              child: TextField(
                controller: account_no,
                // focusNode: focusyear,
                keyboardType: TextInputType.name,
                textAlignVertical: TextAlignVertical.bottom,
                style: const TextStyle(color: Colors.white),
                cursorColor: const Color(0xFF075E54),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: const EdgeInsets.only(bottom: 13.0, left: 10),
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
                  prefixIcon: Icon(
                    Icons.account_balance,
                    color: Colors.white,
                  ),
                  hintText: "Account NO",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 35.h,
              width: 220.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(loginfield))),
              child: TextField(
                controller: Bank_Name,
                // focusNode: focusyear,
                keyboardType: TextInputType.name,
                textAlignVertical: TextAlignVertical.bottom,
                style: const TextStyle(color: Colors.white),
                cursorColor: const Color(0xFF075E54),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: const EdgeInsets.only(bottom: 13.0, left: 10),
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
                  prefixIcon: Icon(
                    Icons.account_balance_outlined,
                    color: Colors.white,
                  ),
                  hintText: "Bank Name",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 35.h,
              width: 220.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(loginfield))),
              child: TextField(
                controller: Branch,
                // focusNode: focusyear,
                keyboardType: TextInputType.name,
                textAlignVertical: TextAlignVertical.bottom,
                style: const TextStyle(color: Colors.white),
                cursorColor: const Color(0xFF075E54),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: const EdgeInsets.only(bottom: 13.0, left: 10),
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
                  prefixIcon: Icon(
                    Icons.account_balance_sharp,
                    color: Colors.white,
                  ),
                  hintText: "Branch Name",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 35.h,
              width: 220.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(loginfield))),
              child: TextField(
                controller: IFSC,
                // focusNode: focusyear,
                keyboardType: TextInputType.name,
                textAlignVertical: TextAlignVertical.bottom,
                style: const TextStyle(color: Colors.white),
                cursorColor: const Color(0xFF075E54),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: const EdgeInsets.only(bottom: 13.0, left: 10),
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
                  prefixIcon: Icon(
                    Icons.pin,
                    color: Colors.white,
                  ),
                  hintText: "IFSC Code",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 2,
                  width: 130.w,
                  color: kBlackColor900,
                ),
                Text(
                  'OR',
                  style:
                      TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14.sp,
                        color: kBlackColor900
                      ),
                ),
                Container(
                  height: 2,
                  width: 130.w,
                  color: kBlackColor900,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 35.h,
              width: 220.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(loginfield))),
              child: TextField(
                controller: UPI,
                // focusNode: focusyear,
                keyboardType: TextInputType.name,
                textAlignVertical: TextAlignVertical.bottom,
                style: const TextStyle(color: Colors.white),
                cursorColor: const Color(0xFF075E54),
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: const EdgeInsets.only(bottom: 13.0, left: 10),
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
                  prefixIcon: Icon(
                    Icons.pin_end,
                    color: Colors.white,
                  ),
                  hintText: "UPI ID",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            _loading == false
                ? Center(
                    child: CustomButton(
                      text: AddAccount,
                      textColor: Colors.white,
                      onTap: () async {
                        Addaccount(account_no.text, IFSC.text, Branch.text,
                            Bank_Name.text, UPI.text, Ac_holder.text);
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
    ));
  }

  Addaccount(String account_no, String IFSC, String Branch, String Bank_Name,
      String UPI, String Ac_holder) async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    setState(() {
      _loading = true;
    });

    final response = await http.post(
      Uri.parse(Apiconst.Addaccount),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "upi": UPI,
        "name": Ac_holder,
        "account_no": account_no,
        "ifsc": IFSC,
        "bank_name": Bank_Name,
        "branch": Branch,
        "user_id": '${userid}',
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
      final prefs2 = await SharedPreferences.getInstance();
      final key1 = 'acId';
      final acId = data['id'].toString();
      prefs2.setString(key1, acId);
      print(acId);
      print('nnnnnnnnnnnnnnnnnnnnnnnn');
      Navigator.pop(context);
      Utils.flushBarsuccessMessage(data['msg'], context, kBlackColor900);
    } else {
      setState(() {
        _loading = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, kBlackColor900);
      print("Error");
    }
  }
}
