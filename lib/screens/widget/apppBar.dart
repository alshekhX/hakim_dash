import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../consts/HakimColors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:hakim_dash/screens/HomePage.dart';



class ReusableWidgets {
  static getAppBar(String title,bool view, BuildContext context) {

    if(view=false){
    return  AppBar(
          toolbarHeight: 50.sp,
          backgroundColor: HakimColors.hakimPrimaryColor,
          title:  Text(title));}
          else{


            return  AppBar(
          toolbarHeight: 50.sp,
          automaticallyImplyLeading: false,actions: [
                                  IconButton(icon: Icon(Ionicons.arrow_back),onPressed: (() => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()))))
],
          backgroundColor: HakimColors.hakimPrimaryColor,
          title:  Text(title));
          }
  }
}