import 'package:flutter/material.dart';
import 'package:hakim_dash/screens/addScreens/AddDoctorSc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/Doctor.dart';
import '../../providers/doctorsProvider.dart';
import '../widget/DoctorCard.dart';
import '../widget/apppBar.dart';
import '../widget/hakimLoadingIndicator.dart';

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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddDoctor()))
        },
        child: Text('إضافة'),
      ),
      appBar: ReusableWidgets.getAppBar('الاطباء', true, context),
      body: doctors != null
          ? Column(children: [
              SizedBox(height: 15.sp),
              Consumer<DoctorsProvider>(builder: (context, doctorseProv, _) {
                List<Widget> doctorsWidgets = [];

                for (int i = 0; i < doctorseProv.doctors!.length; i++) {
                  doctorsWidgets.add(DoctorCard(
                      icon: Icons.access_time_rounded,
                    doctor:doctorseProv.doctors![i] ,));
                }

                return Column(
                  children: doctorsWidgets,
                );
              })
            ])
          : Container(
              child: HaLoadingIndicator(),
            ),
    );
  }
}
