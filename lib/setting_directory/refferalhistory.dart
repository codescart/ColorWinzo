import 'dart:convert';
import 'dart:math';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/setting_directory/LEVEL1.dart';
import 'package:ColorWinzo/setting_directory/LEVEL2.dart';
import 'package:ColorWinzo/setting_directory/LEVEL3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';






class CustomSliverAppbar extends StatefulWidget {
  @override
  _CustomSliverAppbarState createState() => _CustomSliverAppbarState();
}

class _CustomSliverAppbarState extends State<CustomSliverAppbar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,

    );
    teamcommision();
    super.initState();
  }


  var amtlevel3;

  teamcommision() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.post(
      Uri.parse(Apiconst.reftotalcommision+'$userid'),

    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['error'] == '200') {
      setState(() {

        amtlevel3 = data['totalamount'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
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
              actions: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  amtlevel3==null?'0.0':amtlevel3.toString(),
                  style: GoogleFonts.aclonica(
                    textStyle: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),],
              pinned: true,
              floating: true,
              bottom: TabBar(
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.transparent,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.indigo.shade900,),

                  labelPadding:  EdgeInsets.only(
                    bottom: 5,

                  ),
                  controller: _tabController,
                  tabs: [
                    Center(child: Container(
                      height: 37.h,
                        child: Center(child: Text("LEVEL 1")))),
                    Center(child: Container(
                      height: 37.h,
                        child: Center(child: Text("LEVEL 2")))),
                    Center(child: Container(
                      height: 37.h,
                        child: Center(child: Text("LEVEL 3")))),
                  ]),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            levelone(),
            leveltwo(),
            levelthree(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}

// class TabA extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scrollbar(
//       child: ListView.separated(
//         separatorBuilder: (context, child) => Divider(
//           height: 1,
//         ),
//         padding: EdgeInsets.all(0.0),
//         itemCount: 30,
//         itemBuilder: (context, i) {
//           return Container(
//             height: 100,
//             width: double.infinity,
//             color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
//           );
//         },
//       ),
//     );
//   }
// }