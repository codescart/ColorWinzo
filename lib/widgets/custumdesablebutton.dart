import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/contant/color_constant.dart';


class Customdesablebutton extends StatefulWidget {
  const Customdesablebutton({
    Key? key,
    required this.onTap,
    required this.text,
    this.btnColor = kGreyColor800,
    this.textColor = kWhiteColor,
    this.border,
  }) : super(key: key);

  final Function() onTap;
  final String text;
  final Color? btnColor;
  final Color? textColor;
  final BoxBorder? border;

  @override
  State<Customdesablebutton> createState() => _CustomdesablebuttonState();
}

class _CustomdesablebuttonState extends State<Customdesablebutton> {

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Ink(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25.sp,
            ),
          ),
          child: Container(
            width: 250.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: widget.btnColor,
              borderRadius: BorderRadius.circular(
                25.sp,
              ),
              border: widget.border,
            ),
            child: Center(
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: widget.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  letterSpacing: 1.25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



}
