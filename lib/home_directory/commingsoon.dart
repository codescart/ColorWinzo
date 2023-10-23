import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:google_fonts/google_fonts.dart';


class Comming_Soon extends StatefulWidget {
  final  skip;
   Comming_Soon( {required  this.skip,});

  @override
  State<Comming_Soon> createState() => _Comming_SoonState();
}

class _Comming_SoonState extends State<Comming_Soon> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
            widget.skip,
            style: GoogleFonts.aclonica(
              textStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      body:Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image:AssetImage(background),),
        ),
        child: Center(
          child: Container(
            height: 250.h,
            width: 250.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image:AssetImage(CommingSoon),),
            ),
          ),
        ),
      )
    ));
  }
}
