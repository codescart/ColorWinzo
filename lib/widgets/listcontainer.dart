import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/contant/color_constant.dart';

class listcontainer extends StatefulWidget {
  const listcontainer({Key? key}) : super(key: key);

  @override
  State<listcontainer> createState() => _listcontainerState();
}

class _listcontainerState extends State<listcontainer> {
  final List<belistcontainer> _listdata = [
    belistcontainer('Join Green', kGreyColor700, 10),
    belistcontainer('Join Violet', kGreyColor700, 20),
    belistcontainer('Join Red', kGreyColor700, 30),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(left: 18.0.r, right: 18.r),
      child: Container(
        height: 40.h,
        width: 330.w,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _listdata.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                child: Card(
                  elevation: 5,
                  color: _listdata[index].color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Container(
                      width: 100.w,
                      child: Center(
                          child: Text(
                        _listdata[index].name,
                        style: TextStyle(color: kWhiteColor),
                      ))),
                ),
              );
            }),
      ),
    );
  }
}

class belistcontainer {
  final String name;
  final Color color;
  final int num;
  belistcontainer(this.name, this.color, this.num);
}
