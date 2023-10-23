import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/setting_directory/refferalhistory.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';

class Refer_Earn extends StatefulWidget {
  final onrefer;
  const Refer_Earn({Key? key, this.onrefer}) : super(key: key);
  @override
  State<Refer_Earn> createState() => _Refer_EarnState();
}
class _Refer_EarnState extends State<Refer_Earn> {
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
          REFER,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 300.r,
              width: 300.r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  image: DecorationImage(
                    image: AssetImage(refer_earn),
                  )
                  // ,color: primaryColor
                  ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              shareandearn,
              style: TextStyle(
                  color: kBlackColor900,
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 15, 0),
              child: Text(Referviewtext,
                  style: TextStyle(color: kGreyColor900, fontSize: 12.sp)),
            ),
            SizedBox(
              height: 20.h,
            ),
            DottedBorder(
              color: textfield,
              strokeWidth: 2.r,
              radius: Radius.circular(12.r),
              dashPattern: [
                5,
                5,
              ],
              child: Container(
                alignment: Alignment.center,
                height: 40.h,
                width: 200.w,
                color: kGreyColor800,
                child: Text(
                  widget.onrefer["ownref"] == null
                      ? ""
                      : widget.onrefer["ownref"] == ""
                          ? ""
                          : widget.onrefer["ownref"],
                  style: TextStyle(
                    color: custonbtn,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Container(
                height: 35.h,
                width: 170.w,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.w, color: textfield),
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                child: InkWell(
                  onTap: ()async {
                    share();
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 20.r,
                          backgroundColor: textfield,
                          child: Icon(
                            Icons.share,
                            color: kWhiteColor,
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text("Share the code",
                          style: TextStyle(
                            color: kBlackColor900,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            CustomButton(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomSliverAppbar()));},
                text: 'Refferal History')
          ],
        ),
      ),
    ));
  }

  String referalCode = 'initialData';
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Referral Code : ' + widget.onrefer["ownref"],
        text: 'Join Now & Get Exiting Prizes. here is my Referral Code : ' +
            widget.onrefer["ownref"],
        linkUrl: Apiconst.WebsiteLink,
        chooserTitle: 'Referrel Code : ' + widget.onrefer["ownref"]);
  }
}
