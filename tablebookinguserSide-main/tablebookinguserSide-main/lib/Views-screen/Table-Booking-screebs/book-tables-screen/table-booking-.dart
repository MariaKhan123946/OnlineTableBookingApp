import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:ui/Views-screen/Table-Booking-screebs/Restaurant-Menu-screen/restaurant-menu-screen.dart';
import 'package:ui/view/Booking-Screen/time-slot.dart';
import 'package:ui/widgets/tables-screen-widgets/cntaner.dart';

class BookIngScreenWidget extends StatefulWidget {
  final List<Widget> tableWidgets;
  final String docid;

  BookIngScreenWidget({super.key, required this.tableWidgets, required this.docid});

  @override
  State<BookIngScreenWidget> createState() => _BookIngScreenWidgetState();
}
class _BookIngScreenWidgetState extends State<BookIngScreenWidget> {
  String formattedDate = DateFormat('EEE, MMM d, yyyy').format(DateTime.now());
  String formattedTime = DateFormat('h:mm a').format(DateTime.now());
  DateTime now = DateTime.now();
  int _selectedNumber = 2;
  String _selectedMeal = 'Lunch';
  DateTime _selectedDate = DateTime.now();
  String? _selectedTimeSlot;
  String? _selectedTable;
  String? _selectedTableType;
  bool _isLoading = false;
  List<Map<String, dynamic>> selectedMenuItems = [];
  List<Widget> tableWidgets = [];
  Map<String, int> bookedTableCount = {
    'circle': 0,
    'square': 0,
    'rectangle': 0,
  };

  @override
  void initState() {
    super.initState();
    fetchAvailableTables();
    fetchBookedTableCount();
  }

