import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ui/Views-screen/Authentication/signup.dart';
import 'package:ui/constant/text_style.dart';
import 'package:ui/view/on-boarding-screens/onboarding3.dart';

import '../../constant/space_values.dart';

class OnBoardingScreen2 extends StatelessWidget {
  const OnBoardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/onboarding1.png'),
            Spaces.y2,
            Text(
              ' Smart Scanning',
              style: CustomFontStyle.fnt20ClrBWtB,
            ),
            Spaces.y1,
            Text(
              'Our intelligent algorithm enables you to smartly scan nearby restaurants according to your liking',
              style: CustomFontStyle.font12ClrBlk,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Signup_screen()));
              },
              child: Text(
                "Skip",
                style: CustomFontStyle.font12ClrBlk,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                );
              }),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnBoardingScreen3()));
              },
              icon: Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }
}
