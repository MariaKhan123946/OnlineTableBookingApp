import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui/Views-screen/Authentication/signin.dart';
import 'package:ui/constant/space_values.dart';
import 'package:ui/constant/text_style.dart';
import 'package:ui/home.dart';

class NavProfile extends StatefulWidget {
  const NavProfile({Key? key});

  @override
  State<NavProfile> createState() => _NavProfileState();
}

class _NavProfileState extends State<NavProfile> {
  String? userName;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  void fetchUserName() async {
    // Get current user ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    // Query UserData collection in Firestore
    if (userId != null) {
      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('UserData')
          .doc(userId)
          .get();

      // Check if document exists and has the 'name' field
      if (userDataSnapshot.exists && userDataSnapshot.data() != null) {
        setState(() {
          // Set userName to the 'name' field value
          userName = userDataSnapshot['name'];
        });
      }
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login_screen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(
                  userName ?? 'Loading...', // Display userName or 'Loading...'
                  style: CustomFontStyle.font12ClrFntWtBldBlk,
                ),
                leading: CircleAvatar(),
                trailing: CircleAvatar(
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.notifications)),
                ),
              ),
            ),
            Spaces.y2,
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(
                  "Account Setting",
                  style: CustomFontStyle.font12ClrBlk,
                ),
                leading: const Icon(CupertinoIcons.profile_circled),
                trailing: CircleAvatar(
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.edit)),
                ),
              ),
            ),
            Spaces.y2,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Language",
                      style: CustomFontStyle.font12ClrBlk,
                    ),
                    leading: const Icon(CupertinoIcons.conversation_bubble),
                    trailing: CircleAvatar(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios)),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Feedback",
                      style: CustomFontStyle.font12ClrBlk,
                    ),
                    leading: const Icon(CupertinoIcons.conversation_bubble),
                    trailing: CircleAvatar(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios)),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Rate us",
                      style: CustomFontStyle.font12ClrBlk,
                    ),
                    leading: const Icon(CupertinoIcons.star),
                    trailing: CircleAvatar(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios)),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "New version",
                      style: CustomFontStyle.font12ClrBlk,
                    ),
                    leading: const Icon(CupertinoIcons.up_arrow),
                    trailing: CircleAvatar(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios)),
                    ),
                  ),
                ],
              ),
            ),
            Spaces.y2,
            ElevatedButton(
              onPressed: () {
                logout();
              },
              child: const Text("Log out"),
            )
          ],
        ),
      ),
    );
  }
}
