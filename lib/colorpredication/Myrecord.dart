import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/colorpredication/home.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';

class MY_Record extends StatefulWidget {
  List<BetRecord>? betlist;
  MY_Record(this.betlist);

  @override
  State<MY_Record> createState() => _MY_RecordState();
}

class _MY_RecordState extends State<MY_Record> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
          'My Record',
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
        Padding(
          padding: EdgeInsets.only(right: 35.sp, left: 25.sp),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Period",
              style: TextStyle(
                  color: Colors.grey.shade500, fontWeight: FontWeight.w500),
            ),
            Text(
              "Result",
              style: TextStyle(
                  color: Colors.grey.shade500, fontWeight: FontWeight.w500),
            ),
            Text("Amount",
                style: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
          ]),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.betlist!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                        right: 10.w,
                      ),
                      child: ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.betlist![index].gamesno,
                              style: TextStyle(
                                  color: kBlackColor900,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 10.sp),
                            ),
                            Text(
                              widget.betlist![index].status == '0'
                                  ? "Wait.."
                                  : widget.betlist![index].status == '1'
                                      ? "Win"
                                      : 'Loss',
                              style: TextStyle(
                                  color: widget.betlist![index].status == '0'
                                      ? Colors.orange
                                      : widget.betlist![index].status == '1'
                                          ? Colors.green
                                          : Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.sp),
                            ),
                            Text(
                              widget.betlist![index].totalamount,
                              style: TextStyle(
                                  color: widget.betlist![index].status == '0'
                                      ? Colors.orange
                                      : widget.betlist![index].status == '1'
                                          ? Colors.green
                                          : Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.sp),
                            ),
                          ],
                        ),
                        maintainState: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Amount :",
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                                Text(widget.betlist![index].totalamount,
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Commission :",
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                                Text(widget.betlist![index].commission,
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Amount :",
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                                Text(widget.betlist![index].amount,
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Number :",
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                                Text(widget.betlist![index].number=='10'?'Green':
                                    widget.betlist![index].number=='20'?'Voilet':
                                    widget.betlist![index].number=='30'?'Red':
                                    widget.betlist![index].number,
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Color : ",
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                                Container(
                                  width: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 8,
                                        backgroundColor:
                                        widget.betlist![index].number=='10'?Color(0xff4caf50):
                                        widget.betlist![index].number=='20'?Color(0xff9c27b0):
                                        widget.betlist![index].number=='30'?Color(0xfff44336):
                                        widget.betlist![index].number=='2'?Color(0xfff44336):
                                        widget.betlist![index].number=='4'?Color(0xfff44336):
                                        widget.betlist![index].number=='6'?Color(0xfff44336):
                                        widget.betlist![index].number=='8'?Color(0xfff44336)
                                            //:
                                            // int.parse(widget
                                            //         .betlist![index].number)
                                            //     .isOdd
                                            // ? Color(0xff4caf50)
                                            : Color(0xff4caf50),
                                      ),
                                      widget.betlist![index].number == '5' ||
                                              widget.betlist![index].number ==
                                                  '0'
                                          ? CircleAvatar(
                                              radius: 8,
                                              backgroundColor:
                                                  Color(0xff9c27b0),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Status :",
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                                Text(
                                  widget.betlist![index].status == '0'
                                      ? "Wait.."
                                      : widget.betlist![index].status == '1'
                                          ? "Win"
                                          : 'Loss',
                                  style: TextStyle(
                                      color: widget.betlist![index].status ==
                                              '0'
                                          ? Colors.orange
                                          : widget.betlist![index].status == '1'
                                              ? Colors.green
                                              : Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Win Amount :",
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                                Text(
                                  widget.betlist![index].win,
                                  style: TextStyle(
                                      color: kBlackColor900,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Date & Time : ",
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                                Text(widget.betlist![index].datetime,
                                    style: TextStyle(
                                        color: kBlackColor900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
