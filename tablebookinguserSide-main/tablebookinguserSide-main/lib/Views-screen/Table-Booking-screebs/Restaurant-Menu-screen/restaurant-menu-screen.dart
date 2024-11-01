
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//
// class RestaurantMenuScreen extends StatefulWidget {
//   final String docid;
//
//   RestaurantMenuScreen({super.key, required this.docid});
//
//   @override
//   State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
// }
//
// class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
//   List<Map<String, dynamic>> selectedMenuItems = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: FirebaseFirestore.instance
//           .collection('RestaurantDetails')
//           .doc(widget.docid)
//           .collection('Menu')
//           .get(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//           return Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                 icon: Icon(Icons.check),
//                 onPressed: () {
//                   Navigator.pop(context, selectedMenuItems);
//                 },
//               ),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 8.0,
//                   mainAxisSpacing: 8.0,
//                 ),
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   var dish = snapshot.data!.docs[index];
//                   bool isSelected = selectedMenuItems.any((item) => item['DishName'] == dish['DishName']);
//
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (isSelected) {
//                           selectedMenuItems.removeWhere((item) => item['DishName'] == dish['DishName']);
//                         } else {
//                           selectedMenuItems.add({
//                             'DishName': dish['DishName'],
//                             'Price': dish['Price'],
//                             'DishImagePath': dish['DishImagePath'],
//                           });
//                         }
//                       });
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: isSelected ? Colors.blue : Colors.black),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.all(2),
//                             width: double.infinity,
//                             height: 110,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Colors.red,
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(20),
//                               child: dish['DishImagePath'] != null
//                                   ? Image.network(
//                                 dish['DishImagePath'],
//                                 fit: BoxFit.cover,
//                               )
//                                   : null,
//                             ),
//                           ),
//                           Text(
//                             dish['DishName'] ?? 'No Name',
//                             style: TextStyle(fontSize: 15),
//                             maxLines: 3,
//                           ),
//                           Text('Price: \$${dish['Price'] ?? 'N/A'}'),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         } else {
//           return Center(
//             child: Text('No data available'),
//           );
//         }
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantMenuScreen extends StatefulWidget {
  final String docid;

  RestaurantMenuScreen({super.key, required this.docid});

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  List<Map<String, dynamic>> selectedMenuItems = [];

  void toggleMenuItem(Map<String, dynamic> dish) {
    bool isSelected = selectedMenuItems.any((item) => item['DishName'] == dish['DishName']);
    if (isSelected) {
      selectedMenuItems.removeWhere((item) => item['DishName'] == dish['DishName']);
    } else {
      selectedMenuItems.add(dish);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            Navigator.pop(context, selectedMenuItems);
          },
        ),
        title: Text('Select Menu Items'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('RestaurantDetails')
            .doc(widget.docid)
            .collection('Menu')
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 11.0,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var dish = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  bool isSelected = selectedMenuItems.any((item) => item['DishName'] == dish['DishName']);

                  return StatefulBuilder(
                    builder: (context, setState) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = !isSelected;
                            toggleMenuItem(dish);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: isSelected ? Colors.blue : Colors.black),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          height: 190,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.all(2),
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: dish['DishImagePath'] != null
                                      ? Image.network(
                                    dish['DishImagePath'],
                                    fit: BoxFit.cover,
                                  )
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  dish['DishName'] ?? 'No Name',
                                  style: TextStyle(fontSize: 15),
                                  maxLines: 3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('Price: \$${dish['Price'] ?? 'N/A'}'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}



