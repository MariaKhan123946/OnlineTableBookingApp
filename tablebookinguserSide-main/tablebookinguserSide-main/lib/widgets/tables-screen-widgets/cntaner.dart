import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ui/widgets/tables-screen-widgets/timer.dart';

class graphscreen extends StatelessWidget {
  const graphscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: GridPaper(
        color: Colors.grey,
        divisions: 1,
        interval: 210,
        subdivisions: 4,
      ),
    );
  }
}

class rotatedcontainer1 extends StatelessWidget {
  String text;
  Color containercolor;
  Color bordercolor;
  // String tableno;
  rotatedcontainer1({
    super.key,
    required this.text,
    required this.bordercolor,
    required this.containercolor,
    // required this.tableno
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform.rotate(
          angle: 20 * 3.14159265359 / 180,
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: bordercolor,
              padding: const EdgeInsets.all(11),
              strokeWidth: 6,
              strokeCap: StrokeCap.round,
              dashPattern: const [24],
              borderPadding: const EdgeInsets.all(2),
              child: ClipRRect(
                child: Container(
                  width: 30,
                  height: 50,
                  decoration: BoxDecoration(
                    color: containercolor,
                  ),
                  child: CountdownTimerPage(
                    containerColor: containercolor,
                    containersize: 50,
                    containershape: BoxShape.rectangle,
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(171, 0, 0, 0),
            decoration: TextDecoration.none,
          ),
        )
      ],
    );
  }
}

class smallcircle extends StatelessWidget {
  String text;
  Color containercolorr;
  Color bordercolor;
  String tableno;
  smallcircle(
      {super.key,
      required this.bordercolor,
      required this.text,
      required this.containercolorr,
      required this.tableno});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: DottedBorder(
            borderType: BorderType.Circle,
            color: bordercolor,
            padding: EdgeInsets.all(12),
            strokeWidth: 6,
            strokeCap: StrokeCap.round,
            dashPattern: const [30, 25],
            borderPadding: const EdgeInsets.all(2),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: containercolorr,
                borderRadius: BorderRadius.circular(100)
              ),
              child: Center(
                child:Text(tableno)
                // CountdownTimerPage(
                //   containerColor: containercolorr,
                //   containersize: 80,
                //   containershape: BoxShape.circle,
                // ),
              ),
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(171, 0, 0, 0),
            decoration: TextDecoration.none,
          ),
        )
      ],
    );
  }
}

class Container2 extends StatelessWidget {
  Color containercolor;
  Color bordercolor;
  String text;
  String tableno;

  Container2({
    super.key,
    required this.containercolor,
    required this.bordercolor,
    required this.text,
    required this.tableno,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(20.0),
          child: DottedBorder(
            borderType: BorderType.RRect,
            color: bordercolor,
            padding: const EdgeInsets.all(11),
            strokeWidth: 8,
            strokeCap: StrokeCap.round,
            dashPattern: const [
              40,
              20,
            ],
            borderPadding: const EdgeInsets.all(2),
            child: ClipRRect(
              child: Container(
                height: 60,
                width: 55,
                color: containercolor,
                child: Center(
                  child: CountdownTimerPage(
                    containerColor: containercolor,
                    containersize: 80,
                    containershape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          )),
      Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(171, 0, 0, 0),
          decoration: TextDecoration.none,
        ),
      )
    ]);
  }
}

class Circle3 extends StatelessWidget {
  Color containercolorr;
  Color bordercolor;
  String text;
  String tableNo;
  Circle3(
      {super.key,
      required this.bordercolor,
      required this.containercolorr,
      required this.tableNo,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: DottedBorder(
              borderType: BorderType.Circle,
              color: bordercolor,
              padding: const EdgeInsets.all(11),
              strokeWidth: 6,
              strokeCap: StrokeCap.round,
              dashPattern: const [
                40,
                25,
              ],
              borderPadding: const EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: 100,
                  width: 80,
                  decoration: BoxDecoration(
                      color: containercolorr, shape: BoxShape.circle),
                  child: Center(
                    child: Text(tableNo)
                    // CountdownTimerPage(
                    //   containerColor: containercolorr,
                    //   containersize: 120,
                    //   containershape: BoxShape.circle,
                    // ),
                  ),
                ),
              )),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            decoration: TextDecoration.none,
          ),
        )
      ],
    );
  }
}
