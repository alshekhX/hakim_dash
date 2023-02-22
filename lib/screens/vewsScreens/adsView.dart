import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/networkConst.dart';
import 'package:hakim_dash/models/Ad.dart';
import 'package:hakim_dash/providers/homeCareProvider.dart';
import 'package:hakim_dash/screens/addScreens/addAd.dart';
import 'package:hakim_dash/screens/addScreens/addHomeCare.dart';
import 'package:hakim_dash/screens/updateScreens/UpdateHomeCareSc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../consts/HakimColors.dart';
import '../../models/HomeCare.dart';
import '../../providers/adsProvider.dart';
import '../widget/apppBar.dart';
import '../widget/hakimLoadingIndicator.dart';
class AdsView extends StatefulWidget {
  const AdsView({super.key});

  @override
  State<AdsView> createState() => _AdsViewState();
}

class _AdsViewState extends State<AdsView> {
 @override
  void initState() {
    getAds();
    // TODO: implement initState
    super.initState();
  }
 List<Ad>? ads;

  getAds() async {
    // String cate = Provider.of<ArticlePrvider>(context, listen: false).category;

    String res =
        await Provider.of<AdsProvider>(context, listen: false).getAds(1);
    print(res);

    if (res == 'success') {
      // ignore: use_build_context_synchronously
      ads = Provider.of<AdsProvider>(context, listen: false).ads;
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
              MaterialPageRoute(builder: (context) => const AddAd()))
        },
        child: const Text('إضافة'),
      ),
        appBar:ReusableWidgets.getAppBar('الأعلانات', true,context)
,
      body: ads != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15.sp),
                  Consumer<AdsProvider>(
                      builder: (context, adProv, _) {
                    List<Widget> adsWidgets = [];

                    for (int i = 0; i < adProv.ads!.length; i++) {
                      String imgUrl = adProv.ads![i].assets!.isEmpty
                          ? ''
                          : adProv.ads![i].assets![0];

                          adProv.ads![i].assets!.insert(0, imgUrl);

                      adsWidgets.add(InkWell(
                        onTap: () {
//  Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => HomeCareDes(
//                                         homeCare: homeCares![i],
//                                       )));
                        },
                        child: AdsCard(
                           ad: adProv.ads![i] ,),
                      ));
                    }

                    return Column(
                      children: adsWidgets,
                    );
                  })
                ],
              ),
            )
          : const HaLoadingIndicator()
    );
  }
}

class AdsCard extends StatelessWidget {
  final Ad ad;
  const AdsCard({
    Key? key,
    required this.ad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

            Container(
                        height: 5.h,
                        child: Text(
                          ad.title!,
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
                          ad.description!,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontSize: 10.sp, color: const Color(0xff8E8B8B)),
                        ),
                      ),

              Center(
                child: Container(
                  width: 80.w,
                  child: Image.network(
                   NetworkConst().photoUrl+ ad.assets![0],
                    fit: BoxFit.cover,
                  ),
                ),
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
                      // Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          //     builder: (context) =>
                          //         UpdateHomeCare(homeCare: homeCare)));
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

                      // await showConformationDialog(context, homeCare.id!);
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
          ),
      
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
