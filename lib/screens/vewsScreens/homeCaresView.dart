import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hakim_dash/consts/networkConst.dart';
import 'package:hakim_dash/providers/homeCareProvider.dart';
import 'package:hakim_dash/screens/addHomeCare.dart';
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

    String res =
        await Provider.of<HomeCareProvider>(context, listen: false).getHomeCare(1);
              print(res);

    if (res == 'success') {
      homeCares = Provider.of<HomeCareProvider>(context, listen: false).homeCares;
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddHomeCare()))
      },
      child: Text('إضافة'),),   
      appBar: AppBar(
          toolbarHeight: 50.sp,
          backgroundColor: HakimColors.hakimPrimaryColor,
          title: const Text('العلاج المنزلي')),
      body: homeCares!=null? SingleChildScrollView(
        child: Column(
          children: [SizedBox(height: 15.sp),       Consumer(   builder: (context, homeCareProv, _) {
                    List<Widget> homeCareWidgets = [];

                    for (int i = 0; i < homeCares!.length; i++) {
                      homeCareWidgets.add(
                        InkWell(
                        onTap: () {

//  Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => HomeCareDes(
//                                         homeCare: homeCares![i],
//                                       )));



                        },
                        child: HomeCareCard(
                            name: homeCares![i].name!,
                            image: NetworkConst().photoUrl+homeCares![i].assets![0],
                            location: homeCares![i].location!,
                            description: homeCares![i].description!),
                      ));
                    }

                    return Column(
                      children: homeCareWidgets,
                    );
                  })],
        ),
      ):Center(child: CircularProgressIndicator(),),
    );
  }
}

class HomeCareCard extends StatelessWidget {
  final String name;
  final String image;
  final String location;
  final String description;
  const HomeCareCard({
    Key? key, required this.name, required this.image, required this.location, required this.description,
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
                         overflow: TextOverflow.visible,
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
                        height: 8.h,
                        child: Text(description,
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
                            child: Icon(Icons.pin_drop,size: 15.sp,color: HakimColors.hakimPrimaryColor,)),
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
                    child: Text("تواصل",style: TextStyle(fontSize: 11.sp),),
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
