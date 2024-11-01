import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/Views-screen/Admin-home-Nav/nav-bar-screen.dart';
import 'package:ui/home.dart';

class TableBookedScreen extends StatefulWidget {
  const TableBookedScreen({super.key});

  @override
  State<TableBookedScreen> createState() => _TableBookedScreenState();
}

class _TableBookedScreenState extends State<TableBookedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Lunch'),
        Text('Date: 12/5/2024'),
        Text('Time: 4:00PM - 4:40PM'),
          ElevatedButton(onPressed: (){
            Get.offAll(()=>BottomNavBarFinal());
          }, child: Text('Home'))
      ],),),
    );
  }
}
