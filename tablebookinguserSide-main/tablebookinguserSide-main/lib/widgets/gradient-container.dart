import 'package:flutter/material.dart';


class GradientContainer extends StatelessWidget {
  Widget widget;
   GradientContainer({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Container(
      width: w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.green[200]!,
            Colors.green[500]!,
            Colors.green[400]!,
            Colors.green[500]!,
          ],
        ),
      ),
      child: widget,
      // You can customize the size of the container as per your requirement
    );
  }
}




