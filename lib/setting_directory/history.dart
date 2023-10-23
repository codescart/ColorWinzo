import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/setting_directory/depositeHistory.dart';
import 'package:ColorWinzo/setting_directory/withdrawl_history.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    TabController _tabContrller = TabController(length: 2, vsync: this);
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
          Trans_history,
          style: GoogleFonts.aclonica(
            textStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(appbarbg), opacity: 0.8),
            ),
            child: TabBar(
              controller: _tabContrller,
              labelStyle: GoogleFonts.aclonica(
                textStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5), // Creates border
                color: Colors.grey,
              ),
              unselectedLabelColor: kGreyColor600,
              tabs: [
                Tab(
                  text: (Deposit),
                ),

                Tab(
                  text: (Withdrawl),
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.80,
            child: TabBarView(controller: _tabContrller, children: [
              Deposit_History(),
              widthdrawl_History(),
            ]),
          )
        ],
      ),
    ));
  }
}
