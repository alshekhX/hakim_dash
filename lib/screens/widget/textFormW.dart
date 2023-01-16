

import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/HakimColors.dart';
import 'package:sizer/sizer.dart';
class AppInputTextField extends StatelessWidget {
  const AppInputTextField({
    Key? key,
    required this.controller,
    required this.title,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff707070),
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: 5.sp,
            ),
            Container(
              width: 85.w,
              child: TextFormField(
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'لا تترك الحقل فارغ';
                  }
                },
                controller: controller,
                decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff0288D1), width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                    hintStyle: TextStyle(
                        fontSize: 9.sp,
                        color: Color(0xff707070).withOpacity(.8),
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
