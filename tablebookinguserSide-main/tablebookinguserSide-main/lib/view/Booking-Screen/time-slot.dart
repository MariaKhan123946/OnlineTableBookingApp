//
// import 'package:flutter/material.dart';
//
// class TimeSlotsScreen extends StatefulWidget {
//   final Function(TimeOfDay, TimeOfDay) onTimeSlotSelected;
//
//   TimeSlotsScreen({required this.onTimeSlotSelected});
//
//   @override
//   _TimeSlotsScreenState createState() => _TimeSlotsScreenState();
// }
//
// class _TimeSlotsScreenState extends State<TimeSlotsScreen> {
//   final List<bool> availableSlots = [
//     true, true, true, true, false, true, true, false, false, true, true, true
//   ]; // Example availability data
//
//   int? _selectedSlotIndex;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal, // Set horizontal scroll direction
//         itemCount: availableSlots.length,
//         itemBuilder: (context, index) {
//           final hour = 16 + (index * 40 ~/ 60); // Calculate hour
//           final minute = (index * 40) % 60; // Calculate minute
//           final startTime = TimeOfDay(hour: hour, minute: minute);
//           final endTime = startTime.replacing(
//               hour: hour, minute: (minute + 40) % 60); // Adjust for hour change
//           final isAvailable = availableSlots[index];
//
//           return GestureDetector(
//             onTap: isAvailable
//                 ? () {
//               setState(() {
//                 _selectedSlotIndex = index;
//               });
//               widget.onTimeSlotSelected(startTime, endTime);
//             }
//                 : null,
//             child: Container(
//               margin: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: _selectedSlotIndex == index
//                     ? Colors.blue[100]
//                     : isAvailable
//                     ? Colors.green[100]
//                     : Colors.red[100],
//               ),
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${startTime.format(context)}\n${endTime.format(context)}',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 11.0,
//                     ),
//                   ),
//                   SizedBox(height: 4.0),
//                   isAvailable
//                       ? Text(
//                     'Available',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 11.0,
//                     ),
//                   )
//                       : Text(
//                     'Unavailable',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 9.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

///TODO:------------
///
///
import 'package:flutter/material.dart';

// class TimeSlotsScreen extends StatefulWidget {
//   final Function(TimeOfDay, TimeOfDay) onTimeSlotSelected;
//   final String mealType;
//
//   TimeSlotsScreen({
//     required this.onTimeSlotSelected,
//     required this.mealType,
//   });
//
//   @override
//   _TimeSlotsScreenState createState() => _TimeSlotsScreenState();
// }
//
// class _TimeSlotsScreenState extends State<TimeSlotsScreen> {
//   final Map<String, List<bool>> availableSlots = {
//     'Breakfast': [true, true, false, true, true, false, true, true],
//     'Lunch': [false, true, true, true, true, true, true, true],
//     'Dinner': [true, true, true, false, true, false, true, true],
//   };
//
//   int? _selectedSlotIndex;
//
//   List<bool> getSlotsByMealType(String mealType) {
//     return availableSlots[mealType] ?? [];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<bool> slots = getSlotsByMealType(widget.mealType);
//
//     return Container(
//       height: 120,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: slots.length,
//         itemBuilder: (context, index) {
//           final hour = 16 + (index * 40 ~/ 60);
//           final minute = (index * 40) % 60;
//           final startTime = TimeOfDay(hour: hour, minute: minute);
//           final endTime = startTime.replacing(hour: hour, minute: (minute + 40) % 60);
//           final isAvailable = slots[index];
//
//           return GestureDetector(
//             onTap: isAvailable
//                 ? () {
//               setState(() {
//                 _selectedSlotIndex = index;
//               });
//               widget.onTimeSlotSelected(startTime, endTime);
//             }
//                 : null,
//             child: Container(
//               margin: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: _selectedSlotIndex == index
//                     ? Colors.blue[100]
//                     : isAvailable
//                     ? Colors.green[100]
//                     : Colors.red[100],
//               ),
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${startTime.format(context)} - ${endTime.format(context)}',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 11.0,
//                     ),
//                   ),
//                   SizedBox(height: 4.0),
//                   isAvailable
//                       ? Text(
//                     'Available',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 11.0,
//                     ),
//                   )
//                       : Text(
//                     'Unavailable',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 9.0,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


///TODO:---------------
///
///
///
///
///
///
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSlotsScreen extends StatefulWidget {
  final Function(TimeOfDay, TimeOfDay) onTimeSlotSelected;
  final String mealType;

  TimeSlotsScreen({
    required this.onTimeSlotSelected,
    required this.mealType,
  });

  @override
  _TimeSlotsScreenState createState() => _TimeSlotsScreenState();
}

class _TimeSlotsScreenState extends State<TimeSlotsScreen> {
  // Define available time slots for each meal type
  final Map<String, List<Map<String, String>>> availableSlots = {
    'Breakfast': [
      {'start': '7:00 AM', 'end': '8:00 AM'},
      {'start': '8:15 AM', 'end': '9:15 AM'},
      {'start': '9:30 AM', 'end': '10:30 AM'},
    ],
    'Lunch': [
      {'start': '12:00 PM', 'end': '1:00 PM'},
      {'start': '1:15 PM', 'end': '2:15 PM'},
      {'start': '2:30 PM', 'end': '3:30 PM'},
      {'start': '3:45 PM', 'end': '4:45 PM'},
    ],
    'Dinner': [
      {'start': '6:00 PM', 'end': '7:00 PM'},
      {'start': '7:15 PM', 'end': '8:15 PM'},
      {'start': '8:30 PM', 'end': '9:30 PM'},
      {'start': '9:45 PM', 'end': '10:45 PM'},
    ],
  };

  int? _selectedSlotIndex;

  List<Map<String, String>> getSlotsByMealType(String mealType) {
    return availableSlots[mealType] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> slots = getSlotsByMealType(widget.mealType);

    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: slots.length,
        itemBuilder: (context, index) {
          final startTime = TimeOfDay.fromDateTime(
              DateFormat('h:mm a').parse(slots[index]['start']!));
          final endTime = TimeOfDay.fromDateTime(
              DateFormat('h:mm a').parse(slots[index]['end']!));
          final isAvailable = true; // You can implement availability logic here

          return GestureDetector(
            onTap: isAvailable
                ? () {
              setState(() {
                _selectedSlotIndex = index;
              });
              widget.onTimeSlotSelected(startTime, endTime);
            }
                : null,
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                color: _selectedSlotIndex == index
                    ? Colors.blue[100]
                    : isAvailable
                    ? Colors.green[100]
                    : Colors.red[100],
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${slots[index]['start']} \n${slots[index]['end']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  isAvailable
                      ? Text(
                    'Available',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                    ),
                  )
                      : Text(
                    'Unavailable',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 9.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
