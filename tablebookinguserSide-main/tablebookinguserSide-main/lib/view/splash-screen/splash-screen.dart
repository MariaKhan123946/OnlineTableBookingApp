import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/Views-screen/on-board/OnBoard.dart';
import 'package:ui/view/onboardingcontroller.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),()=>Get.to(OnboardingScreen(),transition: Transition.cupertino));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Image(image: AssetImage('assets/logo.png')),
              ),
            ),
            SizedBox(height: 30,),
            CupertinoActivityIndicator(color: Colors.deepOrange,radius: 30,)
          ],
        ),
      ),
    );
  }
}
