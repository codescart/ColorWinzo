import 'dart:async';
import 'dart:convert';
import 'package:ColorWinzo/widgets/walletapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/colorpredication/Myrecord.dart';
import 'package:ColorWinzo/colorpredication/balance_recharge.dart';
import 'package:ColorWinzo/colorpredication/becone_record.dart';
import 'package:ColorWinzo/colorpredication/buttongridview2.dart';
import 'package:ColorWinzo/colorpredication/trend.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/contant/text_constant.dart';
import 'package:ColorWinzo/widgets/gridcontainer.dart';
import 'package:ColorWinzo/widgets/listcontainer.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'buttongridview.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ColorWinzo/colorpredication/Myrecord.dart';

List<BetRecord> _betlist = [];
List<pertrecord> _listdata = [];
dynamic? wallet;
bool popups = false;

class colorpredicationhome extends StatefulWidget {
  const colorpredicationhome({Key? key}) : super(key: key);
  @override
  State<colorpredicationhome> createState() => _colorpredicationhomeState();
}

class _colorpredicationhomeState extends State<colorpredicationhome> {
  final CountdownController _controller =
      new CountdownController(autoStart: true);
  late final Duration timerTastoPremuto;
  @override
  void initState() {
    qwe(0);
    Partelyrecord(0);

    fetchwalletview();
    startTimer();
    periodget();
    _betlist.clear();
    // TODO: implement initState
    super.initState();
  }
  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
  int parity = 0;
  int myrecord = 0;
// var walt;
//   walletview() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userid = prefs.getString("userId");
//     final response = await http.get(
//       Uri.parse(Apiconst.walletamount + 'userid=$userid'),
//     );
//     var data = jsonDecode(response.body);
//     print(data);
//     print("neerajjjjjj");
//     if (data['error'] == '200') {
//       setState(() {
//          walt = data['data'];
//          print(walt);
//          print(walt['wallet']);
//        // wallet = walt['wallet'] == null ? 0 : int.parse(walt['wallet']);
//       });
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: _onWillPop,
          child: RefreshIndicator(
            displacement: 250,
            backgroundColor: Colors.yellow,
            color: Colors.red,
            strokeWidth: 3,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 1500));
              setState(() {
                qwe(0);
                Partelyrecord(0);
                fetchwalletview();
              });
            },
            child: Container(
              height: double.infinity.h,
              width: double.infinity.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage(background)),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: 120.h,
                    width: 380.w,
                    color: custonbtn,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                _onWillPop();
                              },
                              icon: Icon(Icons.arrow_back_ios)),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                walt == null
                                    ? Avilablebalance
                                    : "${Avilablebalancein + walt}",
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 3.0, right: 3),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => balance()));
                                },
                                child: Card(
                                  elevation: 5,
                                  color: klightblue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 40.h,
                                    width: 100.w,
                                    child: Center(
                                      child: Text(
                                        'Recharge',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: kWhiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 3.0, right: 3),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => trendss()));
                                },
                                child: Card(
                                  elevation: 5,
                                  color: kWhiteColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: 40.h,
                                    width: 100.w,
                                    child: Center(
                                      child: Text(
                                        'Rule',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: kBlackColor900),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      Duration(milliseconds: 1500));
                                  setState(() {
                                    qwe(0);
                                    Partelyrecord(0);
                                    fetchwalletview();
                                  });
                                },
                                icon: Icon(
                                  Icons.refresh,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Image.asset(trophy,
                            scale: 1.5, color: Colors.grey.shade600),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          'Period',
                          style:
                              TextStyle(color: kBlackColor800, fontSize: 15.sp),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Text(
                          'Count Down',
                          style: TextStyle(color: kBlackColor800, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 4.w,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              periods.toString(),
                              style: TextStyle(
                                  color: kBlackColor900,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Spacer(),
                          Container(
                              margin:
                                  EdgeInsets.only(top: 5, bottom: 5, right: 15),
                              child: buildTime1()),
                        ],
                      ),
                      hide == false ? button() : listcontainer(),
                      hide == false ? buttongridview() : Gridcontainer(),
                      becone(_listdata),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: parity == 0
                                    ? () {}
                                    : () {
                                        setState(() {
                                          parity = parity - 10;
                                        });
                                        Partelyrecord(parity);
                                      },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: kBlackColor900,
                                )),
                            Center(
                              child: Text(
                                parity.toString(),
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: kBlackColor900,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    parity = parity + 10;
                                  });
                                  Partelyrecord(parity);
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: kBlackColor900,
                                )),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal,
                        thickness: 2,
                      ),
                      MY_Record(_betlist),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: myrecord == 0
                                    ? () {}
                                    : () {
                                        setState(() {
                                          myrecord = myrecord - 10;
                                        });
                                        qwe(myrecord);
                                      },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: kBlackColor900,
                                )),
                            Center(
                              child: Text(
                                myrecord.toString(),
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: kBlackColor900,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  // int amo=0;
                                  setState(() {
                                    myrecord = myrecord + 10;
                                  });
                                  qwe(myrecord);
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: kBlackColor900,
                                )),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal,
                        thickness: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final isRunning = countdownTimer == null ? false : countdownTimer!.isActive;
    if (isRunning) {
      countdownTimer!.cancel();
    }
    Navigator.of(context, rootNavigator: true).pop(context);
    return true;
  }

  Timer? countdownTimer;
  int myDuration = 150;
  Duration myDurations = Duration(minutes: 2, seconds: 30);
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();

    setState(() { myDurations = Duration(minutes: 2, seconds: 30);
    myDuration = 150;
    });

    // setState(() {
    //   myDuration = 150;
    // } );
  }
  // Step 6

  late DateTime _dateTime;
  bool frist = true;
  bool hide = false;

  void setCountDown() {
    hiddenbat();
    final reduceSecondsBy = 1;
    _dateTime = DateTime.now().toUtc();
    if (frist == true) {
      setState(() {
        frist = false;
      });
    final min=  _dateTime.minute.toString();
    final minas=min.split('');
      if (minas.last=='0'&& _dateTime.second >0) {
        final seconds = 150 - _dateTime.second;
        setState(() {
          myDuration = seconds;
        } );
      }else if (minas.last=='0' && _dateTime.second ==0) {
        final seconds = 150;
        setState(() {
          myDuration = seconds;
        } );
      } else if (minas.last=='1') {
        final seconds = 150 -60- _dateTime.second;
        setState(() {
          myDuration = seconds;
        } );
      }else if (minas.last=='2' && _dateTime.second <30) {
        final seconds = 150 -120- _dateTime.second;
        setState(() {
          myDuration = seconds;
        } );
      }else if (minas.last=='2' && _dateTime.second >30) {
        final seconds = 150 - _dateTime.second+30;
        setState(() {
          myDuration = seconds;
        } );
      }else if (minas.last=='3' ) {
        final seconds = 150 - 60-_dateTime.second+30;
        setState(() {
          myDuration = seconds;
        } );
      }else if (minas.last=='4' ) {
        final seconds = 150 - 120-_dateTime.second+30;
        setState(() {
          myDuration = seconds;
        } );
      }else if (minas.last=='5' && _dateTime.second ==0) {
        final seconds = 150;
        setState(() {
          myDuration = seconds;
        } );
      }else if (minas.last=='5' && _dateTime.second >0) {
        final seconds = 150 - _dateTime.second;
        setState(() {
          myDuration = seconds;
        } );
      } else if (minas.last=='6') {
        final seconds = 150 -60- _dateTime.second;
        setState(() {
          myDuration = seconds;
        } );
      }else if (minas.last=='7' && _dateTime.second <30) {
        final seconds = 150 -120- _dateTime.second;
        setState(() {
          myDuration = seconds;
        } );
      }else if (minas.last=='7' && _dateTime.second >30) {
        final seconds = 150 - _dateTime.second+30;
        setState(() {
          myDuration = seconds;
        } );
      }else if (minas.last=='8' ) {
        final seconds = 150 - 60-_dateTime.second+30;
        setState(() {
          myDuration = seconds;
        } );
      }else if (minas.last=='9' ) {
        final seconds = 150 - 120-_dateTime.second+30;
        setState(() {
          myDuration = seconds;
        } );
      }
    } else {
      setState(() {
        myDuration=  myDuration-1;
        // final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (myDuration < 0) {
          // countdownTimer!.cancel();
          periodget();
          qwe(0);
          Partelyrecord(0);
          fetchwalletview();
          startTimer();
          resetTimer();
        } else {
          // myDurations = Duration(seconds: myDuration);
          remaing = formatedTime(timeInSecond:myDuration);

          print(myDuration);
        }
      });
    }
  }
 String remaing='0';
  Color colord = kGreyColor600;
