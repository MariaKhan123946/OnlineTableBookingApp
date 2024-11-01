import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/Views-screen/Table-Booking-screebs/Reviews/restauran-review-screen.dart';
import 'package:ui/Views-screen/Table-Booking-screebs/Restaurant-details-screen/restaurant-details-screen.dart';
import 'package:ui/Views-screen/Table-Booking-screebs/Restaurant-Menu-screen/restaurant-menu-screen.dart';
import 'package:ui/Views-screen/Table-Booking-screebs/book-tables-screen/table-booking-.dart';
import 'package:ui/constant/space_values.dart';
import 'package:ui/constant/text_style.dart';
import 'package:ui/view/Booking-Screen/time-slot.dart';
import 'dart:math';

import 'package:ui/widgets/tables-screen-widgets/cntaner.dart'; //

class ReservationDetails extends StatefulWidget {
  final String docid;

  ReservationDetails({Key? key, required this.docid}) : super(key: key);

  @override
  State<ReservationDetails> createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String imagePath = '';
  String restaurantLocation = '';
  String restaurantName = '';
  final DateTime currentDate = DateTime.now();
  String currentDay = '';
  String startTime = '';
  String endTime = '';
  bool isOpen = false;
  String day = '';
  bool isloading = true;
  String _selectedMeal = 'Lunch';
  List<Widget> tableWidgets = [];

