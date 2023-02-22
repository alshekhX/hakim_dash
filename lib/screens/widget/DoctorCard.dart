import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/networkConst.dart';
import 'package:hakim_dash/models/Doctor.dart';
import 'package:hakim_dash/providers/doctorsProvider.dart';
import 'package:hakim_dash/screens/updateScreens/UpdateDoctorsSc.dart';
import 'package:hakim_dash/screens/widget/hakimLoadingIndicator.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../consts/HakimColors.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final IconData icon;

  const DoctorCard({Key? key, required this.doctor, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.sp),
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
                              NetworkConst().photoUrl + doctor.photo!),
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
                            doctor.firstName! + doctor.lastName!,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xff707070),
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Text(
                            // doctor.rank!
                            '',
                            style: TextStyle(
                                fontSize: 10.sp, color: Color(0xff8E8B8B)),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          Text(
                            doctor.category!,
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
                height: 2.3.sp,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 5.w,
                  ),
                  Container(
                      height: 5.h,
                      width: 40.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateDoctor(doctor: doctor)));
                        },
                        child: Text(
                          "تعديل",
                          style: TextStyle(fontSize: 11.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: HakimColors.doctorButton,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      )),
                  const Spacer(),
                  Container(
                      height: 5.h,
                      width: 40.w,
                      child: ElevatedButton(
                        onPressed: () async {
                          print('object');

                          await showConformationDialog(context, doctor.id!);
                        },
                        child: Text(
                          "مسح",
                          style: TextStyle(fontSize: 11.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      )),
                ],
              ),
            ],
          ),
        ),
        height: 30.h,
      ),
    );
  }

  showConformationDialog(BuildContext context, String id) {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 10, loadingWidget: HaLoadingIndicator());
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("إلغاء"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
        child: const Text(
          "نعم",
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () async {
          Navigator.pop(context);
          progressDialog.show();
          String res =
              await Provider.of<DoctorsProvider>(context, listen: false)
                  .deleteDoctor(id, NetworkConst().token);
          progressDialog.dismiss();
          if (res == 'success') {
            await showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Text("نججت العملية"),
                      content: Text("تم المسح بنجاح"),
                      actions: [],
                    ));
          } else {
            await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("فشلت العملية"),
                      content: Text(res),
                    ));
          }
        });

    AlertDialog alert = AlertDialog(
      title: const Text("تأكيد"),
      content: const Text("  هل أنت متأكد من أنك تريد مسح الطبيب"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
