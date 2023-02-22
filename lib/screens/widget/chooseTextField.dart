
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/HakimColors.dart';

import 'package:sizer/sizer.dart';


class ChooseTextFieldW extends StatelessWidget {
  const ChooseTextFieldW({
    Key? key,
    required this.list,
    required this.title,
    required this.valueX,
  }) : super(key: key);

  final List<String> list;
  final String title;
  final TextEditingController valueX;

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
                  color: const Color(0xff707070),
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
                valueX.text = value.toString();

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
