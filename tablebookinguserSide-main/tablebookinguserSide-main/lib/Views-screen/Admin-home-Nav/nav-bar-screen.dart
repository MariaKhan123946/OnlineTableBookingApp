import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/Views-screen/Admin-home-Nav/nav-home-screen.dart';
import 'package:ui/Views-screen/Authentication/signin.dart';
import 'package:ui/home.dart';

class BottomNavBarFinal extends StatefulWidget {
  const BottomNavBarFinal({super.key});

  @override
  _BottomNavBarFinalState createState() => _BottomNavBarFinalState();
}

class _BottomNavBarFinalState extends State<BottomNavBarFinal> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    NavHomeScreen(),
    UserBookingHistoryScreen(),
    // NavProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String userEmail = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserEmail();
  }

  getUserEmail() async {
    User? user = await FirebaseAuth.instance.currentUser;
    userEmail = user!.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 239, 239),
      appBar: CustomAppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                currentAccountPicture: CircleAvatar(
                  child: Icon(
                    Icons.restaurant_menu,
                    color: Colors.green,
                  ),
                  backgroundColor: Colors.white,
                ),
                accountName: Text(''),
                accountEmail: Text('Email:$userEmail')),
            ListTile(
              onTap: () => Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => BottomNavBarFinal())),
              leading: Icon(
                Icons.home,
                color: Colors.green,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.green),
              ),
            ),
            Divider(
              color: Colors.green.withOpacity(0.4),
            ),
            ListTile(
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => UserBookingHistoryScreen())),
              leading: Icon(
                Icons.history,
                color: Colors.green,
              ),
              title: Text(
                'History',
                style: TextStyle(color: Colors.green),
              ),
            ),
            Divider(
              color: Colors.green.withOpacity(0.4),
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Login_screen()));
              },
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.green,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(color: Colors.green),
              ),
            ),
            Divider(
              color: Colors.green.withOpacity(0.4),
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Profile',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class UserBookingHistoryScreen extends StatelessWidget {
  const UserBookingHistoryScreen({super.key});

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<List<Map<String, dynamic>>> getUserBookings(String userId) async {
    List<Map<String, dynamic>> bookings = [];

    // Fetch documents from OrderData collection where userId matches the current user
    QuerySnapshot orderDataSnapshot = await FirebaseFirestore.instance
        .collection('OrderData')
        .where('userId', isEqualTo: userId)
        .get();

    for (var doc in orderDataSnapshot.docs) {
      Map<String, dynamic> bookingData = doc.data() as Map<String, dynamic>;
      bookings.add(bookingData);
    }

    return bookings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History', style: TextStyle(color: Colors.green)),
        centerTitle: true,
      ),
      body: FutureBuilder<User?>(
        future: getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('User not logged in.'));
          }

          String userId = snapshot.data!.uid;

          return FutureBuilder<List<Map<String, dynamic>>>(
            future: getUserBookings(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error fetching data.'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data found.'));
              }

              List<Map<String, dynamic>> bookings = snapshot.data!;

              return ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> booking = bookings[index];
                  return ListTile(
                    title: Text(booking['mealType'] ?? 'Unknown Meal Type'),
                    subtitle: Text(
                        'Date: ${booking['date'] ?? 'Unknown Date'}\n'
                        'Time Slot: ${booking['timeSlot'] ?? 'Unknown Time Slot'}'),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
