import 'package:flutter/material.dart';
import 'package:ui/view/on-boarding-screens/onboarding1.dart';
import 'package:ui/view/on-boarding-screens/onboarding2.dart';
import 'package:ui/view/on-boarding-screens/onboarding3.dart';

class onboardingcontroller extends StatefulWidget {
  const onboardingcontroller({super.key});

  @override
  State<onboardingcontroller> createState() => _onboardingcontrollerState();
}

class _onboardingcontrollerState extends State<onboardingcontroller> {
  var screens = [OnBoardingScreen1(), OnBoardingScreen2(), OnBoardingScreen3()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            itemCount: screens.length,
            itemBuilder: ((context, index) => screens[index])));
  }
}
