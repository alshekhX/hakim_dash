import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hakim_dash/screens/addScreens/AddDoctorSc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../consts/HakimColors.dart';
import '../../models/Doctor.dart';
import '../../providers/doctorsProvider.dart';
import '../widget/DoctorCard.dart';

class DoctorsView extends StatefulWidget {
  const DoctorsView({super.key});

  @override
  State<DoctorsView> createState() => _DoctorsViewState();
}

class _DoctorsViewState extends State<DoctorsView> {
   @override
  void initState() {
    getDoctor();
    // TODO: implement initState
    super.initState();
  }

  List<Doctor>? doctors;

  getDoctor() async {
    // String cate = Provider.of<ArticlePrvider>(context, listen: false).category;

    String res =
        await Provider.of<DoctorsProvider>(context, listen: false).getDoctor(1);
              print(res);

    if (res == 'success') {
      // ignore: use_build_context_synchronously
      doctors = Provider.of<DoctorsProvider>(context, listen: false).doctors;
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDoctor()))
      },
      child: Text('إضافة'),),
      appBar: AppBar(
      
          toolbarHeight: 50.sp,
          backgroundColor: HakimColors.hakimPrimaryColor,
          title: const Text('ألاطباء')

          //  Text(
          //   'الحكيم',
          //   style: GoogleFonts.tajawal(
          //       fontSize: 32.sp,
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold),
          // ),
          ),
      body:  doctors!=null?  Column(children: [
        SizedBox(height: 15.sp),
         Consumer(   builder: (context, doctorseProv, _) {



                    List<Widget> doctorsWidgets = [];

                    for (int i = 0; i < doctors!.length; i++) {
                      doctorsWidgets.add(DoctorCard(name: doctors![i].firstName! + ' ' +doctors![i].lastName!, image: doctors![i].photo!, icon: Icons.access_time_rounded, rank: doctors![i].rank!, category: doctors![i].category!));
                    }

                    return Column(
                      children: doctorsWidgets,
                    );
                  })]):Container(child: Center(child: CircularProgressIndicator()),),
    );
  }
}