  Future<void> fetchAvailableTables() async {
    try {
      QuerySnapshot tablesSnapshot = await FirebaseFirestore.instance
          .collection('RestaurantDetails')
          .doc(widget.docid)
          .collection('Tables')
          .get();

      List<Widget> tempWidgets = [];
      for (var doc in tablesSnapshot.docs) {
        var tableType = doc['TableType'];
        var tableQuantity = doc['TableQuantity'];
        totaltableQuantity=int.parse(tableQuantity);
        var tableNo = doc.id;
        if (tableType == 'circle') {
          tempWidgets.add(smallcircle(
            containercolorr: const Color.fromARGB(255, 184, 199, 71),
            bordercolor: const Color.fromARGB(255, 199, 214, 138),
            tableno: tableQuantity,
            text: tableType,
          ));
        } else if (tableType == 'square') {
          tempWidgets.add(Circle3(
            containercolorr: const Color.fromARGB(255, 169, 61, 169),
            bordercolor: const Color.fromARGB(255, 187, 137, 174),
            tableNo: tableQuantity,
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

      tempWidgets.shuffle(Random());

      setState(() {
        tableWidgets = tempWidgets;
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> fetchBookedTableCount() async {
    if (_selectedTimeSlot == null) return;

    try {
      String datedocid = DateFormat('yyyy-MM-dd').format(_selectedDate);
      QuerySnapshot bookedTablesSnapshot = await FirebaseFirestore.instance
          .collection('RestaurantDetails')
          .doc(widget.docid)
          .collection('BookTable')
          .doc(datedocid)
          .collection(_selectedMeal)
          .where('timeSlot', isEqualTo: _selectedTimeSlot)
          .get();

      Map<String, int> tempBookedTableCount = {
        'circle': 0,
        'square': 0,
        'rectangle': 0,
      };

      for (var doc in bookedTablesSnapshot.docs) {
        var tableType = doc['tableType'];
        if (tempBookedTableCount.containsKey(tableType)) {
          tempBookedTableCount[tableType] = (tempBookedTableCount[tableType] ?? 0) + 1;
        }
      }

      setState(() {
        // Extract values into separate int variables
         circleTableCount = tempBookedTableCount['circle'] ?? 0;
         squareTableCount = tempBookedTableCount['square'] ?? 0;
         rectangleTableCount = tempBookedTableCount['rectangle'] ?? 0;

        print('Circle Tables Booked: $circleTableCount');
        print('Square Tables Booked: $squareTableCount');
        print('Rectangle Tables Booked: $rectangleTableCount');


        bookedTableCount = tempBookedTableCount;
      });
    } catch (error) {
      print('Error fetching booked table count: $error');
    }
  }
  int circleTableCount=0;
  int squareTableCount=0;
  int rectangleTableCount=0;
  int totaltableQuantity=0;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        formattedDate = DateFormat('EEE, MMM d, yyyy').format(pickedDate);
      });
      fetchAvailableTables();
      fetchBookedTableCount();
    }
  }

  Future<void> _selectMenu(BuildContext context) async {
    final List<Map<String, dynamic>>? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantMenuScreen(docid: widget.docid),
      ),
    );

    if (result != null) {
      setState(() {
        selectedMenuItems = result;
      });
      DefaultTabController.of(context)?.animateTo(0);
    }
  }
  void _submitBooking() async {
  if (_selectedTimeSlot == null || _selectedTable == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please select a time slot and a table.')),
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    String datedocid = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    if (userId == null) {
      throw Exception('User not logged in');
    }

    var mealCollectionRef = FirebaseFirestore.instance
        .collection('RestaurantDetails')
        .doc(widget.docid)
        .collection('BookTable')
        .doc(datedocid)
        .collection(_selectedMeal);

    QuerySnapshot querySnapshot = await mealCollectionRef
        .orderBy('orderno', descending: true)
        .limit(1)
        .get();

    int nextOrderNo = 1;

    if (querySnapshot.docs.isNotEmpty) {
      var lastDoc = querySnapshot.docs.first.data() as Map<String, dynamic>;
      if (lastDoc.containsKey('orderno')) {
        nextOrderNo = int.parse(lastDoc['orderno']) + 1;
      }
    }

    String formattedOrderNo = nextOrderNo.toString().padLeft(3, '0');

    // Save data in the BookTable collection
    await mealCollectionRef.doc(formattedOrderNo).set({
      'orderno': formattedOrderNo,
      'date': datedocid,
      'mealType': _selectedMeal,
      'partySize': _selectedNumber,
      'timeSlot': _selectedTimeSlot,
      'table': _selectedTable,
      'tableType': _selectedTableType,
      'userId': userId,
      'menuItems': selectedMenuItems,
    });

    // Save data in the OrderData collection
    await FirebaseFirestore.instance.collection('OrderData').add({
      'date': datedocid,
      'mealType': _selectedMeal,
      'menuItems': selectedMenuItems.asMap().entries.map((entry) {
        return {
          'index': entry.key,
          'item': entry.value,
        };
      }).toList(),
      'orderno': formattedOrderNo,
      'partySize': _selectedNumber,
      'restaurantId': widget.docid,
      'receivingid': widget.docid,
      'table': _selectedTable,
      'tableType': _selectedTableType,
      'timeSlot': _selectedTimeSlot,
      'userId': userId,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking successfully added!')),
    );

    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to add booking: $e')),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  // void _submitBooking() async {
  //   if (_selectedTimeSlot == null || _selectedTable == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please select a time slot and a table.')),
  //     );
  //     return;
  //   }

  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     String datedocid = DateFormat('yyyy-MM-dd').format(_selectedDate);
  //     final user = FirebaseAuth.instance.currentUser;
  //     final userId = user?.uid;

  //     if (userId == null) {
  //       throw Exception('User not logged in');
  //     }

  //     var mealCollectionRef = FirebaseFirestore.instance
  //         .collection('RestaurantDetails')
  //         .doc(widget.docid)
  //         .collection('BookTable')
  //         .doc(datedocid)
  //         .collection(_selectedMeal);

  //     QuerySnapshot querySnapshot = await mealCollectionRef
  //         .orderBy('orderno', descending: true)
  //         .limit(1)
  //         .get();

  //     int nextOrderNo = 1;

  //     if (querySnapshot.docs.isNotEmpty) {
  //       var lastDoc = querySnapshot.docs.first.data() as Map<String, dynamic>;
  //       if (lastDoc.containsKey('orderno')) {
  //         nextOrderNo = int.parse(lastDoc['orderno']) + 1;
  //       }
  //     }

  //     String formattedOrderNo = nextOrderNo.toString().padLeft(3, '0');

  //     await mealCollectionRef.doc(formattedOrderNo).set({
  //       'orderno': formattedOrderNo,
  //       'date': datedocid,
  //       'mealType': _selectedMeal,
  //       'partySize': _selectedNumber,
  //       'timeSlot': _selectedTimeSlot,
  //       'table': _selectedTable,
  //       'tableType': _selectedTableType,
  //       'userId': userId,
  //       'menuItems': selectedMenuItems,
  //     });

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Booking successfully added!')),
  //     );

  //     Navigator.pop(context);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to add booking: $e')),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
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

            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
                Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
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
                          fetchAvailableTables();
                          fetchBookedTableCount();
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
            SizedBox(height: 10),
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
                    backgroundColor: _selectedNumber == number ? Colors.blue : Colors.grey,
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
            TimeSlotsScreen(
              mealType: _selectedMeal,
              onTimeSlotSelected: (startTime, endTime) {
                setState(() {
                  _selectedTimeSlot = '${startTime.format(context)} - ${endTime.format(context)}';
                  fetchBookedTableCount();
                });
              },
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 10,
              ),
              itemCount: tableWidgets.length,
              itemBuilder: (BuildContext context, int index) {
                print(index);
                Widget currentWidget = tableWidgets[index];
                String tableType = (currentWidget as dynamic).text; // Assuming `text` holds the table type
                bool isAvailable = true;

                if (tableType == 'circle' && circleTableCount >=totaltableQuantity ) {
                  isAvailable = false;
                } else if (tableType == 'square' && squareTableCount >= totaltableQuantity) {
                  isAvailable = false;
                } else if (tableType == 'rectangle' && rectangleTableCount >= totaltableQuantity) {
                  isAvailable = false;
                }

                return GestureDetector(
                  onTap: isAvailable
                      ? () {
                    setState(() {
                      _selectedTable = 'Table $index';
                      _selectedTableType = tableType;
                    });
                  }
                      : null,
                  child: isAvailable
                      ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedTable == 'Table $index'
                            ? Colors.blue
                            : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: currentWidget),
                  )
                      : Center(child: Text('Not Available')),
                );
                },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectMenu(context),
              child: Text('Select Menu Items'),
            ),
            const SizedBox(height: 10),
            selectedMenuItems.isNotEmpty
                ? Column(
              children: selectedMenuItems.map((item) {
                return ListTile(
                  leading: item['DishImagePath'] != null
                      ? Image.network(item['DishImagePath'])
                      : null,
                  title: Text(item['DishName']),
                  subtitle: Text('Price: \$${item['Price']}'),
                );
              }).toList(),
            )
                : Text('No menu items selected'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitBooking,
              child: _isLoading ? CircularProgressIndicator() : Text('Submit Booking'),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
class BookedTablesScreen extends StatefulWidget {
  final String docid;

  BookedTablesScreen({required this.docid});

  @override
  _BookedTablesScreenState createState() => _BookedTablesScreenState();
}

class _BookedTablesScreenState extends State<BookedTablesScreen> {
  List<Map<String, dynamic>> bookedTables = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookedTables();
  }

  Future<void> fetchBookedTables() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;

      if (userId == null) {
        throw Exception('User not logged in');
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('RestaurantDetails')
          .doc(widget.docid)
          .collection('BookTable')
          .where('userId', isEqualTo: userId)
          .get();

      List<Map<String, dynamic>> tempBookedTables = [];
      for (var doc in querySnapshot.docs) {
        tempBookedTables.add(doc.data() as Map<String, dynamic>);
      }

      setState(() {
        bookedTables = tempBookedTables;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching booked tables: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Booked Tables'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : bookedTables.isEmpty
          ? Center(child: Text('No booked tables found.'))
          : ListView.builder(
        itemCount: bookedTables.length,
        itemBuilder: (context, index) {
          var booking = bookedTables[index];
          String date = booking['date'];
          String mealType = booking['mealType'];
          String timeSlot = booking['timeSlot'];
          String table = booking['table'];
          String tableType = booking['tableType'];
          List<dynamic> menuItems = booking['menuItems'];

          return Card(
            child: ListTile(
              title: Text('Table: $table ($tableType)'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: $date'),
                  Text('Meal: $mealType'),
                  Text('Time Slot: $timeSlot'),
                  Text('Menu Items:'),
                  ...menuItems.map((item) => Text(item['DishName'])).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
