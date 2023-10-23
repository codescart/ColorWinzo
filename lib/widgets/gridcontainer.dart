import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/contant/color_constant.dart';

class Gridcontainer extends StatefulWidget {
  const Gridcontainer({Key? key}) : super(key: key);

  @override
  State<Gridcontainer> createState() => _GridcontainerState();
}

class _GridcontainerState extends State<Gridcontainer> {
  final List<conto> _listdata = [
    conto('0', kGreyColor700,kGreyColor700),
    conto('1', kGreyColor700,kGreyColor700),
    conto('2', kGreyColor700,kGreyColor700),
    conto('3', kGreyColor700,kGreyColor700),
    conto('4', kGreyColor700,kGreyColor700),
    conto('5', kGreyColor700,kGreyColor700),
    conto('6', kGreyColor700,kGreyColor700),
    conto('7', kGreyColor700,kGreyColor700),
    conto('8', kGreyColor700,kGreyColor700),
    conto('9', kGreyColor700,kGreyColor700),
  ];
  @override
  Widget build(BuildContext context) {
    return
      GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio:1.5,
              mainAxisSpacing: 5),
          itemCount: _listdata.length,
          padding: EdgeInsets.only(left: 15,right: 15, top: 20),
          itemBuilder: (BuildContext ctx, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 3.0,right: 3),
              child: InkWell(
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 3,
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    height: 40.h,
                    width: 50.w,

                    alignment: Alignment.center,
                    decoration: BoxDecoration(

                      gradient: LinearGradient(
                        stops: [0.5, 0.5],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _listdata[index].color,
                          _listdata[index].color1,// top Right part
                        ],
                      ),
                    ),
                    child: Text(_listdata[index].number,
                      style: TextStyle(fontSize: 14,
                          color: Colors.white),),
                  ),
                ),
              ),
            );
          }

      );
  }
}
class conto {
  final String number;
  final Color color;
  final Color color1;
  conto(this.number, this.color, this.color1);
}