import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../consts/HakimColors.dart';

class ReusableWidgets {
  static getAppBar(String title) {
    return  AppBar(
          toolbarHeight: 50.sp,
          backgroundColor: HakimColors.hakimPrimaryColor,
          title:  Text(title));
  }
}