import 'dart:convert';
import 'package:ColorWinzo/login_directory/login_page.dart';
import 'package:ColorWinzo/setting_directory/aboutus.dart';
import 'package:ColorWinzo/setting_directory/accountdetails.dart';
import 'package:ColorWinzo/setting_directory/changePin_page.dart';
import 'package:ColorWinzo/setting_directory/history.dart';
import 'package:ColorWinzo/setting_directory/privecypolicy.dart';
import 'package:ColorWinzo/setting_directory/profile.dart';
import 'package:ColorWinzo/setting_directory/referandearn.dart';
import 'package:ColorWinzo/setting_directory/term&condition.dart';
import 'package:ColorWinzo/setting_directory/withdrawlAmount.dart';
import 'package:ColorWinzo/widgets/launcher.dart';
import 'package:ColorWinzo/widgets/launcherapi.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ColorWinzo/ZTEST2.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colorpredication/balance_recharge.dart';
import '../contant/Api_constant.dart';

class Setting_page extends StatefulWidget {
  const Setting_page({Key? key}) : super(key: key);

  @override
  State<Setting_page> createState() => _Setting_pageState();
}

class _Setting_pageState extends State<Setting_page> {
  ScrollController _scrollController = ScrollController();
  bool _showImage = true;
  bool _showTitle = true;

  @override
  void initState() {
    super.initState();
    fetchlauncherdata();
    viewprofile();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    setState(() {
      if (_scrollController.position.pixels > 100) {
        _showImage = false;
        _showTitle = false;
      } else {
        _showImage = true;
        _showTitle = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(telegram);
    print('rrrrrrrrrrrrrrrrrrr');

    return SafeArea(
      child: Scaffold(
        body: map == null
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : RefreshIndicator(
          displacement: 250,
          // backgroundColor: Colors.yellow,
          color: Colors.red,
          strokeWidth: 3,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 1500));
            setState(() {
              viewprofile();
            });
          },
              child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
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
                      toolbarHeight: 50,
                      backgroundColor: appbvar,
                      elevation: 0,
                      // stretch: false,
                      pinned: true,
                      collapsedHeight: 50,
                      expandedHeight: 200.0,
                      floating: false,
                      flexibleSpace: FlexibleSpaceBar(
                          title: _showTitle
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Center(
                                            child: map['photo'] == null
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage:
                                                        AssetImage(avtar),
                                                    radius: 40,
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        radius: 65,
                                                        backgroundImage:
                                                            AssetImage(
                                                                profilebg)),
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage: NetworkImage(
                                                        Apiconst.imgurl +
                                                            map['photo']),
                                                    radius: 40,
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        radius: 75,
                                                        backgroundImage:
                                                            AssetImage(
                                                                profilebg)),
                                                  )),
                                        Column(
                                          children: [
                                            Text(
                                              map['full_name'] == null
                                                  ? name
                                                  : map['full_name'],
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              map['mobile'] == null
                                                  ? number
                                                  : map['mobile'],
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Text(
                                  SETTING,
                                  style: GoogleFonts.aclonica(
                                    textStyle: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                          background: _showImage
                              ? Image.asset(
                                  appbarbg, // Replace this with your own image
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  appbarbg, // Replace this with your own image
                                  fit: BoxFit.cover,
                                )),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Card(
                              elevation: 3,
                              child: Container(
                                height: 150.h,
                                width: double.infinity,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 45,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("My Balance",
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: kBlackColor900)),
                                            Text(
                                                map['wallet'] == null
                                                    ? balence
                                                    : "₹" + map['wallet'].toString(),
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: kBlackColor900)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.4,
                                      color: kGreyColor600,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            balance()));
                                              },
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Color(0xff8bc24a),
                                                child: Image.asset(
                                                  deposit,
                                                  scale: 1,
                                                ),
                                              ),
                                            ),
                                            Text(
                                                depo['deposit'] == null
                                                    ? money
                                                    : depo['deposit'].toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kBlackColor900)),
                                            Text(deposits,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kBlackColor900))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            balancewithdrawl()));
                                              },
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Color(0xfffb8b6b),
                                                child: Image.asset(
                                                  withdrawl,
                                                  scale: 1,
                                                ),
                                              ),
                                            ),
                                            Text(
                                                wdrl['withdrawal'] == null
                                                    ? money
                                                    : "₹" + wdrl['withdrawal'].toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kBlackColor900)),
                                            Text(withdrawlcash,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kBlackColor900))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Color(0xff3fa7f9),
                                                child: Image.asset(
                                                  bonus,
                                                  scale: 1,
                                                ),
                                              ),
                                            ),
                                            Text(
                                                map['bonus'] == null
                                                    ? money
                                                    : "₹" + map['bonus'].toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kBlackColor900)),
                                            Text("Bonus Cash",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kBlackColor900))
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                        childCount:
                            1, // Replace this with the number of items you want to display
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Profile_page(profile: map)));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80),
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                              sprofile,
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      Profile,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColor900),
                                    ),
                                  ),
