import 'dart:convert';
import 'dart:io';

import 'package:ColorWinzo/widgets/launcher.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ColorWinzo/colorpredication/Myrecord.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/widgets/copyonclipboard.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:ColorWinzo/widgets/flushbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class rechargeqroption extends StatefulWidget {
 final amount;
 final gatewayid;
 rechargeqroption( {required this.amount, required this.gatewayid,});

  @override
  State<rechargeqroption> createState() => _rechargeqroptionState();
}
bool _loading= false;
class _rechargeqroptionState extends State<rechargeqroption> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    Accountdetail();
    super.initState();
  }
  var acdetail;
  var upi='abc@ybl';
  var payeename='Payee Name';
  var amount='1';
  Accountdetail() async {

    final response = await http.get(
      Uri.parse(Apiconst.UPIACDETAIL),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['error'] == '200') {
      setState(() {
        amount=widget.amount;
        acdetail = data['data'];
         upi=acdetail['upi_id'];
         payeename=acdetail['payeename'];
      });
    }
  }
  final utr = TextEditingController();
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
              Recharge,
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
            child: acdetail==null?Center(child: CircularProgressIndicator()):
            Form(
              key: _formkey,
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(12.r),
                children: [
                  DottedBorder(
                    color: textfield,
                    strokeWidth: 2.r,
                    radius: Radius.circular(30.r),
                    dashPattern: [
                      5,
                      5,
                    ],
                    child: Row(
                      children: [
                        Container(alignment: Alignment.center,
                          height: 40.h,
                          width: 270.w,

                          color: kGreyColor600,
                          child: Text(upi,
                            style: TextStyle(color:custonbtn,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500, ),
                          ),

                        ),
                        IconButton(onPressed: ()async{
                          copyToClipboard(upi, context);
                          // final String groupLink = "upi://pay"; // Replace with your Telegram group link
                          // // upi://pay?pa=bharatpe09915324023@yesbankltd&pn=Hope Gaming PRIVATE LTD&tid=XNoqDeO&am=1.00&cu=INR
                          // if (await canLaunch(groupLink)) {
                          // await launch(groupLink);
                          // } else {
                          // throw "Could not launch $groupLink";
                          // }
                           },
                            icon: Icon(Icons.copy_all))
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Center(
                    child: Text(acdetail['payeename'].toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 22.sp),),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.only(left:43.h,right:43.h),
                    child: Container(
                      height: 250.h,
                      width: 200.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(Apiconst.imgurl+acdetail['image'].toString(),)
                        ),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: kGreyColor700,width: 2)

                      ),

                    ),
                  ),

                  SizedBox(height: 20.h,),
                  Center(
                    child: Text('₹ '+widget.amount,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 22.sp),),
                  ),
                  SizedBox(height: 20.h,),
                  widget.gatewayid.id=='5'? Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Card(
                      elevation: 5,
                      child: Container(

                        width: 330.w,
                        color: Colors.white,
                        child: TextFormField(
                          maxLength: 12,
                          validator: validateMobile,
                          controller: utr,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: kBlackColor900),

                          decoration: InputDecoration(
                              counter: Offstage(),
                              prefixIcon: Icon(
                                Icons.pin,
                                color: Colors.grey,
                              ),
                              hintText: 'Enter UTR',
                              helperStyle:
                              TextStyle(fontSize: 10, color: Colors.grey.shade200),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                          cursorColor: Colors.grey,
                        ),
                      ),
                    ),
                  ):
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                    // height:MediaQuery.of(context).size.height/6,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        color: Color(0xffdbe9f2),
                        border: Border.all(width: 2, color: Colors.white)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.camera_enhance_rounded,
                          color: Colors.blue,
                          size: 30,
                        ),
                        file != null
                            ? SizedBox(
                          height: 6,
                        )
                            : SizedBox(),

                        file != null
                            ? SizedBox(
                          height: 6,
                        )
                            : SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            file != null
                                ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 18,
                            )
                                : Text(""),
                            // Text(file.toString()),
                            file != null
                                ? Text(
                              "  Uploaded Successfully",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600),
                            )
                                : Text("")
                          ],
                        ),
                        file != null
                            ? SizedBox(
                          height: 6,
                        )
                            : SizedBox(),
                        InkWell(
                          onTap: () {
                            _choose();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(8),
                            child: file == null
                                ? Text(
                              "UPLOAD",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12),
                            )
                                : Text("UPLOAD AGAIN",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  _loading==false?
                  Center(
                    child: CustomButton(

                      text: Submitreq,
                      textColor: Colors.white,
                      onTap: ()async {
                        if (_formkey.currentState!.validate()) {

                          Submitrequest(utr.text,context,);
                        }



                      },
                    ),
                  ) :
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
                  ),

                ],
              ),
            )
            ,
          ),
        ));
  }

  var mydata;
  File? file;
  final picker = ImagePicker();
  void _choose() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        final bytes = File(pickedFile.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        mydata = img64;
        print('Abhinav');
        print(img64);
        print('Thi');
      } else {
        print('No image selected.');
      }
    });
  }

  Submitrequest(String utr,BuildContext context) async {
     final prefs = await SharedPreferences.getInstance();
     final userid = prefs.getString("userId");
    setState(() {
      _loading = true;
    });
if(mydata==null){
  final res= await http.get(
    Uri.parse(Apiconst.BHARATPAYURL+'utrno=$utr')
  );
 final resdata= jsonDecode(res.body);
  print('harshpaypre');
  print(resdata);
 if(resdata['status']=="success"){
   final payamount =resdata['data']['amount'];
 final  payutr=resdata['data']['utr'];

   final response = await http.post(
     Uri.parse(Apiconst.paymentsubmit),
     headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
     },
     body: jsonEncode(<String, String>{
       "user_id": '$userid',
       "amount": payamount,
       "utr": payutr,

     }),
   );
   final data= jsonDecode(response.body);
   print('harshpay');
   print(data);
   if (data["success"] == "200") {
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
 }else {
   setState(() {
     _loading = false;
   });
   Utils.flushBarErrorMessage('Incorrect utr', context, kBlackColor900);
 }

}else {
  final response = await http.post(
    Uri.parse(Apiconst.paymentsubmit),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "user_id": '$userid',
      "amount": amount,
      "screenshort": mydata,

    }),
  );
  final data= jsonDecode(response.body);

  if (data["success"] == "200") {
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
            height: 230.r,
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
                  'Your Payment Will be updated within 2 Minutes',
                  style: TextStyle(
                      fontSize: 15.sp,
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


  String? validateMobile(String? value) {
// Indian Mobile number are of 10 digit only
    if (value!.length != 12)
      return 'U.T.R must be 12 Digit';
    else
      return null;
  }
}
