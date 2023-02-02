

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/HakimColors.dart';
import 'package:hakim_dash/models/Hospital.dart';
import 'package:hakim_dash/providers/hospitalProvider.dart';
import 'package:hakim_dash/screens/widget/hakimAppBAr.dart';
import 'package:hakim_dash/screens/widget/textFormW.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddHospitalScreen extends StatefulWidget {
  const AddHospitalScreen({super.key});

  @override
  State<AddHospitalScreen> createState() => _AddHospitalScreenState();
}

class _AddHospitalScreenState extends State<AddHospitalScreen> {
   TextEditingController nameC = TextEditingController();
  TextEditingController locationC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  List<File> _images = [];
      TextEditingController phoneTwoC = TextEditingController();

  final picker = ImagePicker();
  // List<Image>? categoryValue;
  final formGlobalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar('إضافة مستشفى'),
      body: SafeArea(
        child: Form(                      key: formGlobalKey,
          child: SingleChildScrollView(


            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25.sp,
                ),
        
                 Center(
                        child: Container(
                          width: 80.w,
                          height: 42.5.w,
                          child: _images.isEmpty
                              ? InkWell(
                                  onTap: () async {
                                    await _multipleImgFromGallery();
                              
                                  },
                                  child: Card(
                                    elevation: 3.sp,
                                    shadowColor: Colors.grey.withOpacity(.6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(5.sp),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Ionicons.add_circle_outline,
                                            size: 55.sp,
                                            color:HakimColors.hakimPrimaryColor,
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Text(
                                            'إضغط لتحميل الصور',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: Color(0xffB5B5B5),
                                                  fontWeight: FontWeight.w300)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () async {
                                    await _multipleImgFromGallery();
                                  },
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: _images
                                        .map((e) => Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Image.file(e),
                                            ))
                                        .toList()
                                    // Image.file(_images[0]),
                                    ,
                                  )),
                        ),
                      ),
                SizedBox(
                  height: 25.sp,
                ),
        
                AppInputTextField(
                  controller: nameC,
                  title: 'إسم المستشفى',
                ),
                AppInputTextField(
                  controller: phoneC,
                  title: "رقم الهاتف",
                ),
                
                AppInputTextField(
                  controller: descriptionC,
                  title: "وصف المستشفى",
                ),
        
                Row(
                  children: [
                    SizedBox(width: 7.5.w,),
                     Container(
                      width: 55.w,
                       child: AppInputTextField(
                        controller: locationC,
                        title: "وصف الموقع",
                    ),
                    
                     ),
                     Spacer(),
                     
                
                    ElevatedButton(onPressed: (){}, child: Text('حدد الموقع',style: TextStyle(
                                  fontSize: 14.sp,
                                  color: HakimColors.MainfontColor,
                                  fontWeight: FontWeight.w400),),
                       style: ElevatedButton.styleFrom(
                            backgroundColor:HakimColors.blueGreySurr,
                           
                          ),)
                
                ,SizedBox(width: 5.w,),
                    
                  ],
                ),
                SizedBox(height: 30.sp,),
                 Container(
                        width: 60.w,
                        height: 7.h,
                        child: ElevatedButton(
                          child: Text('إحفظ  بيانات المستشفى',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:HakimColors.hakimPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                       onPressed: () async  {

                        
                        if (formGlobalKey.currentState!.validate()) {
                          formGlobalKey.currentState!.save();
                          CustomProgressDialog progressDialog =
                              CustomProgressDialog(context, blur: 10);

                          List<String> phones = [];
                          phones.add(phoneC.text);
                          if (phoneTwoC.text.isNotEmpty) {
                            phones.add(phoneTwoC.text);
                          }

                          Hospital hospital = Hospital(
                            name: nameC.text,
                            description: descriptionC.text,
                            phone: phones,
                            location: locationC.text
                         
                          );

                          progressDialog.show();
                          String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzliMGJhMzk3OGVhNWExMDIxNzhkM2EiLCJpYXQiOjE2NzExMDU2ODgsImV4cCI6MTcwMjIwOTY4OH0.-CVzFpdYqYTtzCXnQDRMQGiVyg2d--ae-AuSN5USHwo';

                          String res = await Provider.of<HospitalProvider>(
                                  context,
                                  listen: false).
                             postHospital(_images, token, hospital);

                          if (res == 'success') {
                            progressDialog!.dismiss();
                            await NAlertDialog(
                              dialogStyle: DialogStyle(titleDivider: true),
                              title: Text('نجاح',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              content: Text("تم إضافة المستشفى بنجاح",
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              actions: <Widget>[
                                TextButton(
                                    child: Text("إغلاق"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // Navigator.pushAndRemoveUntil<dynamic>(
                                      //   context,
                                      //   MaterialPageRoute<dynamic>(
                                      //     builder: (BuildContext context) =>
                                      //         BottomNavBAr(
                                      //       index: 3,
                                      //     ),
                                      //   ),
                                      //   (route) =>
                                      //       false, //if you want to disable back feature set to false
                                      // );
                                    }),
                              ],
                            ).show(context);
                          }  else if (res == 's') {
                            progressDialog.dismiss();
                            await NAlertDialog(
                              title: Text(
                                "خطأ",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              dialogStyle: DialogStyle(titleDivider: true),
                              content: Text(
                                "خطأ في الشبكة",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              actions: <Widget>[
                                TextButton(
                                    child: Text("إغلاق"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ],
                            ).show(context);
                          } else {
                            progressDialog.dismiss();

                            await NAlertDialog(
                              title: Text(
                                 "خطأ",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              dialogStyle: DialogStyle(titleDivider: true),
                              content: Text(
                                 "خطأ غير معروف",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              actions: <Widget>[
                                TextButton(
                                    child: Text("إغلاق"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ],
                            ).show(context);
                          }
                        } 
                      }),
                ),
                      
                                  SizedBox(height: 30.sp,),
        
               
             
        
                // AppInputTextField(controller: usernameC),
              ],
            ),
          ),
        ),
      ),
    );
  }

   Future _multipleImgFromGallery() async {
    // ProgressDialog pd = ProgressDialog(context: context);
    _images.clear();

    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      if (images.length < 1) {
        await NAlertDialog(
          dialogStyle: DialogStyle(titleDivider: true),
          title: Text('يجب عليك تحميل صورة على الاقل',
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xff707070),
                  fontWeight: FontWeight.w600)),
          content: Text(
              "خطأ",
              style: TextStyle(
                  fontSize: 11.sp,
                  color: Color(0xff707070),
                  fontWeight: FontWeight.w600)),
          actions: <Widget>[
            TextButton(
                child: Text("موافق"),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ).show(context);
      } else {
        for (int i = 0; i < images.length; i++) {
          _images.add(File(images[i].path));
        }
        setState(() {});
      }
    } else {}
  }

}
