






import 'package:flutter/material.dart';
import 'package:hakim_dash/screens/vewsScreens/doctorsViewScreen.dart';
import 'package:hakim_dash/screens/vewsScreens/homeCaresView.dart';
import 'package:hakim_dash/screens/vewsScreens/hospitalsView.dart';
import 'package:hakim_dash/screens/widget/MainCard.dart';
import 'package:sizer/sizer.dart';

import '../consts/HakimColors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 30.h,
                  width: 100.w,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff00C7C7),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                    ),
                    height: 25.h,
                    width: 100.w,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 35.sp,
                        ),
                        Image.asset('assets/mainLogo.png')
                      ],
                    ),
                  ),
                ),
                  ],
            ),
           
            Container(
              color: HakimColors.greySurr,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Column(
                  children: [
                    InkWell(
                       onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HospitalView()));
                      },

                      child: const HakimMainCard(
                        title: 'المستشفيات',
                        icon: Icons.local_hospital_outlined,
                      ),
                    ),
                    SizedBox(
                      height: 20.sp
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DoctorsView()));
                      },
                      child: const HakimMainCard(
                        title: 'الأطباء',
                        icon: Icons.medical_information_outlined,
                      ),
                    ),
                    SizedBox(
                      height: 20.sp
                    ),
                    InkWell(
                      onTap: (){
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeCaresView()));
                      },
                      child: const HakimMainCard(
                        title: 'العلاج المنزلي',
                        icon: Icons.home_outlined,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
         

        

           

          
            //            Padding(
            //           padding:  EdgeInsets.only(left: 5.w,right: 5.w),
            //           child: Row(children: [
            //             Container(
            //               height: 30.h,
            //               color: Colors.grey.shade200,
            //               width: 29.w,
            //               child: Column(children: [

            //                 SizedBox(height: 16.sp,),
            //                 Text('الأطباء',style: GoogleFonts.tajawal(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.bold),),

            //                                 SizedBox(height: 16.sp,),
            //                                 Icon(Icons.medical_information_rounded,size: 32.sp,),
            // ],),
            //             ),
            //             SizedBox(width: 1.5.w,),
            //             Container(
            //               height: 30.h,
            //               color: Colors.grey.shade200,
            //               width: 29.w,
            //               child: Column(children: [

            //                 SizedBox(height: 16.sp,),
            //                 Text('الأطباء',style: GoogleFonts.tajawal(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.bold),)],),

            //             ),
            //             SizedBox(width: 1.5.w,),
            //               Container(
            //               height: 30.h,
            //               color: Colors.grey.shade200,
            //               width: 29.w,
            //               child:Column(children: [

            //                 SizedBox(height: 16.sp,),
            //                 Text('الأطباء',style: GoogleFonts.tajawal(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.bold),)],),

            //             ),

            //           ],),
            //         )

            //           Align(alignment: Alignment.topRight,
            //                                     child:                 Text('الاطباء',style: GoogleFonts.tajawal(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.bold),
            // ))
          ],
        ),
      ),
    );
  }
}
