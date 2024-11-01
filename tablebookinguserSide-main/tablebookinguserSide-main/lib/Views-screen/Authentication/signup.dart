import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:ui/Views-screen/Authentication/signin.dart";
import "package:ui/constant/space_values.dart";
import "package:ui/widgets/toast-message.dart";

class Signup_screen extends StatefulWidget {
  const Signup_screen({super.key});

  @override
  State<Signup_screen> createState() => _Signup_screenState();
}

class _Signup_screenState extends State<Signup_screen> {
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController cpasswordcontroller = TextEditingController();
  bool _isLoading=false;

  Future<void> _register() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      String email = Emailcontroller.text.trim();
      String name = namecontroller.text.trim();
      String password = passwordcontroller.text.trim();

      // Sign up with Firebase authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If user creation is successful, add user data to Firestore
      await FirebaseFirestore.instance.collection('UserData').doc(userCredential.user!.uid).set({
        'name': namecontroller.text,
        'email': Emailcontroller.text,
        'userId': userCredential.user!.uid, // Store user ID in Firestore
      });
      showToast(context, 'Signup successfully------------------');
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Login_screen()));
    } catch (e) {
      showToast(context, 'Error Occured:$e');
      print("Error occurred: $e");
      // Handle error if signup fails
      //Get.snackbar('Error---', 'Error appeared: $e');
    } finally {

      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  // void CreateAccount(BuildContext context) async {
  //   setState(() {
  //     _isloading = true; // Show loading indicator
  //   });
  //
  //   String email = Emailcontroller.text.trim();
  //   String name = namecontroller.text.trim();
  //   String password = passwordcontroller.text.trim();
  //   String cpassword = cpasswordcontroller.text.trim();
  //
  //   if (email.isEmpty || password.isEmpty || cpassword.isEmpty) {
  //     Fluttertoast.showToast(
  //       msg: "Please fill all fields",
  //       toastLength: Toast.LENGTH_SHORT,
  //     );
  //   } else if (password != cpassword) {
  //     Fluttertoast.showToast(
  //       msg: "Passwords don't match",
  //       toastLength: Toast.LENGTH_SHORT,
  //     );
  //   } else {
  //     try {
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(email: email, password: password);
  //       if (userCredential.user != null) {
  //         // Save user data to Firestore
  //         await FirebaseFirestore.instance.collection('UserData').doc(userCredential.user!.uid).set({
  //           'name': name,
  //           'email': email,
  //           'userId': userCredential.user!.uid,
  //         });
  //         print('data saved-----------------');
  //         // Fluttertoast.showToast(
  //         //   msg: "Data saved",
  //         //   toastLength: Toast.LENGTH_SHORT,
  //         // );
  //
  //         // Navigate back to the previous screen
  //         Navigator.pop(context);
  //       }
  //     } on FirebaseAuthException catch (ex) {
  //       print('error appeared:$ex');
  //       // Fluttertoast.showToast(
  //       //   msg: ex.message ?? "An error occurred",
  //       //   toastLength: Toast.LENGTH_SHORT,
  //       // );
  //     }
  //   }
  //   setState(() {
  //     _isloading = false; // Hide loading indicator
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spaces.y10,
          const Center(
            child: Image(
              image: AssetImage("assets/profile.png"),
              width: 100,
              height: 100,
            ),
          ),
          Spaces.y6,
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: namecontroller,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: Emailcontroller,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: cpasswordcontroller,
              decoration: InputDecoration(
                hintText: "confirm password ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          Spaces.y3,
          _isLoading? CircularProgressIndicator(): ElevatedButton(
              onPressed: () {
                _register();
              },
              child: const Text("Signup")),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login_screen()));
              },
              child: const Text("Login"))
        ],
      ),
    ));
  }
}
