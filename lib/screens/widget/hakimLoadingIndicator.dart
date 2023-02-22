import 'package:flutter/material.dart';
import 'package:hakim_dash/consts/HakimColors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class HaLoadingIndicator extends StatelessWidget {
  const HaLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: HakimColors.hakimPrimaryColor,
        size: 50,
      ),);
  }
}