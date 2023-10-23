import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/contant/Api_constant.dart';
import 'package:ColorWinzo/contant/assets_constant.dart';
import 'package:http/http.dart'as http;


class slider extends StatefulWidget {
  const slider({Key? key}) : super(key: key);


  @override
  State<slider> createState() => _sliderState();
}

class _sliderState extends State<slider> {
  @override
  void initState() {
    state();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150.h,
        aspectRatio: 16/9,
        viewportFraction: 0.9,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,

        scrollDirection: Axis.horizontal,
      ),
      items: state_data.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                ),
                child: Image.network(Apiconst.imgurl+i["image"])
            );
          },
        );
      }).toList(),
    );
  }
  List state_data = [];

  Future<String> state() async {
    final res = await http.get(
        Uri.parse(Apiconst.Slider)
    );
    final resBody = json.decode(res.body)['data'];
    print("hhhhhhhhhhhhh");
    print(resBody);
    setState(() {
      state_data = resBody;
    });



    return "Sucess";
  }
}
