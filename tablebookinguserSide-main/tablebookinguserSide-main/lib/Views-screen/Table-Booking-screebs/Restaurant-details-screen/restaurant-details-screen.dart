import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String docid;

  RestaurantDetailScreen({super.key, required this.docid});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  Map<String, dynamic>? restaurantData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRestaurantData();
  }

  Future<void> fetchRestaurantData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('RestaurantDetails').doc(widget.docid).get();
      if (doc.exists) {
        setState(() {
          restaurantData = doc.data() as Map<String, dynamic>;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    return
      Scaffold(

      body:
      isLoading
          ? Center(child: CircularProgressIndicator())
          : restaurantData == null
          ? Center(child: Text('No data found'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (restaurantData!['ImagePath'] != null)
                Image.network(restaurantData!['ImagePath']),
              SizedBox(height: 16),
              Text(
                restaurantData!['Restaurantname'] ?? 'No name provided',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Restaurant About: ${restaurantData!['RestaurantAbout']}' ?? 'No description provided',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Location: ${restaurantData!['RestaurantLocation'] ?? 'No location provided'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Phone: ${restaurantData!['RestaurantPhoneNo'] ?? 'No phone number provided'}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
