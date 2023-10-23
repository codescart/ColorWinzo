import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:ColorWinzo/widgets/flushbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile_page extends StatefulWidget {
  final profile;
  Profile_page({required this.profile});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  TextEditingController updatename = TextEditingController();
  TextEditingController updatephone = TextEditingController();
  TextEditingController updateyear = TextEditingController();
  bool _loading = false;

  FocusNode focusNode = FocusNode();
  FocusNode focusnumber = FocusNode();
  FocusNode focusyear = FocusNode();

  @override
  void initState() {
    profileview();
    super.initState();
  }

  profileview() {
    updatename.text = widget.profile['full_name'].toString();
    updatephone.text = widget.profile['mobile'].toString();
    updateyear.text = widget.profile['age'].toString();
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
          profile,
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
          padding: EdgeInsets.all(25.r),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 50.h,
            ),
            InkWell(
              onTap:(){_settingModalBottomSheet(context);},
              child: Center(
                child: Stack(
                  children: [
                    file != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(file!),
                            radius: 80.r,
                          )
                        : widget.profile['photo'] == null
                            ? CircleAvatar(
                                radius: 80.r,
                                backgroundImage: AssetImage(avtar),
                              )
                            : CircleAvatar(
                                backgroundColor: kWhiteColor,
                                backgroundImage: NetworkImage(
                                  Apiconst.imgurl +
                                      widget.profile['photo'].toString(),
                                ),
                                radius: 80.r,
                              ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          radius: 25,
                          child: Icon(Icons.camera_alt_outlined),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              height: 35.h,
              width: 220.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(loginfield))),
              // padding:  EdgeInsets.only(left: 36.0.r, right: 36.0),
              child: Center(
                child: TextField(
                  controller: updatename,
                  focusNode: focusNode,
                  keyboardType: TextInputType.name,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: const Color(0xFF075E54),
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding:
                        const EdgeInsets.only(bottom: 13.0, left: 10),
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
                      color: kWhiteColor,
                    ),
                    hintText: username,
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 35.h,
              width: 220.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(loginfield))),
              // padding:  EdgeInsets.only(left: 36.0.r, right: 36.0),
              child: Center(
                child: TextField(
                  controller: updatephone,
                  focusNode: focusnumber,
                  keyboardType: TextInputType.name,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: const Color(0xFF075E54),
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding:
                        const EdgeInsets.only(bottom: 13.0, left: 10),
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
                      Icons.phone_android,
                      color: kWhiteColor,
                    ),
                    hintText: Mobilenumber,
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 35.h,
              width: 220.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(loginfield))),
              // padding:  EdgeInsets.only(left: 36.0.r, right: 36.0),
              child: Center(
                child: TextField(
                  controller: updateyear,
                  focusNode: focusyear,
                  keyboardType: TextInputType.name,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: const Color(0xFF075E54),
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding:
                        const EdgeInsets.only(bottom: 13.0, left: 10),
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
                      color: kWhiteColor,
                    ),
                    hintText: age,
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15,
                    ),
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
                      text: Next,
                      textColor: Colors.white,
                      onTap: () async {

                        Updateprofile(updatename.text,updatephone.text,updateyear.text);
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

  var mydata='0';
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
  void _camera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera,
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

  Updateprofile(String updatename,
      String updatephone,
      String updateyear) async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    setState(() {
      _loading = true;
    });

    final response = await http.post(
      Uri.parse(Apiconst.updateprofile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "name":updatename,
        "mobile":updatephone,
        "age":updateyear,
        "id":"${userid}",
        "image":'${mydata}'
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
  void _settingModalBottomSheet(context){
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (BuildContext bc){
          return Container(
            height: heights / 3,
            // color: Colors.green,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))),
                ),
                SizedBox( height: heights / 13,),
                Padding(
                  padding:
                  EdgeInsets.fromLTRB(widths / 12, 0, widths / 12, heights / 60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: _camera,
                        child: Container(
                          height: heights/20,
                          width: widths / 2.7,
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                              border: Border.all(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                                'Camera',
                                style: TextStyle(color: Colors.red),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: _choose,
                        child: Container(
                          height: heights/20,
                          width: widths / 2.7,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                                'Gallery',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
