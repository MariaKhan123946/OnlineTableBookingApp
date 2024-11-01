import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui/Views-screen/Table-Booking-screebs/Reviews/add-reviews-screen.dart';

class ReviewShowScreen extends StatefulWidget {
  final String docid;
  ReviewShowScreen({super.key, required this.docid});

  @override
  State<ReviewShowScreen> createState() => _ReviewShowScreenState();
}

class _ReviewShowScreenState extends State<ReviewShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Reviews'),
      // ),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('RestaurantDetails')
            .doc(widget.docid)
            .collection('Reviews')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No reviews yet.'));
          }

          final reviews = snapshot.data!.docs.map((doc) {
            return {
              "name": doc['name'],
              "rating": doc['rating'],
              "review": doc['review'],
            };
          }).toList();

          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return ListTile(
                // leading: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: List.generate(5, (starIndex) {
                //     return Icon(
                //       starIndex < reviews[index]["rating"]
                //           ? Icons.star
                //           : Icons.star_border,
                //       color: Colors.yellow,
                //     );
                //   }),
                // ),
                title: Text(reviews[index]["name"]),
                subtitle: Text(reviews[index]["review"]),
                trailing: Text(reviews[index]["rating"].toString()),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReviewScreen(docid: widget.docid),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
