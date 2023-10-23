import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class myrecord extends StatefulWidget {
  const myrecord({Key? key}) : super(key: key);

  @override
  State<myrecord> createState() => _myrecordState();
}

class _myrecordState extends State<myrecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
        Row(
          children: [
            
            Card(
              child: Container(
                height: 60.h,
                width: double.infinity.w,
                child: Text('mvfjgnfgd'),
              ),
            )
          ],
        )
      ],
      ),
    );
  }
}
