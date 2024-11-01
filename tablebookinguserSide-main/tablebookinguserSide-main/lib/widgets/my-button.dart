import 'package:flutter/material.dart';

class OrangeButton extends StatelessWidget {
  double height;
  double width;
  String text;
  VoidCallback onPress;
  Color backcolor;
  Color textcolor;
  OrangeButton({super.key,this.textcolor=Colors.white,this.backcolor=Colors.lightBlue,//Colors.lightBlue.withOpacity(0.7),
    this.height=40,this.width=100,required this.text,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child:
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(color: textcolor, fontWeight: FontWeight.w700,fontSize: 19,fontFamily: 'Raleway'),
              ),
              Icon(Icons.navigate_next,color: Colors.white,size: 30,)
            ],
          ),
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: backcolor,//purpleAccent.shade100.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
        ));



  }
}



class MyButton extends StatelessWidget {
  double height;
  double width;
  String text;
  VoidCallback onPress;
  Color backcolor;
  Color textcolor;
  MyButton({super.key,this.textcolor=Colors.white,this.backcolor=Colors.green,//Colors.lightBlue.withOpacity(0.7),
    this.height=35,this.width=80,required this.text,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Container(
          child: Center(
              child: Text(
                text,
                style: TextStyle(color: textcolor, fontWeight: FontWeight.w500,fontSize: 15,fontFamily: 'Raleway'),
              )),
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: backcolor,//purpleAccent.shade100.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
        ));
  }
}
