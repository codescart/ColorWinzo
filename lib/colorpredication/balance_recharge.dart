import 'dart:convert';

import 'package:ColorWinzo/ZTEST2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ColorWinzo/Api_controller/paymentgateway_controller.dart';
import 'package:ColorWinzo/colorpredication/Reachargeqroption.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class balance extends StatefulWidget {
  const balance({Key? key}) : super(key: key);

  @override
  State<balance> createState() => _balanceState();
}

class _balanceState extends State<balance> {
  @override
  void initState() {
    walletview();
    super.initState();
  }

  var wallet;
  walletview() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(
      Uri.parse(Apiconst.walletamount+'userid=$userid'),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['error'] == '200') {
      setState(() {
        wallet = data['data'];
      });
    }
  }

  List<int> dataItems = [100, 500, 1000, 2000, 5000, 10000, 49999];


  String selectpayment = '';
  int selectedCard = 10;
  final amount = TextEditingController();
  var catogery;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Recharge,
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
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                wallet == null
                    ? Avilablebalance
                    : Avilablebalancein + wallet['wallet'].toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Card(
              elevation: 5,
              child: Container(
                height: 40.h,
                width: 330.w,
                color: Colors.white,
                child: TextField(
                  controller: amount,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: kBlackColor900),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Colors.grey,
                      ),
                      hintText: enterrechargeamount,
                      helperStyle:
                          TextStyle(fontSize: 10, color: Colors.grey.shade200),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      )),
                  cursorColor: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 130,
                    childAspectRatio: 3.5 / 1.5,
                    mainAxisSpacing: 5),
                itemCount: dataItems.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCard = dataItems[index] as int;

                        amount.text = selectedCard.toString();
                      });
                    },
                    child: Stack(
                      children: [
                        Card(
                          elevation: 5,
                          color: selectedCard == dataItems[index]
                              ? kRedLightColor
                              : kGreenLightColor,
                          child: Center(
                            child: Text(
                              '₹  ' + dataItems[index].toString(),
                              style: TextStyle(
                                  color: kBlackColor900,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 5,
                            right: 5,
                            child: selectedCard == dataItems[index]
                                ? Container(
                                    height: 12.r,
                                    width: 12.r,
                                    child: const CircleAvatar(
                                      child: Icon(
                                        Icons.check_outlined,
                                        size: 10,
                                      ),
                                    ),
                                  )
                                : Container()),
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(height: 100.h),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                child: Text(
                  'Payment',
                  style: TextStyle(
                      color: kGreyColor800,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          selectedCard==10?Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: FutureBuilder<List<paymentgateway>>(
                future: qwe(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        " payment Gateway not activated",
                        style: TextStyle(
                          color: kBlackColor900,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          rechargeqroption(amount: amount.text,gatewayid:snapshot.data![index])));
                            },
                            child: Container(
                              height: 50.h,
                              width: 150.w,
                              child: Stack(
                                children: [
                                  Card(
                                    elevation: 5,
                                    color: snapshot.data![index].id=='5'
                                        ? kRedLightColor
                                        : kGreenLightColor,
                                    child: Center(
                                      child: Text(
                                        '${snapshot.data![index].name}'
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: kBlackColor900,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ):
          amount.text == ''

              ? Container()
              : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: FutureBuilder<List<paymentgateway>>(
                    future: qwe(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            " payment Gateway not activated",
                            style: TextStyle(
                              color: kBlackColor900,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              rechargeqroption(amount: amount.text,gatewayid:snapshot.data![index])));
                                },
                                child: Container(
                                  height: 50.h,
                                  width: 150.w,
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        color: snapshot.data![index].id=='5'
                                            ? kRedLightColor
                                            : kGreenLightColor,
                                        child: Center(
                                          child: Text(
                                            '${snapshot.data![index].name}'
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: kBlackColor900,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),

              ),
        ]),
      ),
    );
  }
  Future<List<paymentgateway>> qwe() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    final response = await http.get(Uri.parse(Apiconst.paymentgateway));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      print(response);
      print('ttttttttttttttttt');
      return jsonData.map((item) => paymentgateway.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
