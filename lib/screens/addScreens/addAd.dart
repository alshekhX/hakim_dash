import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/HakimColors.dart';
import 'package:hakim_dash/models/Ad.dart';
import 'package:hakim_dash/models/HomeCare.dart';
import 'package:hakim_dash/providers/adsProvider.dart';
import 'package:hakim_dash/providers/homeCareProvider.dart';
import 'package:hakim_dash/screens/vewsScreens/adsView.dart';
import 'package:hakim_dash/screens/vewsScreens/homeCaresView.dart';
import 'package:hakim_dash/screens/widget/chooseTextField.dart';
import 'package:hakim_dash/screens/widget/hakimLoadingIndicator.dart';
import 'package:hakim_dash/screens/widget/textFormW.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../widget/apppBar.dart';

class AddAd extends StatefulWidget {
  const AddAd({super.key});

  @override
  State<AddAd> createState() => _AddAdState();
}

class _AddAdState extends State<AddAd> {
  TextEditingController title = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  File? _image;
  final picker = ImagePicker();
  // List<Image>? categoryValue;

  final formGlobalKey = GlobalKey<FormState>();

  List<String> adType = [
    "video",
    "image",
  ];

  List<String> adDuration = [
    '7',
    '30',
    '90',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar('إضافة إعلان', false, context),
      body: SafeArea(
        child: Form(
          key: formGlobalKey,
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
                    child: _image == null
                        ? InkWell(
                            onTap: () async {
                              if (type.text.isEmpty) {
                                print('choose ad type');
                              } else {
                                await imgFromGallery();
                              }
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Ionicons.add_circle_outline,
                                      size: 55.sp,
                                      color: HakimColors.hakimPrimaryColor,
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text('إضغط لتحميل صورة الاعلان',
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
                              await imgFromGallery();
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.file(_image!),
                              )
                              // Image.file(_images[0]),
                              ,
                            )),
                  ),
                ),
         
                SizedBox(
                  height: 25.sp,
                ),
                ChooseTextFieldW(
                    list: adType, title: 'نوع الإعلان', valueX: type),



                AppInputTextField(
                  controller: title,
                  title: 'عنوان الأعلان',
                ),
                AppInputTextField(
                  controller: descriptionC,
                  title: " وصف الأعلان",
                ),
                  ChooseTextFieldW(
                    list: adDuration, title: 'فترة الإعلان', valueX: duration),
                

                SizedBox(
                  height: 30.sp,
                ),
                Container(
                  width: 60.w,
                  height: 7.h,
                  child: ElevatedButton(
                      child: Text('إحفظ  بيانات الإعلان',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HakimColors.hakimPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () async {
                        if (formGlobalKey.currentState!.validate()) {
                          formGlobalKey.currentState!.save();
                          CustomProgressDialog progressDialog =
                              CustomProgressDialog(context,
                                  blur: 10,
                                  loadingWidget: HaLoadingIndicator());

                          Ad ad = Ad(
                            title: title.text,
                            description: descriptionC.text,
                            duration:  int.parse(duration.text),
                            type: type.text
                          );

                          progressDialog.show();
                          String token =
                              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2M2UzYmNhOGIwOTJmYmNiNTAzY2ZiNjkiLCJpYXQiOjE2NzU4NjkzNTIsImV4cCI6MTcwNjk3MzM1Mn0.OcO8YS2DOFVDQxni14zUQibjDdNncAYOca5DAGcMx0U";

                          String res = await Provider.of<AdsProvider>(context,
                                  listen: false)
                              .postAD(_image, token, ad);

                          if (res == 'success') {
                            progressDialog.dismiss();
                            await NAlertDialog(
                              dialogStyle: DialogStyle(titleDivider: true),
                              title: Text('نجاح',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              content: Text("تم إضافة الأعلان بنجاح",
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              actions: <Widget>[
                                TextButton(
                                    child: Text("إغلاق"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushAndRemoveUntil<dynamic>(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) =>
                                              AdsView(),
                                        ),
                                        (route) =>
                                            false, //if you want to disable back feature set to false
                                      );
                                    }),
                              ],
                            ).show(context);
                          } else if (res == 's') {
                            progressDialog.dismiss();
                            await NAlertDialog(
                              title: Text("خطأ",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              dialogStyle: DialogStyle(titleDivider: true),
                              content: Text("خطأ في الشبكة",
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
                              title: Text("خطأ",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              dialogStyle: DialogStyle(titleDivider: true),
                              content: Text("خطأ غير معروف",
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
                SizedBox(
                  height: 30.sp,
                ),

                // AppInputTextField(controller: usernameC),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future imgFromGallery() async {
    // ProgressDialog pd = ProgressDialog(context: context);
    _image == null;

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      await NAlertDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: Text('يجب عليك تحميل صورة  للإعلان',
            style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xff707070),
                fontWeight: FontWeight.w600)),
        content: Text("خطأ",
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
      _image = File(image.path);

      setState(() {});
    }
  }
}
