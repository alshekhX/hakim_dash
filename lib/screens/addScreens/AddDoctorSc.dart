import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/HakimColors.dart';
import 'package:hakim_dash/providers/doctorsProvider.dart';
import 'package:hakim_dash/screens/widget/hakimAppBAr.dart';
import 'package:hakim_dash/screens/widget/textFormW.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/Doctor.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController usernameC = TextEditingController();
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController phoneTwoC = TextEditingController();

  TextEditingController descriptionC = TextEditingController();
  TextEditingController Rank = TextEditingController();
  String? categoryValue;

  List<String> categories = [
    'الجهاز التناسلي',
    "العظام والمفاصل",
    "الكبد",
    'الجهاز الهضمي',
    'الكلى',
    'أمراض الدم',
    'الأطفال',
    'نساء وتوليد',
    'الصحة النفسية',
    'القلب'
  ];

  @override
  Widget build(BuildContext context) {
    print(categoryValue);
    return Scaffold(
                  appBar: ReusableWidgets.getAppBar('إضافة  طبيب'),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25.sp,
                ),

                InkWell(
                  onTap: () async {
                    await _imgFromGallery();
                  },
                  child: Stack(
                    children: [
                      _image == null
                          ? const CircleAvatar(
                              radius: 60,
                              backgroundColor: HakimColors.hakimPrimaryColor,
                              child: CircleAvatar(
                                // child: ClipRRect(
                                //   child: CachedNetworkImage(
                                //     height: 25.h,
                                //     width: 25.h,
                                //     fit: BoxFit.cover,
                                //     imageUrl:
                                //         user.avatar == null ? '' : user.avatar!,
                                //     errorWidget: (context, url, error) =>
                                //         Image.asset(
                                //       'assets/profile.png',
                                //       fit: BoxFit.contain,
                                //     ),
                                //   ),
                                //   borderRadius: BorderRadius.circular(100),
                                // ),
                                radius: 58,
                              ),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundColor: HakimColors.hakimPrimaryColor,
                              child: CircleAvatar(
                                backgroundImage: FileImage(_image!),
                                // child: ClipRRect(
                                //   child: CachedNetworkImage(
                                //     height: 25.h,
                                //     width: 25.h,
                                //     fit: BoxFit.cover,
                                //     imageUrl:
                                //         user.avatar == null ? '' : user.avatar!,
                                //     errorWidget: (context, url, error) =>
                                //         Image.asset(
                                //       'assets/profile.png',
                                //       fit: BoxFit.contain,
                                //     ),
                                //   ),
                                //   borderRadius: BorderRadius.circular(100),
                                // ),
                                radius: 58,
                              ),
                            ),
                      Positioned(
                          bottom: 5,
                          right: 10,
                          child: Icon(
                            Ionicons.camera,
                            color: Colors.black.withOpacity(.87),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.sp,
                ),

                AppInputTextField(
                  controller: usernameC,
                  title: 'إسم المستخدم',
                ),
                AppInputTextField(
                  controller: firstNameC,
                  title: "الاسم ألأول",
                ),

                AppInputTextField(
                  controller: lastNameC,
                  title: "الاٍسم الأخير",
                ),
                AppInputTextField(
                  controller: emailC,
                  title: "البريد الإلكتروني",
                ),
                AppInputTextField(controller: phoneC, title: "رقم الهاتف"),
                ChooseTextFieldW(
                  list: categories,
                  title: 'الإختصاص',
                  value: categoryValue,
                ),

                AppInputTextField(
                  controller: descriptionC,
                  title: "الوصف",
                ),

                SizedBox(
                  height: 30.sp,
                ),
                Container(
                  width: 60.w,
                  height: 7.h,
                  child: ElevatedButton(
                      child: Text('إحفظ  بيانات الطبيب',
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
                              CustomProgressDialog(context, blur: 10);

                          List<String> phones = [];
                          phones.add(phoneC.text);
                          if (phoneTwoC.text.isNotEmpty) {
                            phones.add(phoneTwoC.text);
                          }

                          Doctor doctor = Doctor(
                            username: usernameC.text,
                            firstName: firstNameC.text,
                            lastName: lastNameC.text,
                            category: categoryValue,
                            email: emailC.text,
                            phone: phones,
                            description: descriptionC.text,
                            rank: Rank.text,
                          );

                          progressDialog.show();
                          String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzliMGJhMzk3OGVhNWExMDIxNzhkM2EiLCJpYXQiOjE2NzExMDU2ODgsImV4cCI6MTcwMjIwOTY4OH0.-CVzFpdYqYTtzCXnQDRMQGiVyg2d--ae-AuSN5USHwo';

                          String res = await Provider.of<DoctorsProvider>(
                                  context,
                                  listen: false)
                              .postDoc(_image!, token, doctor);

                          if (res == 'success') {
                            progressDialog!.dismiss();
                            await NAlertDialog(
                              dialogStyle: DialogStyle(titleDivider: true),
                              title: Text('نجاح',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              content: Text("تم إضافة الطبيب بنجاح",
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

  File? _image;
  final picker = ImagePicker();

  Future _imgFromGallery() async {
    // ProgressDialog pd = ProgressDialog(context: context);

    PickedFile? image =
        // ignore: deprecated_member_use
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    // pd.show(max: 10, msg: 'جاري تحميل الإشعار');

    if (image != null) {
      _image = File(image.path);
      setState(() {});
    } else {}
  }
}

class ChooseTextFieldW extends StatelessWidget {
  const ChooseTextFieldW({
    Key? key,
    required this.list,
    required this.title,
    required this.value,
  }) : super(key: key);

  final List<String> list;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xff707070),
                  fontWeight: FontWeight.w400)),
          SizedBox(
            height: 5.sp,
          ),
          Container(
            width: 85.w,
            child: DropdownButtonFormField2(
              icon: Icon(Icons.arrow_drop_down,
                  color: HakimColors.hakimPrimaryColor, size: 20.sp),
              decoration: InputDecoration(
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        BorderSide(width: 0.5, color: Colors.grey.shade400)),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              hint: const Text(
                ' ',
                style: TextStyle(fontSize: 14),
              ),
              iconSize: 30,
              buttonHeight: 60,
              buttonPadding: const EdgeInsets.only(left: 20, right: 10),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: list
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'إختر قيمة';
                }
              },
              onChanged: (value) {
                // if (title ==
                //     'الإختصاص') {
                //   value = value.toString();
                // }
                value = value.toString();

                // if (title == AppLocalizations.of(context)!.location_addcarPG) {
                //   locationV = value.toString();
                // }

                //   models = items.map((e) {
                //     List lModels = [];
                //     for (int i = 0; i < items.length; i++) {
                //       if (items[i].id == value) {

                //         lModels = items[i].models;
                //       }
                //     }

                //     return lModels;
                //   }).first;
                //   setState(() {});
                //Do something when changing the item if you want.
              },
              onSaved: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
