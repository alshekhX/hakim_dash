import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/HakimColors.dart';
import 'package:hakim_dash/models/HomeCare.dart';
import 'package:hakim_dash/providers/homeCareProvider.dart';
import 'package:hakim_dash/screens/vewsScreens/homeCaresView.dart';
import 'package:hakim_dash/screens/widget/hakimLoadingIndicator.dart';
import 'package:hakim_dash/screens/widget/textFormW.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../widget/apppBar.dart';

class UpdateHomeCare extends StatefulWidget {
  const UpdateHomeCare({super.key, required this.homeCare});
  final HomeCare homeCare;

  @override
  State<UpdateHomeCare> createState() => _UpdateHomeCareState();
}

class _UpdateHomeCareState extends State<UpdateHomeCare> {
  TextEditingController nameC = TextEditingController();
  TextEditingController locationC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController phoneTwoC = TextEditingController();

  @override
  void initState() {
    nameC.text = widget.homeCare.name!;
    locationC.text = widget.homeCare.location!;

    phoneC.text = widget.homeCare.phone.toString().replaceAll('[', '').replaceAll(']', '');
    descriptionC.text = widget.homeCare.description!;

    // TODO: implement initState
    super.initState();
  }

  List<File> _images = [];
  final picker = ImagePicker();
  // List<Image>? categoryValue;

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar('إضافة وحدة منزلية', false, context),
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
                                    Text('إضغط لتحميل الصور',
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
                  title: 'إسم العيادة المنزلية',
                ),
                AppInputTextField(
                  controller: phoneC,
                  title: "رقم الهاتف",
                ),

                AppInputTextField(
                  controller: descriptionC,
                  title: "وصف العيادة المنزلية",
                ),

                Row(
                  children: [
                    SizedBox(
                      width: 7.5.w,
                    ),
                    Container(
                      width: 55.w,
                      child: AppInputTextField(
                        controller: locationC,
                        title: "وصف الموقع",
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'حدد الموقع',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: HakimColors.MainfontColor,
                            fontWeight: FontWeight.w400),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HakimColors.blueGreySurr,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.sp,
                ),
                Container(
                  width: 60.w,
                  height: 7.h,
                  child: ElevatedButton(
                      child: Text('إحفظ  بيانات الوحدة',
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

                                               List<String> phones = phoneC.text.split(',');

                          HomeCare homeCare = HomeCare(
                              name: nameC.text,
                              description: descriptionC.text,
                              phone: phones,
                              location: locationC.text,
                              id: widget.homeCare.id);

                          progressDialog.show();
                          String token =
                              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2M2UzYmNhOGIwOTJmYmNiNTAzY2ZiNjkiLCJpYXQiOjE2NzU4Njk1MzYsImV4cCI6MTcwNjk3MzUzNn0.KkhuvYQPscSQlcjCLByCEgf8gVYFOWV5GrgZoohthbM";

                          String res = await Provider.of<HomeCareProvider>(
                                  context,
                                  listen: false)
                              .updateHomeCare(_images, token, homeCare);

                          if (res == 'success') {
                            progressDialog!.dismiss();
                            await NAlertDialog(
                              dialogStyle: DialogStyle(titleDivider: true),
                              title: Text('نجاح',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              content: Text("تم تعديل الوحدة بنجاح",
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
                                              HomeCaresView(),
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
        for (int i = 0; i < images.length; i++) {
          _images.add(File(images[i].path));
        }
        setState(() {});
      }
    } else {}
  }
}
