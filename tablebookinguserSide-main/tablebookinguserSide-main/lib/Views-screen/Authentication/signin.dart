import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:ui/Views-screen/Admin-home-Nav/nav-bar-screen.dart";
import "package:ui/Views-screen/Authentication/signup.dart";
import "package:ui/constant/space_values.dart";
import "package:ui/home.dart";
import "package:ui/widgets/toast-message.dart";

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _isLoading=false;
  void Login(BuildContext context) async {
    setState(() {
      _isLoading=true;
    });
    String email = Emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      print("Fill all the fields");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (userCredential.user != null) {
          String userId = userCredential.user!.uid;

          // Check if user exists in Firestore UserData collection
          DocumentSnapshot userDataSnapshot =
          await FirebaseFirestore.instance.collection('UserData').doc(userId).get();

          if (userDataSnapshot.exists) {
            // If user data exists, navigate to HomeScreen
          //  Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavBarFinal(),
              ),
            );
          } else {
            // If user data doesn't exist, show error message
            showToast(context, 'User not registered as User');
            print("User not found");
          }
        }
      } on FirebaseAuthException catch (ex) {
        setState(() {
          _isLoading=false;
        });
        print('${ex.code.toString()}');
        showToast(context, '${ex.code.toString()}');
        print(ex.code.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spaces.y10,
          Center(
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
          Spaces.y3,
          _isLoading? CircularProgressIndicator():
          ElevatedButton(
              onPressed: () {
                Login(context);
               // Get.offAll(()=>BottomNavBarFinal());
              },
              child: Text("Login")),
          InkWell(
            onTap:()=> Navigator.push(context, CupertinoPageRoute(builder: (context)=>Signup_screen(      ))),
              child: Text('Dont Have an Account? SignUp')),
        ],
      ),
    ));
  }
}
