import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/Api_controller/Partlyrecord_controller.dart';
import 'package:ColorWinzo/colorpredication/home.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';


class becone extends StatefulWidget {
  List<pertrecord>? _listdata;
  becone(this._listdata);

  @override
  State<becone> createState() => _beconeState();
}

class _beconeState extends State<becone> {
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.h,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            trophy,
            scale: 1.5,
            color: kGreyColor900,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          'Parity Record',
          style: TextStyle(
              color: kBlackColor900,
              fontSize: 14.sp,
              fontWeight: FontWeight.w900),
        ),
        SizedBox(
          height: 5.h,
        ),
        Divider(
          color: Colors.teal,
          thickness: 2,
        ),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Parity",
              style: TextStyle(
                  color: Colors.grey.shade500, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text("Price",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text("Number",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Text("Result",
                style: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
          ]),
        ),
        SizedBox(
          height: 10.h,
        ),
        Divider(),

        widget._listdata!.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget._listdata!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                widget._listdata![index].period,
                                // '${snapshot.data![index].gamesno}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              child: Text(widget._listdata![index].prise,
                                  //'${snapshot.data![index].price}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              width: 50,
                              child: Center(
                                child: Text(
                                    widget._listdata![index].number.toString(),

                                    //'${snapshot.data![index].number}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      // color: Colors.black,
                                      fontSize: 15.sp,
                                      color: int.parse(widget
                                                  ._listdata![index].number)
                                              .isOdd
                                          ? Color(0xff4caf50)
                                          : Color(0xfff44336),
                                    )),
                              ),
                            ),
                            Container(
                              width: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 8,
                                    backgroundColor: int.parse(
                                                widget._listdata![index].number)
                                            .isOdd
                                        ? Color(0xff4caf50)
                                        : Color(0xfff44336),
                                  ),
                                  widget._listdata![index].number == '5' ||
                                          widget._listdata![index].number == '0'
                                      ? CircleAvatar(
                                          radius: 8,
                                          backgroundColor: Color(0xff9c27b0),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  );
                })
            : Container(
                child: Column(
                  children: [
                    Text(
                      'waiting....',
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500),
                    ),
                    Center(child: LinearProgressIndicator())
                  ],
                ),
              ),
      ],
    );
  }
}
