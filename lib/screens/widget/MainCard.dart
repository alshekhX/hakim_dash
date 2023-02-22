import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakim_dash/screens/HomePage.dart';
import 'package:sizer/sizer.dart';

import '../../consts/HakimColors.dart';

class HakimMainCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const HakimMainCard({Key? key, required this.title, required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 35.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30.sp,
            color: HakimColors.hakimPrimaryColor,
          ),
          SizedBox(
            height: 8.sp,
          ),
          Text(
            title,
            style: TextStyle(
                color: HakimColors.MainfontColor,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: HakimColors.hakimPrimaryColor)),
    );
  }
}
