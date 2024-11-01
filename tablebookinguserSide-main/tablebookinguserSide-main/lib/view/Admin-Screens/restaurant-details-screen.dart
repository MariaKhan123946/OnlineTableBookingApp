import 'package:flutter/material.dart';
import 'package:ui/widgets/gradient-container.dart';
import 'package:ui/widgets/text-widget.dart';

class EnterRestauranDetails extends StatefulWidget {
String cityname;
String streetAddress;
   EnterRestauranDetails({super.key, required this.cityname, required this.streetAddress});

  @override
  State<EnterRestauranDetails> createState() => _EnterRestauranDetailsState();
}

class _EnterRestauranDetailsState extends State<EnterRestauranDetails> {
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: GradientContainer(
                  widget: Center(
                child:
                Container(
                  height: h*0.3,
                  width: w*0.8,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Icon(Icons.location_on_outlined,size: 50,color: Colors.green,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(widget.cityname),
                        Text(widget.streetAddress),
                      ],),
                    ],
                  ),
                ),
              ))),
          Expanded(flex: 4, child: Container(
            child: Column(children: [
              MyTextWidget(label: 'Enter Restaurant Name',hint: 'Restaurant Name',),
              MyTextWidget(label: 'Enter Restaurant Phone',hint: 'Restaurant Phone',),
            ],),
          ))
        ],
      ),
    );
  }
}
