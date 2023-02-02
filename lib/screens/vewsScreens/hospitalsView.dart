import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/networkConst.dart';
import 'package:hakim_dash/models/Hospital.dart';
import 'package:hakim_dash/screens/addScreens/addHospitalScreen.dart';
import 'package:hakim_dash/screens/updateScreens/UpdateHospitalSc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../consts/HakimColors.dart';
import '../../providers/hospitalProvider.dart';

class HospitalView extends StatefulWidget {
  const HospitalView({super.key});

  @override
  State<HospitalView> createState() => _HospitalViewState();
}

class _HospitalViewState extends State<HospitalView> {
  @override
  void initState() {
    getHospitals();
    // TODO: implement initState
    super.initState();
  }

  List<Hospital>? hospitals;

  getHospitals() async {
    // String cate = Provider.of<ArticlePrvider>(context, listen: false).category;

    String res = await Provider.of<HospitalProvider>(context, listen: false)
        .getHospitals(1);
    print(res);

    if (res == 'success') {
      // ignore: use_build_context_synchronously
      hospitals =
          Provider.of<HospitalProvider>(context, listen: false).hospitals;
      setState(() {});
    } else {
      print(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent.shade400,
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddHospitalScreen()))
        },
        child: const Text('إضافة'),
      ),
      appBar: AppBar(
          toolbarHeight: 50.sp,
          backgroundColor: HakimColors.hakimPrimaryColor,
          title: const Text('المستشفيات')),
      body: hospitals != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15.sp),
                  Consumer<HospitalProvider>(
                      builder: (context, hospitalProv, _) {
                    List<Widget> hospitalWidgets = [];

                    for (int i = 0; i < hospitalProv.hospitals!.length; i++) {
                      hospitalWidgets.add(InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => HospitalDes(
                          //               hospital: hospitals![i],
                          //             )));
                        },
                        child: HospitalCard(
                          hospital: hospitalProv.hospitals![i],
                        ),
                      ));
                    }

                    return Column(
                      children: hospitalWidgets,
                    );
                  })
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class HospitalCard extends StatelessWidget {
  final Hospital hospital;
  const HospitalCard({
    Key? key,
    required this.hospital,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(hospital.id);
    return Padding(
      padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 15.sp),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 20.6.h,
                width: 34.w,
                child: Image.network(
                  NetworkConst().photoUrl + hospital.assets![0],
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                width: 50.w,
                height: 20.6.h,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 5.h,
                        child: Text(
                          hospital.name!,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Container(
                        height: 10.h,
                        child: Text(
                          hospital.description!,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontSize: 10.sp, color: const Color(0xff8E8B8B)),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Icon(
                                Icons.pin_drop,
                                size: 15.sp,
                                color: HakimColors.hakimPrimaryColor,
                              )),
                          SizedBox(
                            width: 5.sp,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              hospital.location!,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xff8E8B8B)),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ],
          ),
          SizedBox(
            height: 2.5.h,
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
                                  UpdateHospital(hospital: hospital)));
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

                      await showConformationDialog(context, hospital.id!);
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
          SizedBox(
            height: 5.h,
          )
        ],
      ),
    );
  }



  showConformationDialog(BuildContext context, String id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("إلغاء"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
        child: const Text("نعم",style: TextStyle(color: Colors.red),),
        onPressed: () async {
          Navigator.pop(context);

          String res =
              await Provider.of<HospitalProvider>(context, listen: false)
                  .deleteHospital(id, NetworkConst().token);

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
      content: const Text("  هل أنت متأكد من أنك تريد مسح المحتوى؟"),
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
