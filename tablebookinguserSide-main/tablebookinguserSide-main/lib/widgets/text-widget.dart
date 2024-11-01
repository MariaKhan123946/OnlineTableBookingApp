import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MyTextWidget extends StatelessWidget {
  String hint;
  String label;
   MyTextWidget({super.key,
   required this.hint, required this.label
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hintStyle: TextStyle(color: Colors.green),
        labelStyle: TextStyle(color: Colors.green),
        prefixIcon: Icon(Icons.table_restaurant_outlined,color: Colors.green,)
      ),
    ).paddingOnly(left: 15,right: 15,top: 10);
  }
}