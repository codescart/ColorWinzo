import 'dart:convert';
import 'dart:math';
import 'package:ColorWinzo/home_directory/appbar.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:ColorWinzo/contant/color_constant.dart';
import 'package:ColorWinzo/home_directory/home_grid.dart';
import 'package:ColorWinzo/home_directory/slider.dart';
import 'package:ColorWinzo/widgets/custombutton.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
  late ConfettiController _centerController;
  bool verssionview = false;
  var map;
  Future versioncheck() async {
    final response = await http.post(
      Uri.parse(Apiconst.versioncheck),
    );
    var data = jsonDecode(response.body)['data'];

    if (data['version'] != Apiconst.versioncode) {
      print("ooooooo");
      setState(() {
        verssionview = true;
      });
      // if (data['error'] == '200') {
      //   setState(() {
      //     map = data['data'];
      //   });
      // }
    } else {
      print("kkkkkkkkkkkkkkkkk");
    }
  }

  @override
  void initState() {
    versioncheck();

    super.initState();
    _centerController =
        ConfettiController(duration: const Duration(seconds: 3));
  }
  @override
  void dispose() {
    _centerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () => showAlert(context));
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor: Colors.black,
              title: Text('Are you sure?', style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: kBlackColor900,
              ),),
              content: Text('Do you want to exit from App', style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: kBlackColor900,
              ),),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBarTwo(),
          body: Container(
            height: double.infinity.h,
            width: double.infinity.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(background)),
            ),
            child: Stack(
              children: [
                ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'Version: ' + Apiconst.versioncode,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: kBlackColor900,
                            ),
                          )),
                    ),
                    Center(
                      child: Container(
                        height: 150.r,
                        width: 150.r,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill, image: AssetImage(applogo)),
                        ),
                      ),
                    ),
                    homegrid(),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: ConfettiWidget(
                          confettiController: _centerController,
                          blastDirection: -pi / 2,
                          maxBlastForce: 80,
                          minBlastForce: 1,
                          emissionFrequency: 0,
                          numberOfParticles: 20,
                          shouldLoop: false,
                          gravity: 0.50,
                          blastDirectionality: BlastDirectionality.explosive,
                        ),
                      ),
                    ),
                    slider(),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    verssionview == true?
    showDialog(
        context: context,
        builder: (context) =>
         AlertDialog(
          content: Container(
            height: 100.h,
            child: Column(
              children: [
                Container(
                  width: 80.r,
                  height: 80.r,
                  child: Image(image: AssetImage(applogo)),
                ),
                Text('new version are avilable',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: kBlackColor900,
                    )),
                Text(
                    'Update your app  ' +
                        Apiconst.versioncode +
                        '  to  ' +
                        '1.0.2',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: kBlackColor900,
                    )),
              ],
            ),
          ),
          actions: [
            CustomButton(
              text: 'UPDATE',
              onTap: () {
                 _launchURL();
              },
            ),
          ],
        )
    ):Container();
  }

  _launchURL() async {
    const url = Apiconst.ApkLink;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
