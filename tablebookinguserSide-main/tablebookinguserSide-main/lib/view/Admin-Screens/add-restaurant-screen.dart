
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AddRestaurantPage extends StatefulWidget {
  @override
  _AddRestaurantPageState createState() => _AddRestaurantPageState();
}

class _AddRestaurantPageState extends State<AddRestaurantPage> {

  // Future<void> _getCurrentLocation() async {
  //   try{
  //     Position position = await Geolocator.getCurrentPosition();
  //     if(position==LocationPermission.denied|| position==LocationPermission.denied)
  //     {
  //       print('Locatio Denied');
  //     }
  //     else
  //     {
  //       String latitude='';
  //       String aatitude='';
  //       Position currentPosition=await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best
  //       );
  //       print("Latitude ${currentPosition.latitude.toString()}");
  //       print("Langitude${currentPosition.longitude.toString()}");
  //     }
  //   }
  //   catch(error)
  //   {
  //     print("Error happened $error");
  //   }
  //
  //
  //
  //
  //   // setState(() {
  //   //   _locationController.text =
  //   //   'Lat: ${position.latitude}, Long: ${position.longitude}';
  //   // });
  // }
  String atAddres='';
  Future<void> _getCurrentLocation() async {
    try {
      Position? currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      if (currentPosition != null) {
        double latitude = currentPosition.latitude;
        double longitude = currentPosition.longitude;

        print("Latitude: $latitude");
        print("Longitude: $longitude");
       // List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
        List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
        setState(() {
          atAddres= placemarks.reversed.last.country.toString();
        });
        // if (placemarks.isNotEmpty) {
        //   Placemark placemark = placemarks.first;
        //   String cityName = placemark.locality ?? '';
        //   String country = placemark.country ?? '';
        //   String postalCode = placemark.postalCode ?? '';
        //
        //   print('City: $cityName');
        //   print('Country: $country');
        //   print('Postal Code: $postalCode');
        // }
      } else {
        print('Current position is null.');
      }
    } catch (error) {
      print("Error happened: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20),
            Text(atAddres),
            Row(children: [
              FloatingActionButton(onPressed: (){
                print('Floating------');
                _getCurrentLocation();
              },
              child: Icon(Icons.location_on,color: Colors.white,),
                backgroundColor: Colors.green,
              ),
              FloatingActionButton(onPressed: (){
                //Get.to(()=>AddRestaurantPage());
                print('button pressing');
                _getCurrentLocation();
              },child: Icon(Icons.image_sharp,color: Colors.white,),backgroundColor: Colors.green,),
            ],),
            // ElevatedButton(
            //   //onPressed: _getImage,
            //   child: Text('Upload Image'),
            // ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: _getCurrentLocation,
            //   child: Text('Get Current Location'),
            // ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to save restaurant details
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            SizedBox(height: 20),
           // _image != null ? Image.file(_image!) : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        print('on pressing');
        _getCurrentLocation();
      }),
    );
  }
}
