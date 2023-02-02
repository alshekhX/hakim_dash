import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hakim_dash/consts/networkConst.dart';
import 'package:hakim_dash/providers/homeCareProvider.dart';
import 'package:hakim_dash/screens/addScreens/addHomeCare.dart';
import 'package:hakim_dash/screens/updateScreens/UpdateHomeCareSc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../consts/HakimColors.dart';
import '../../models/HomeCare.dart';
import '../../providers/hospitalProvider.dart';

class HomeCaresView extends StatefulWidget {
  const HomeCaresView({super.key});

  @override
  State<HomeCaresView> createState() => _HomeCaresViewState();
}

class _HomeCaresViewState extends State<HomeCaresView> {
  @override
  void initState() {
    getHomeCares();
    // TODO: implement initState
    super.initState();
  }

  List<HomeCare>? homeCares;

  getHomeCares() async {
    // String cate = Provider.of<ArticlePrvider>(context, listen: false).category;

    String res = await Provider.of<HomeCareProvider>(context, listen: false)
        .getHomeCare(1);
    print(res);

    if (res == 'success') {
      homeCares =
          Provider.of<HomeCareProvider>(context, listen: false).homeCares;
      print(homeCares);
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddHomeCare()))
        },
        child: const Text('إضافة'),
      ),
      appBar: AppBar(
          toolbarHeight: 50.sp,
          backgroundColor: HakimColors.hakimPrimaryColor,
          title: const Text('العلاج المنزلي')),
      body: homeCares != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15.sp),
                  Consumer<HomeCareProvider>(
                      builder: (context, homeCareProv, _) {
                    List<Widget> homeCareWidgets = [];

                    for (int i = 0; i < homeCareProv.homeCares!.length; i++) {
                      String imgUrl = homeCareProv.homeCares![i].assets!.isEmpty
                          ? ''
                          : homeCareProv.homeCares![i].assets![0];

                          homeCareProv.homeCares![i].assets!.insert(0, imgUrl);

                      homeCareWidgets.add(InkWell(
                        onTap: () {
//  Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => HomeCareDes(
//                                         homeCare: homeCares![i],
//                                       )));
                        },
                        child: HomeCareCard(
                           homeCare: homeCareProv.homeCares![i] ,),
                      ));
                    }

                    return Column(
                      children: homeCareWidgets,
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

class HomeCareCard extends StatelessWidget {
  final HomeCare homeCare;
  const HomeCareCard({
    Key? key,
    required this.homeCare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                 NetworkConst().photoUrl+ homeCare.assets![0],
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
                          homeCare.name!,
                          overflow: TextOverflow.visible,
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
                        height: 8.h,
                        child: Text(
                          homeCare.description!,
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
                              homeCare.location!,
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
            height: 3.h,
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
                                  UpdateHomeCare(homeCare: homeCare)));
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

                      await showConformationDialog(context, homeCare.id!);
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
        child: const Text(
          "نعم",
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () async {
          Navigator.pop(context);

          String res =
              await Provider.of<HomeCareProvider>(context, listen: false)
                  .deleteHomeCare(id, NetworkConst().token);

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
