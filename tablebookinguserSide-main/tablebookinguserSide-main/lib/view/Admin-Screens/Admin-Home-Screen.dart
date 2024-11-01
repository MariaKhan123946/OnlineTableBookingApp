import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/home.dart';
import 'package:ui/view/Admin-Screens/add-restaurant-screen.dart';
import 'package:ui/view/map-screens/map-screen.dart';
import 'package:ui/widgets/my-button.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Registered Restaurants:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  5, // Replace with actual count of registered restaurants
              itemBuilder: (context, index) {
                return SizedBox(); //CustomListTile(title: 'Restaurant Name $index', location: 'Location $index',imagePath: index.toString(), );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddRestaurantPage());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
/////----

class RestaurantDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Details'),
      ),
      body: Center(
        child: Text('Details of the selected restaurant'),
      ),
    );
  }
}
