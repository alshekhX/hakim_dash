import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/networkConst.dart';
import 'package:sizer/sizer.dart';

import '../../consts/HakimColors.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String image;
  final IconData icon;
  final String rank;
  final String category;

  const DoctorCard({
    Key? key, required this.name, required this.image, required this.icon, required this.rank, required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 5.sp),
      child: Container(
        color: Colors.white,
        width: 100.w,
        // ignore: sort_child_properties_last
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.3.h),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 14.h,
                    width: 21.w,
                    child: CircleAvatar(
                      backgroundColor: HakimColors.hakimPrimaryColor,
                      child: Container(
                        height: 13.h,
                        width: 20.w,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            NetworkConst().photoUrl+image),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    height: 14.h,
                    width: 52.w,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.sp,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xff707070),
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Text(
                           rank,
                            style: TextStyle(
                                fontSize: 10.sp, color: Color(0xff8E8B8B)),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Text(
                            category,
                            style: TextStyle(
                                fontSize: 10.sp, color: Color(0xff8E8B8B)),
                          )
                        ]),
                  ),
                  Container(
                    width: 10.w,
                    height: 14.h,
                    child: CircleAvatar(
                      backgroundColor: HakimColors.hakimPrimaryColor,
                      radius: 50,
                      child: Icon(
                       icon,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.3,
              ),
              Container(
                  height: 4.h,
                  width: 52.w,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("تواصل",style: TextStyle(fontSize: 11.sp)),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                        backgroundColor: HakimColors.doctorButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                  ))
            ],
          ),
        ),
        height: 25.h,
      ),
    );
  }
}
