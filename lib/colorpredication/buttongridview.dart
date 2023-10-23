

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/colorpredication/home.dart';
import 'package:ColorWinzo/colorpredication/popup.dart';
import 'package:ColorWinzo/contant/color_constant.dart';


class button extends StatefulWidget {
  const button({Key? key}) : super(key: key);

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {
  final List<BeRecord> _listdata = [
    BeRecord('Join Green', Color(0xff4caf50),10),
    BeRecord('Join Violet', Color(0xff9c27b0),20),
    BeRecord('Join Red', Color(0xfff44336),30),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.only(left: 18.0.r,right: 18.r),
      child: Container(

        height: 40.h,
        width: 330.w,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //     crossAxisSpacing: 5,
            //     maxCrossAxisExtent: 160,
            //     childAspectRatio: 3 / 1,
            //     mainAxisSpacing: 3),
            itemCount: _listdata.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: (){
                  setState(() {
                    popups=true;
                  });
                  showDialog(
                    barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context)=>popup(
                        color: _listdata[index].color,
                        name:  _listdata[index].name,
                        num:  _listdata[index].num,
                      )
                  );
                },
                child: Card(
                  elevation: 5,
                  color: _listdata[index].color,
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                  child: Container(

                      width: 100.w,
                      child: Center(child: Text(_listdata[index].name,style: TextStyle(color: kWhiteColor),))),
                ),
              );
            }),
      ),
    );
  }
}

class BeRecord {
  final String name;
  final Color color;
  final int num;
  BeRecord(this.name, this.color, this.num);
}
