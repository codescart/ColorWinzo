

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/colorpredication/balance_recharge.dart';

class recharge extends StatefulWidget {
  const recharge({Key? key}) : super(key: key);

  @override
  State<recharge> createState() => _rechargeState();
}

class _rechargeState extends State<recharge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>balance()));},
            icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text('Recharge Record',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Row(
              children: [
                Card(
                  elevation: 5,
                  child: Container(

                    height: 160.h,
                    width: 350.w,
                child: Column(
                  children: [
                  SizedBox(height: 15.h,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No data availble'),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 13),
                          child: Text('1-10 of',style: TextStyle(color: Colors.grey.shade600),),
                        ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_left,color: Colors.grey.shade600,)),
                        IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_right,color: Colors.grey.shade600,)),
                      ],
                    ),
SizedBox(height: 30.h,),
Row(
  crossAxisAlignment: CrossAxisAlignment.end,
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 13),
        child: Text('Rows per page:',style: TextStyle(color: Colors.grey.shade600),),
    ),
          PopupMenuButton<int>(
            icon: Icon(Icons.keyboard_arrow_down_rounded),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text("10"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("20"),
              ),
            ],
          ),
    // IconButton(onPressed: (){
    //   PopupMenuButton<int>(
    //     itemBuilder: (context) => [
    //       PopupMenuItem(
    //         value: 1,
    //         child: Text("First"),
    //       ),
    //       PopupMenuItem(
    //         value: 2,
    //         child: Text("Second"),
    //       ),
    //     ],
    //   );
    // },
    //   icon: Icon(Icons.keyboard_arrow_down),
    // ),
  ],
)
                  ],
                )
                  ),

                ),

              ],
            ),

          ],
        ),
      ),
    );
  }

}
