import 'package:flutter/material.dart';
import 'package:ui/widgets/tables-screen-widgets/cntaner.dart';
class prc extends StatefulWidget {
  const prc({super.key});

  @override
  State<prc> createState() => _prcState();
}

class _prcState extends State<prc> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
          //Scaffold(
    //body:
    graphscreen(),
      SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [
                      rotatedcontainer1(
                        containercolor: const Color(0xff7762ad),
                        bordercolor: const Color.fromARGB(255, 198, 183, 229),
                        text: "Jason",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      rotatedcontainer1(
                        containercolor:
                        const Color.fromARGB(255, 208, 152, 119),
                        bordercolor: const Color.fromARGB(255, 224, 195, 163),
                        text: "charles",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      smallcircle(
                        containercolorr:
                        const Color.fromARGB(255, 184, 199, 71),
                        bordercolor: const Color.fromARGB(255, 199, 214, 138),
                        tableno: "3",
                        text: "Emily",
                      ),
                      smallcircle(
                        containercolorr: const Color.fromARGB(255, 97, 71, 199),
                        bordercolor: const Color.fromARGB(255, 162, 134, 215),
                        tableno: "4",
                        text: "Eric",
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      Circle3(
                        containercolorr:
                        const Color.fromARGB(255, 169, 61, 169),
                        bordercolor: const Color.fromARGB(255, 187, 137, 174),
                        tableNo: "5",
                        text: "charlies",
                      ),
                      Circle3(
                        containercolorr: const Color.fromARGB(255, 52, 158, 79),
                        bordercolor: const Color.fromARGB(255, 131, 169, 138),
                        tableNo: "6",
                        text: "Jin",
                      ),
                      Circle3(
                        containercolorr: const Color.fromARGB(255, 214, 64, 56),
                        bordercolor: const Color.fromARGB(255, 187, 109, 109),
                        tableNo: "7",
                        text: "Milla",
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      rotatedcontainer1(
                        containercolor: const Color(0xff7762ad),
                        bordercolor: const Color.fromARGB(255, 198, 183, 229),
                        text: "Roslyn",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      rotatedcontainer1(
                        containercolor:
                        const Color.fromARGB(255, 218, 152, 113),
                        bordercolor: const Color.fromARGB(255, 212, 181, 147),
                        text: "Viki",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      smallcircle(
                        containercolorr:
                        const Color.fromARGB(255, 181, 105, 204),
                        bordercolor: const Color.fromARGB(255, 227, 148, 227),
                        tableno: "10",
                        text: "Varun",
                      ),
                      smallcircle(
                          containercolorr:
                          const Color.fromARGB(255, 129, 109, 211),
                          bordercolor: const Color.fromARGB(255, 179, 155, 223),
                          tableno: "11",
                          text: "Darren"),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      rotatedcontainer1(
                        containercolor: const Color(0xff7762ad),
                        bordercolor: const Color.fromARGB(255, 198, 183, 229),
                        text: "Jason",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      rotatedcontainer1(
                        containercolor:
                        const Color.fromARGB(255, 208, 152, 119),
                        bordercolor: const Color.fromARGB(255, 224, 195, 163),
                        text: "charles",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      smallcircle(
                        containercolorr:
                        const Color.fromARGB(255, 184, 199, 71),
                        bordercolor: const Color.fromARGB(255, 199, 214, 138),
                        tableno: "3",
                        text: "Emily",
                      ),
                      smallcircle(
                        containercolorr: const Color.fromARGB(255, 97, 71, 199),
                        bordercolor: const Color.fromARGB(255, 162, 134, 215),
                        tableno: "4",
                        text: "Eric",
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      Circle3(
                        containercolorr:
                        const Color.fromARGB(255, 169, 61, 169),
                        bordercolor: const Color.fromARGB(255, 187, 137, 174),
                        tableNo: "5",
                        text: "charlies",
                      ),
                      Circle3(
                        containercolorr: const Color.fromARGB(255, 52, 158, 79),
                        bordercolor: const Color.fromARGB(255, 131, 169, 138),
                        tableNo: "6",
                        text: "Jin",
                      ),
                      Circle3(
                        containercolorr: const Color.fromARGB(255, 214, 64, 56),
                        bordercolor: const Color.fromARGB(255, 187, 109, 109),
                        tableNo: "7",
                        text: "Milla",
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      rotatedcontainer1(
                        containercolor: const Color(0xff7762ad),
                        bordercolor: const Color.fromARGB(255, 198, 183, 229),
                        text: "Roslyn",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      rotatedcontainer1(
                        containercolor:
                        const Color.fromARGB(255, 218, 152, 113),
                        bordercolor: const Color.fromARGB(255, 212, 181, 147),
                        text: "Viki",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      smallcircle(
                        containercolorr:
                        const Color.fromARGB(255, 181, 105, 204),
                        bordercolor: const Color.fromARGB(255, 227, 148, 227),
                        tableno: "10",
                        text: "Varun",
                      ),
                      smallcircle(
                          containercolorr:
                          const Color.fromARGB(255, 129, 109, 211),
                          bordercolor: const Color.fromARGB(255, 179, 155, 223),
                          tableno: "11",
                          text: "Darren"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    smallcircle(
                        bordercolor: const Color.fromARGB(255, 129, 109, 211),
                        text: "hina",
                        containercolorr:
                        const Color.fromARGB(255, 179, 155, 223),
                        tableno: "19"),
                    Container2(
                        containercolor: const Color(0xff0d2379),
                        bordercolor: const Color.fromARGB(255, 122, 145, 239),
                        tableno: "12",
                        text: "aimi"),
                    Container2(
                        containercolor: const Color(0xff36bfff),
                        bordercolor: const Color.fromARGB(255, 151, 214, 243),
                        tableno: "13",
                        text: "mishi"),
                    Container2(
                        containercolor: const Color(0xff36bfff),
                        bordercolor: const Color.fromARGB(255, 151, 214, 243),
                        tableno: "14",
                        text: "lishi"),
                    smallcircle(
                        bordercolor: const Color.fromARGB(255, 129, 109, 211),
                        text: "hina",
                        containercolorr:
                        const Color.fromARGB(255, 179, 155, 223),
                        tableno: "18"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    smallcircle(
                      containercolorr: const Color.fromARGB(255, 181, 105, 204),
                      bordercolor: const Color.fromARGB(255, 227, 148, 227),
                      tableno: "10",
                      text: "Varun",
                    ),
                    Container2(
                        containercolor: const Color.fromARGB(255, 26, 162, 78),
                        bordercolor: const Color.fromARGB(255, 122, 239, 147),
                        tableno: "15",
                        text: "jmi"),
                    Container2(
                        containercolor: const Color.fromARGB(255, 246, 48, 120),
                        bordercolor: const Color.fromARGB(255, 243, 151, 222),
                        tableno: "16",
                        text: "john"),
                    Container2(
                        containercolor: const Color.fromARGB(255, 255, 54, 232),
                        bordercolor: const Color.fromARGB(255, 197, 127, 214),
                        tableno: "17",
                        text: "stephen"),
                    smallcircle(
                      containercolorr: const Color.fromARGB(255, 181, 105, 204),
                      bordercolor: const Color.fromARGB(255, 227, 148, 227),
                      tableno: "10",
                      text: "Varun",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
        //  ),

        ]);
  }
}