// title: name[index]
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Account_details()));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80),
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                              addaccount,
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      AddAc,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColor900),
                                    ),
                                  ),
// title: name[index]
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangePin()));
                              },
                              child: Column(
                                children: [
                                  Container(
//color:categories[index].end,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80),
//set border radius more than 50% of height and width to make circle
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                              changepin,
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      changePin,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColor900),
                                    ),
                                  ),
// title: name[index]
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => History()));
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
//color:categories[index].end,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80),
//set border radius more than 50% of height and width to make circle
                                          ),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundImage: AssetImage(
                                                history,
                                              ),
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        t_history,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: kBlackColor900),
                                      ),
                                    ),
// title: name[index]
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            privecy_policies()));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80),
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                              privacy,
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      privecy,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColor900),
                                    ),
                                  ),
// title: name[index]
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => about_US()));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80),
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                              aboutus,
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      about,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColor900),
                                    ),
                                  ),
// title: name[index]
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => termcondition()));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80),
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                              tandc,
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      tc,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColor900),
                                    ),
                                  ),
// title: name[index]
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Launcher.openteligram() ;
                              },
                              child: Column(
                                children: [
                                  Container(
//color:categories[index].end,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80),
//set border radius more than 50% of height and width to make circle
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                              support,
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Support',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColor900),
                                    ),
                                  ),
// title: name[index]
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Refer_Earn(onrefer: map)));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80),
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                              refer,
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      R_e,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColor900),
                                    ),
                                  ),
// title: name[index]
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
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
                                        height: 120.r,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 80.r,
                                              width: 80.r,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                        logout,
                                                      ))),
                                            ),
                                            Text(
                                              'Are you Sure?',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900,
                                                  color: kBlackColor900),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      actions: [
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
                                                primary: Colors.redAccent,
                                                elevation: 10,
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold)),
                                            child: Text('Cancel')),
                                        ElevatedButton(
                                            onPressed: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.remove('userId');
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (BuildContext ctx) =>
                                                              login_page()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10.0),
                                                ),
                                                primary: Colors.green,
                                                elevation: 10,
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold)),
                                            child: Text(
                                              'Logout',
                                              style: TextStyle(
                                                  color: kBlackColor900),
                                            )),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
//color:categories[index].end,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80),
//set border radius more than 50% of height and width to make circle
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                              logout,
                                            ),
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColor900),
                                    ),
                                  ),
// title: name[index]
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
      ),
    );
  }

  var map;
  var depo;
  var wdrl;
  viewprofile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.post(
      Uri.parse(Apiconst.profile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": '${userid}',
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['error'] == '200') {
      setState(() {
        map = data['userdata'];
        depo = data['deposit'];
        wdrl = data['withdrawal'];
      });
    }
  }
}
