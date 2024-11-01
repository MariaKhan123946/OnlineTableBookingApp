import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/Views-screen/Table-Booking-screebs/booking-screen-home.dart';
import 'package:ui/view/map-screens/map-screen.dart';
import 'package:ui/widgets/my-button.dart';

class NavHomeScreen extends StatefulWidget {
  const NavHomeScreen({super.key});

  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;
  List<Widget> popularServices = [
    for (int i = 0; i < 3; i++) ...[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 80,
          width: 330,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              "Get Discount Upto 40%",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    ],
  ];

  Stream<QuerySnapshot>? restaurantStream;

  @override
  void initState() {
    super.initState();
    restaurantStream =
        FirebaseFirestore.instance.collection('RestaurantDetails').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 239, 239),
        body: Column(children: [
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: PageView.builder(
                  itemCount: popularServices.length,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return popularServices[index];
                  },
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                ),
              ),
              PageIndicator(
                length: popularServices.length,
                currentPage: _currentPage,
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: restaurantStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<QueryDocumentSnapshot> documents =
                      snapshot.data!.docs;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        final String title = doc['Restaurantname'];
                        final String location = doc['RestaurantLocation'];
                        final String imagePath = doc['ImagePath'];
                        final String docid = doc['UserId'];
                        final String latitude = doc['Latitude'];
                        final String longitude = doc['Longitude'];

                        return CustomListTile(
                            title: title,
                            location: location,
                            imagePath: imagePath,
                            docid: docid,
                            latitude: latitude,
                            longitude: longitude);
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ]));
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String location;
  String imagePath;
  String docid;
  final String latitude;
  final String longitude;

  CustomListTile({
    super.key,
    required this.title,
    required this.location,
    required this.imagePath,
    required this.docid,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => MapScreen(
                          docid: docid,
                          lat: latitude,
                          lng: longitude,
                        )));
          },
          contentPadding: const EdgeInsets.all(12),
          leading: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 1),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, size: 16),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  location,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: MyButton(
              text: 'Book',
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReservationDetails(
                              docid: docid,
                            )));
              }),
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int length;
  final int currentPage;

  const PageIndicator({
    super.key,
    required this.length,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Container(
          margin: EdgeInsets.only(top: 6, right: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage
                ? Colors.green
                : Colors.grey.withOpacity(0.5),
          ),
        );
      }),
    );
  }
}
