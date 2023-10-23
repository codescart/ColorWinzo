import 'dart:convert';

import 'package:ColorWinzo/widgets/launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ColorWinzo/colorpredication/Reachargeqroption.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/setting_directory/accountdetails.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:ColorWinzo/widgets/custumdesablebutton.dart';
import 'package:ColorWinzo/widgets/flushbar.dart';
import 'package:http/http.dart'as http;
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class balancewithdrawl extends StatefulWidget {
  const balancewithdrawl({Key? key}) : super(key: key);

  @override
  State<balancewithdrawl> createState() => _balancewithdrawlState();
}

class _balancewithdrawlState extends State<balancewithdrawl> {
  @override
  void initState() {
    walletview();
    accountview();
    super.initState();
  }
  bool _loading= false;
  var wallet;

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
  TextEditingController enterpassword = TextEditingController();
  walletview() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(
      Uri.parse(Apiconst.walletamount+'userid=$userid'),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['error'] == '200') {
      setState(() {
        wallet = data['data'];
      });
    }
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
      setState(()  {
        Account = data['userdata'];
      });
    }
  }
  TextEditingController amount = TextEditingController();
  int _selectedItemIndex = 10; // Initialize with a value that won't match any index
  bool _isButtonEnabled = false;
  List<int> dataItems = [100, 500, 1000, 2000, 5000, 10000, 49999];
  void _handleTextChange() {
    setState(() {
      _selectedItemIndex = 10; // Reset selected index
      _isButtonEnabled = amount.text.isNotEmpty;
    });
  }

  void _handleListItemSelected(int index) {
    setState(() {
      _selectedItemIndex = dataItems[index];
      amount.text = dataItems[index].toString(); // Update TextFormField text
      _isButtonEnabled = true;
    });
  }

  void _submitForm() {
    // Implement your form submission logic here
    print('Form submitted with text: ${amount.text}');
  }

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  var catogery;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Withdrawl,
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
            padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 20.w),
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    wallet==null?
                    Avilablebalance:Avilablebalancein+wallet['wallet'].toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
            elevation: 5,
            child: ExpansionTile(
              title: Text('Your Account Details',
                style: TextStyle(
                    color: kBlackColor900,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900),
              ),
              children: [
                Account==null?Column(
                  children: [
                    ListTile(
                        onTap: ()async{
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(
                              builder: (context)=>Account_details()));
                        },
                      leading: Text('Add your Account Detail',
                        style: TextStyle(
                            color: kBlackColor900,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900),
                      ),
                      trailing:Icon(Icons.edit)
                    ),
                  ],
                ):
              Column(
                children: [
                  ListTile(
                    leading: Text('Ac holder Name',
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
                    trailing:Text(Account['name']==null?'':Account['name'].toString(),
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  ListTile(
                    leading: Text('Acount No',
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
                    trailing:Text(Account['account_no']==null?'':Account['account_no'].toString(),
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  ListTile(
                    leading: Text('Bank Name',
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
                    trailing:Text(Account['bank_name']==null?'':Account['bank_name'].toString(),
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  ListTile(
                    leading: Text('Branch Name',
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
                    trailing:Text(Account['branch']==null?'':Account['branch'].toString(),
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  ListTile(
                    leading: Text('IFSC Code',
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
                    trailing:Text(Account['ifsc']==null?'':Account['ifsc'].toString(),
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
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
                  ListTile(
                    leading: Text('Upi Id',
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
                    trailing:Text(Account['upi']==null?'':Account['upi'].toString(),
                      style: TextStyle(
                          color: kBlackColor900,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: kBlackColor900,
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context)=>Account_details()));
                    },
                      leading: Text('Edit your Account Detail',
                        style: TextStyle(
                            color: kBlackColor900,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900),
                      ),
                      trailing:Icon(Icons.edit)
                  ),
                ],
              )

              ],
            ),),
              SizedBox(
                height: 30.h,
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: TextField(
                  controller: amount,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: kBlackColor900),
                  onChanged: (text) {
                    _handleTextChange();
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Colors.grey,
                      ),
                      hintText: enterrechargeamount,
                      helperStyle:
                      TextStyle(fontSize: 10, color: Colors.grey.shade200),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      )),
                  cursorColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 130,
                      childAspectRatio: 3.5 / 1.5,
                      mainAxisSpacing: 5),
                  itemCount: dataItems.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        _handleListItemSelected(index);
                      },
                      child: Stack(
                        children: [
                          Card(
                            elevation: 5,

                            color: _selectedItemIndex == dataItems[index]
                                ? kRedLightColor
                                : kGreenLightColor,
                            child: Center(
                              child: Text(
                                '₹  ' + dataItems[index].toString(),
                                style: TextStyle(
                                    color: kBlackColor900,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 5,
                              right: 5,
                              child: _selectedItemIndex == dataItems[index]
                                  ? Container(
                                height: 12.r,
                                width: 12.r,
                                child: const CircleAvatar(
                                  child: Icon(
                                    Icons.check_outlined,
                                    size: 10,
                                  ),
                                ),
                              )
                                  : Container()),
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: 30.h,
              ),
              Text(
                EnterPASSWORD,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              Center(
                child: Container(
                  height: 40.h,
                  child: Pinput(
                    controller: enterpassword,
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

              SizedBox(height: 50.h),
              _isButtonEnabled?CustomButton(
                  onTap: () {
                wIDTHDRAWLcash(amount.text,enterpassword.text);

              },
                  text: Withdrawlrequest):
              Customdesablebutton(onTap: () {  }, text:Withdrawlrequest,),
              // _loading==false ?
              // CustomButton(onTap:
              // _isButtonEnabled?
              //     () {
              //   wIDTHDRAWLcash(amount.text,enterpassword.text);
              //
              // }:(){},
              //     text: Withdrawlrequest):   Center(
              //   child: Padding(
              //     padding:  EdgeInsets.all(4.0),
              //     child: Container(
              //       height: 30.r,
              //       width: 30.r,
              //       child: CircularProgressIndicator(
              //           color: custonbtn,
              //           strokeWidth: 4,
              //           valueColor:
              //           AlwaysStoppedAnimation<Color>(Colors.white)),
              //     ),
              //   ),
              // )

            ]),
      ),
    );
  }
  wIDTHDRAWLcash(String amount,String enterpassword) async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final prefs2 = await SharedPreferences.getInstance();
    final acId = prefs2.getString("acId");
    print(acId);
    print('llllllllllllllllll');
    setState(() {
      _loading = true;
    });

    final response = await http.post(
      Uri.parse(Apiconst.widthdrawlcash),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "amount":amount,
        "password":enterpassword,
        "account_id":"${acId}",
        "user_id":"${userid}"
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
      SuccessPopup(context);
    } else {
      setState(() {
        _loading = false;
      });
      Utils.flushBarErrorMessage(data['msg'], context, kBlackColor900);
      print("Error");
    }
  }

  SuccessPopup(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          content: Container(
            height: 220.h,
            child: Column(
              children: [
                Container(
                  height: 80.r,
                  width: 80.r,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            sucesspop,
                          ))),
                ),
                Text(
                  'Your withdrawal amout get in your account 10:00 AM to 08:00 PM - with in 1 hour After 08:00 pm - you get money 10:00 AM ',
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w900,
                      color: kBlackColor900),
                ),

              
                Spacer(),

                Text(
                  'If any Payment related support  :',
                  style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w500,
                      color: kBlackColor900),
                ),
                TextButton(
                  onPressed: () {
                    Launcher.openteligram();
                  }, child: Text( 'Telegram Link',
                  style: TextStyle(decoration:TextDecoration.underline ,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w500,
                      color: kBlackColor900),
                ),),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          new BorderRadius.circular(
                              10.0),
                        ),
                        primary: custonbtn,
                        elevation: 10,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold)),
                    child: Text('Go Back')),
              ],
            ),
          ),
        );
      },
    );
  }


}