void hiddenbat(){
  if(myDuration==30){
    setState(() {
      colord=Colors.red;
    });
  }else if(myDuration==60){
    setState(() {
      colord=Colors.yellow;
    });
  }else if(myDuration==120){
    setState(() {
      colord=Colors.green;
    });
  }

  if(myDuration<32 ){
      setState(() {
        hide=true;
      });
      if(popups==true&& myDuration==30){
        setState(() {
          popups=false;
        });
        Navigator.pop(context);
      }
      // if(hide==true&& myDuration.inSeconds==60){
      //   setState(() {
      //     hide=false;
      //   });
      //   Navigator.pop(context);
      // }
    }else{
      setState(() {
        hide=false;
      });
    }

}

  Widget buildTime1() {
    // String strDigits(int n) => n.toString().padLeft(2, '0');
 var  hi= remaing.split(':');
    final minutes = hi.first;
    //strDigits(myDuration.inMinutes.remainder(2));
    final seconds = hi.last;
    //strDigits(myDuration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: minutes, header: 'MINUTES'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: 'SECONDS'),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: colord, borderRadius: BorderRadius.circular(10)),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kBlackColor900,
                  fontSize: 15),
            ),
          ),
        ],
      );


  periodget(){

  }

  Partelyrecord(int partlyamo) async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    print(userid);
    print(Apiconst.parityrecord + 'limit=$partlyamo');
    final response = await http.get(Uri.parse(
      Apiconst.parityrecord + 'limit=$partlyamo',
    ));
    if (response.statusCode == 200) {
      _listdata.clear();
      // final jsonData = json.decode(response.body)['data'] as List<dynamic>;
      final jsonData = json.decode(response.body)['data'];
      if (partlyamo == 0) {
        setState(() {
          periods = int.parse(jsonData[0]['gamesno'].toString()) + 1;
        });
      }
      for (var i = 0; i < jsonData.length; i++) {
        var period = jsonData[i]['gamesno'];
        var prise = jsonData[i]['price'];
        var number = jsonData[i]['number'];
        print(period);
        _listdata.add(pertrecord(period, prise, number));

        // setState(() {
        //   _listdata.add(pertrecord(period, prise, number));
        // });
      }

      print(_listdata);
      print('ttttttttttttttttt');
      // return jsonData.map((item) => partlyrecord.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

int periods = 0;

///---------------------------------api------------------
qwe(int myrecordamo) async {
  final prefs = await SharedPreferences.getInstance();
  final userid = prefs.getString("userId");
  print(userid);
  print(Apiconst.myrecord + 'limit=$myrecordamo&userid=$userid');
  final response = await http.get(Uri.parse(
    Apiconst.myrecord + 'limit=$myrecordamo&userid=$userid',
  ));
  if (response.statusCode == 200) {
    _betlist.clear();
    // final jsonData = json.decode(response.body)['data'] as List<dynamic>;
    final jsonData = json.decode(response.body)['data'];

    for (var i = 0; i < jsonData.length; i++) {
      var amount = jsonData[i]['amount'].toString();
      var totalamount = jsonData[i]['totalamount'].toString();
      var color = jsonData[i]['color'].toString();
      var number = jsonData[i]['number'].toString();
      var gamesno = jsonData[i]['gamesno'].toString();
      var commission = jsonData[i]['commission'].toString();
      var status = jsonData[i]['status'].toString();
      var win = jsonData[i]['win'].toString();
      var datetime = jsonData[i]['datetime'].toString();

      _betlist.add(BetRecord(amount, totalamount, color, number, gamesno,
          commission, status, win, datetime));

      // setState(() {
      //   _betlist.add(BetRecord(amount, totalamount, color,number, gamesno, commission, status, win, datetime));
      // });
    }
    print('ttttttttttttttttt');
  } else {
    throw Exception('Failed to load data');
  }
}

class BetRecord {
  final String amount;
  final String totalamount;
  final String color;
  final String number;
  final String gamesno;
  final String commission;
  final String status;
  final String win;
  final String datetime;
  // final Color color;
  BetRecord(
    this.amount,
    this.totalamount,
    this.color,
    this.number,
    this.gamesno,
    this.commission,
    this.status,
    this.win,
    this.datetime,
  );
}

class pertrecord {
  final String period;
  final String prise;
  final String number;
  // final Color color;
  pertrecord(this.period, this.prise, this.number);
}
