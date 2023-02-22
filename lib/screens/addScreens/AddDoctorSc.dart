import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/HakimColors.dart';
import 'package:hakim_dash/consts/networkConst.dart';
import 'package:hakim_dash/providers/doctorsProvider.dart';
import 'package:hakim_dash/screens/vewsScreens/doctorsViewScreen.dart';
import 'package:hakim_dash/screens/widget/hakimLoadingIndicator.dart';
import 'package:hakim_dash/screens/widget/textFormW.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/Doctor.dart';
import '../updateScreens/UpdateDoctorsSc.dart';
import '../widget/apppBar.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController phoneTwoC = TextEditingController();

  TextEditingController descriptionC = TextEditingController();
  TextEditingController rank = TextEditingController();
  String? categoryValue;
  TextEditingController categoryController = TextEditingController();

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

  List<String> ranks = [
    'طبيب عمومي',
    "إستشاري",
    "نائب أخصائي",
    'أخصائي',
  ];

  @override
  Widget build(BuildContext context) {
    print(categoryValue);
    return Scaffold(
      appBar: ReusableWidgets.getAppBar('إضافة  طبيب', false, context),
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
                  valueX: categoryController,
                ),
                ChooseTextFieldW(
                  list: ranks,
                  title: 'الدرجة',
                  valueX: rank,
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
                              CustomProgressDialog(context,
                                  blur: 10,
                                  loadingWidget: HaLoadingIndicator());

                          List<String> phones = phoneC.text.split(',');

                          print(categoryValue);
                          Doctor doctor = Doctor(
                            firstName: firstNameC.text,
                            lastName: lastNameC.text,
                            category: categoryController.text,
                            email: emailC.text,
                            phone: phones,
                            description: descriptionC.text,
                            rank: rank.text,
                          );

                          progressDialog.show();
                          String token = NetworkConst().token;
                          String res = await Provider.of<DoctorsProvider>(
                                  context,
                                  listen: false)
                              .postDoc(_image!, token, doctor);

                          if (res == 'success') {
                            progressDialog.dismiss();
                            // ignore: use_build_context_synchronously
                            await NAlertDialog(
                              dialogStyle: DialogStyle(titleDivider: true),
                              title: Text('نجاح',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              content: Text("تم إضافة الطبيب بنجاح",
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: const Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              actions: <Widget>[
                                TextButton(
                                    child: const Text("إغلاق"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushAndRemoveUntil<dynamic>(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) =>
                                              const DoctorsView(),
                                        ),
                                        (route) =>
                                            false, //if you want to disable back feature set to false
                                      );
                                    }),
                              ],
                            ).show(context);
                          } else if (res == 's') {
                            progressDialog.dismiss();
                            // ignore: use_build_context_synchronously
                            await NAlertDialog(
                              title: Text("خطأ",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              dialogStyle: DialogStyle(titleDivider: true),
                              content: Text("خطأ في الشبكة",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              actions: <Widget>[
                                TextButton(
                                    child: const Text("إغلاق"),
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
                                      color: const Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              dialogStyle: DialogStyle(titleDivider: true),
                              content: Text("خطأ غير معروف",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xff707070),
                                      fontWeight: FontWeight.w600)),
                              actions: <Widget>[
                                TextButton(
                                    child: const Text("إغلاق"),
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