  void fetchRestaurantDetails() async {
    try {
      DocumentSnapshot restaurantSnapshot = await FirebaseFirestore.instance
          .collection('RestaurantDetails')
          .doc(widget.docid)
          .get();

      if (restaurantSnapshot.exists && restaurantSnapshot.data() != null) {
        setState(() {
          imagePath = restaurantSnapshot['ImagePath'];
          restaurantLocation = restaurantSnapshot['RestaurantLocation'];
          restaurantName = restaurantSnapshot['Restaurantname'];
        });
      }

      // Get current day
      currentDay = DateFormat('EEEE').format(DateTime.now());

      // Fetch working hours for the current day
      DocumentSnapshot workingHoursSnapshot = await FirebaseFirestore.instance
          .collection('RestaurantDetails')
          .doc(widget.docid)
          .collection('WorkingHours')
          .doc(currentDay)
          .get();

      if (workingHoursSnapshot.exists && workingHoursSnapshot.data() != null) {
        setState(() {
          startTime = workingHoursSnapshot['startTime'];
          endTime = workingHoursSnapshot['endTime'];
          isOpen = workingHoursSnapshot['isOpen'];
          day = workingHoursSnapshot['day'];
          isloading = false;
        });
      }

      // Fetch tables information
      QuerySnapshot tablesSnapshot = await FirebaseFirestore.instance
          .collection('RestaurantDetails')
          .doc(widget.docid)
          .collection('Tables')
          .get();

      List<Widget> tempWidgets = [];
      for (var doc in tablesSnapshot.docs) {
        var tableType = doc['TableType'];
        var tableNo =
            doc.id; // Assuming the document ID represents the table number
        if (tableType == 'circle') {
          tempWidgets.add(smallcircle(
            containercolorr: const Color.fromARGB(255, 184, 199, 71),
            bordercolor: const Color.fromARGB(255, 199, 214, 138),
            tableno: tableNo,
            text: tableType,
          ));
        } else if (tableType == 'square') {
          tempWidgets.add(Circle3(
            containercolorr: const Color.fromARGB(255, 169, 61, 169),
            bordercolor: const Color.fromARGB(255, 187, 137, 174),
            tableNo: tableNo,
            text: tableType,
          ));
        } else if (tableType == 'rectangle') {
          tempWidgets.add(rotatedcontainer1(
            containercolor: const Color.fromARGB(255, 208, 152, 119),
            bordercolor: const Color.fromARGB(255, 224, 195, 163),
            text: tableType,
          ));
        }
      }
      // Shuffle the list of table widgets
      tempWidgets.shuffle(Random());

      setState(() {
        tableWidgets = tempWidgets;
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  // void fetchRestaurantDetails() async {
  //   try {
  //     DocumentSnapshot restaurantSnapshot = await FirebaseFirestore.instance
  //         .collection('RestaurantDetails')
  //         .doc(widget.docid)
  //         .get();
  //
  //     if (restaurantSnapshot.exists && restaurantSnapshot.data() != null) {
  //       setState(() {
  //         imagePath = restaurantSnapshot['ImagePath'];
  //         restaurantLocation = restaurantSnapshot['RestaurantLocation'];
  //         restaurantName = restaurantSnapshot['Restaurantname'];
  //       });
  //     }
  //
  //     // Get current day
  //     currentDay = DateFormat('EEEE').format(DateTime.now());
  //
  //     // Fetch working hours for the current day
  //     DocumentSnapshot workingHoursSnapshot = await FirebaseFirestore.instance
  //         .collection('RestaurantDetails')
  //         .doc(widget.docid)
  //         .collection('WorkingHours')
  //         .doc(currentDay)
  //         .get();
  //
  //     if (workingHoursSnapshot.exists && workingHoursSnapshot.data() != null) {
  //       setState(() {
  //         startTime = workingHoursSnapshot['startTime'];
  //         endTime = workingHoursSnapshot['endTime'];
  //         isOpen = workingHoursSnapshot['isOpen'];
  //         day = workingHoursSnapshot['day'];
  //         isloading = false;
  //       });
  //     }
  //
  //     // Fetch tables information
  //     QuerySnapshot tablesSnapshot = await FirebaseFirestore.instance
  //         .collection('RestaurantDetails')
  //         .doc(widget.docid)
  //         .collection('Tables')
  //         .get();
  //
  //     List<Widget> tempWidgets = [];
  //     for (var doc in tablesSnapshot.docs) {
  //       var tableType = doc['TableType'];
  //       if (tableType == 'circle') {
  //         tempWidgets.add(smallcircle(
  //           containercolorr: const Color.fromARGB(255, 184, 199, 71),
  //           bordercolor: const Color.fromARGB(255, 199, 214, 138),
  //           tableno: "3",
  //          text: tableType,
  //          // text: "Emily",
  //         ));
  //       } else if (tableType == 'square') {
  //         tempWidgets.add(Circle3(
  //           containercolorr: const Color.fromARGB(255, 169, 61, 169),
  //           bordercolor: const Color.fromARGB(255, 187, 137, 174),
  //           tableNo: "5",
  //           text: tableType,
  //           //text: "charlies",
  //         ));
  //       } else if (tableType == 'rectangle') {
  //         tempWidgets.add(rotatedcontainer1(
  //           containercolor: const Color.fromARGB(255, 208, 152, 119),
  //           bordercolor: const Color.fromARGB(255, 224, 195, 163),
  //          text: tableType,
  //           // text: "charles",
  //         ));
  //       }
  //     }
  //     // Shuffle the list of table widgets
  //     tempWidgets.shuffle(Random());
  //
  //     setState(() {
  //       tableWidgets = tempWidgets;
  //     });
  //   } catch (error) {
  //     print('Error fetching data: $error');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchRestaurantDetails();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child: TabBar(
                            controller: _tabController,
                            tabs: const [
                              Tab(text: 'Booking'),
                              //Tab(text: 'Menu'),
                              Tab(text: 'Review'),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: MediaQuery.of(context)
                              .size
                              .height, // 70% of screen height
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              //_bookingScreen(),
                              BookIngScreenWidget(
                                tableWidgets: tableWidgets,
                                docid: widget.docid,
                              ),
                              //RestaurantMenuScreen(docid: widget.docid),
                              ReviewShowScreen(docid: widget.docid),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close Bottom Sheet'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Details'),
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurantName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 2),

                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        SizedBox(width: 5),
                        Text(
                          restaurantLocation,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: h * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          imagePath,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    ListTile(
                      leading: const Icon(Icons.timer_outlined),
                      title: Text(
                        currentDay == day ? 'Open Today' : 'Close',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      subtitle: Text(
                        currentDay == day ? '$startTime - $endTime' : '',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.tour),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    RestaurantDetailScreen(docid: widget.docid),
                              ),
                            ),
                            child: Text('Visit the restaurant',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                      ],
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () => _showBottomSheet(context),
                      child: Text('Book Table'),
                    ),
                    //  SizedBox(height: 5),
                  ],
                ),
              ),
            ),
    );
  }

  DateTime now = DateTime.now();
  int _selectedNumber = 2;

  Widget _bookingScreen() {
    String formattedDate =
        DateFormat('EEE, MMM d, yyyy').format(DateTime.now());
    String formattedTime = DateFormat('h:mm a').format(DateTime.now());
    return SingleChildScrollView(
      child: Column(
        children: [
          const Divider(),
          // Current date show row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formattedDate,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              Text(
                formattedTime,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          const Divider(),
          // Party size
          Text(
            'Party Size',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [2, 4, 6, 8, 10, 12].map((number) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedNumber = number;
                  });
                },
                child: CircleAvatar(
                  backgroundColor:
                      _selectedNumber == number ? Colors.blue : Colors.grey,
                  child: Text(
                    number.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 5),
          const Divider(),
          // Time slot
          //TimeSlotsScreen(),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 14, // Spacing between columns
              mainAxisSpacing: 10, // Spacing between rows
            ),
            itemCount: tableWidgets.length,
            itemBuilder: (BuildContext context, int index) {
              return tableWidgets[index];
            },
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(formattedDate),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(formattedTime),
              ),
              const SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: DropdownButton<String>(
                    value: _selectedMeal,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedMeal = newValue!;
                      });
                    },
                    items: <String>['Breakfast', 'Lunch', 'Dinner']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Additional widgets can be added here
        ],
      ),
    );
  }
}
