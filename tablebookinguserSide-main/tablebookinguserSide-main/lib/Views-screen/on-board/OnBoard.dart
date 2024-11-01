import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ui/Views-screen/Authentication/signin.dart';
import 'package:ui/widgets/my-button.dart';
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String on1='assets/onboarding1.png';
  String on2='assets/onboarding1.png';
  String on3='assets/onboarding1.png';
  ///-------------------------
  void initState()
  {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Padding(
      //   padding: const EdgeInsets.only(left: 0.0),
      //   child: TextButton(onPressed: (){},child: Text('Skip'),),
      // )),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity! > 0) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              } else if (details.primaryVelocity! < 0) {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              }
            },
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                OnboardingPage(
                  image: on1,
                  text: 'Smart Scanning\nOur intelligent algorithm enables you to smartly scan nearby restaurants according to your liking',
                ),

                OnboardingPage(
                  image: on2,
                  text:'Smart Scanning\nOur intelligent algorithm enables you to smartly scan nearby restaurants according to your liking',
                ),
                OnboardingPage(
                  isLastPage: true,
                  image: on3,
                  text:'Smart Scanning\nOur intelligent algorithm enables you to smartly scan nearby restaurants according to your liking',
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: _currentPage < 2
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: (){
                Get.offAll(()=>Login_screen());
              },child: Text('Skip'),).paddingOnly(left: 20),

              FloatingActionButton(
                      onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
                      },
                      child: Icon(Icons.navigate_next,color: Colors.white,),
                      backgroundColor: Colors.blue.shade700,
                    ),
            ],
          )
          : null,
    );
  }
}
User? user;
class OnboardingPage extends StatelessWidget {
  final String image;
  final String text;
  final bool isLastPage;

  const OnboardingPage({
    required this.image,
    required this.text,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          SizedBox(height: 170,),
          Image.asset(
            image,
            height: 200,
          ),
          SizedBox(height: 20),
          Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],),

        if (isLastPage)
          OrangeButton(backcolor: Colors.blue.shade700,text: 'Get Started',width: 150, onPress: (){
            Get.offAll(()=>Login_screen());
            // Get.offAll(()=>NewSelectionScreen(),transition: Transition.downToUp,duration: Duration(milliseconds: 500));
          }),
        // ElevatedButton(
        //   onPressed: () {
        //     // Add your logic for the "Get Started" button here
        //     print('Get Started button pressed');
        //   },
        //   child: Text('Get Started'),
        // ),
        SizedBox(height: 0),
      ],
    );
  }
}
