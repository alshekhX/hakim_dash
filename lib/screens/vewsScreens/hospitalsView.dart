import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hakim_dash/consts/networkConst.dart';
import 'package:hakim_dash/models/Hospital.dart';
import 'package:hakim_dash/screens/addHomeCare.dart';
import 'package:hakim_dash/screens/addHospitalScreen.dart';
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddHospitalScreen()))
      },
      child: Text('إضافة'),),      appBar: AppBar(
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

                    for (int i = 0; i < hospitals!.length; i++) {
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
                            name: hospitals![i].name!,
                            image:
                               NetworkConst().photoUrl +
                                    hospitals![i].assets![0],
                            location: hospitals![i].location!,
                            description: hospitals![i].description!),
                      ));
                    }

                    return Column(
                      children: hospitalWidgets,
                    );
                  })
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class HospitalCard extends StatelessWidget {
  final String name;
  final String image;
  final String location;
  final String description;
  const HospitalCard({
    Key? key,
    required this.name,
    required this.image,
    required this.location,
    required this.description,
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
                  image,
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
                          name,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xff707070),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Container(
                        height: 10.h,
                        child: Text(
                          description,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontSize: 10.sp, color: Color(0xff8E8B8B)),
                        ),
                      ),
                      Spacer(),
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
                              location,
                              style: TextStyle(
                                  fontSize: 12.sp, color: Color(0xff8E8B8B)),
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
              Spacer(),
              Container(
                  height: 4.h,
                  width: 50.w,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "تواصل",
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: HakimColors.doctorButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                  )),
            ],
          ),
          SizedBox(
            height: 2.5.h,
          )
        ],
      ),
    );
  }
}
