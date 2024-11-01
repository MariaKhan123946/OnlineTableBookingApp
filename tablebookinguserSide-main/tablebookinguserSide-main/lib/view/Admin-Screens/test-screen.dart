import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ui/view/Admin-Screens/restaurant-details-screen.dart';
import 'package:ui/widgets/gree-text.dart';
import 'package:ui/widgets/loading-widgets.dart';
import 'package:ui/widgets/my-button.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});
//
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//   String atAddres='';
//   Future<void> _getCurrentLocation() async {
//     try {
//       Position? currentPosition = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best,
//       );
//
//       if (currentPosition != null) {
//         double latitude = currentPosition.latitude;
//         double longitude = currentPosition.longitude;
//
//         print("Latitude: $latitude");
//         print("Longitude: $longitude");
//         // List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
//        // List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
//         List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
//         setState(() {
//           atAddres= placemarks.reversed.last.country.toString()
//               +" "+placemarks.reversed.last.locality.toString() +
//               " "+placemarks.reversed.last.administrativeArea.toString()+" "+
//           placemarks.reversed.last.subAdministrativeArea .toString()+" "+
//           placemarks.reversed.last.subLocality.toString()+" "+ placemarks.reversed.last.thoroughfare.toString()+" \nStreet Address:"+
//           placemarks.reversed.last.street.toString();
//           ;
//           ;
//         });
//         print(atAddres);
//         // if (placemarks.isNotEmpty) {
//         //   Placemark placemark = placemarks.first;
//         //   String cityName = placemark.locality ?? '';
//         //   String country = placemark.country ?? '';
//         //   String postalCode = placemark.postalCode ?? '';
//         //
//         //   print('City: $cityName');
//         //   print('Country: $country');
//         //   print('Postal Code: $postalCode');
//         // }
//       } else {
//         print('Current position is null.');
//       }
//     } catch (error) {
//       print("Error happened: $error");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      // floatingActionButton:
//       //OrangeButton(text: 'Allow Location Access', onPress: (){},width: 300,backcolor: Colors.green,),
//       // FloatingActionButton(onPressed: (){
//       //   _getCurrentLocation();
//       // }),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 400,
//               //width: 3,
//               decoration: BoxDecoration(
//                 image: DecorationImage(image: AssetImage('assets/getlocation.jpg'))
//               ),
//             ),
//             GreenText(text: 'What is Your Location?'),
//             GreyText(text: 'We nee your location to get your \nRestaurant Location'),
//             SizedBox(height: 20,),
//             OrangeButton(text: 'Allow Location Access', onPress: (){
//               _getCurrentLocation();
//             },width: 300,backcolor: Colors.green,),
//             Text(atAddres),
//           ],
//         ),
//       ),
//     );
//   }
// }
class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String atAddres = '';
  String strtAddress='';
  String cityNAme='';
  String locality='';
  bool isLoading = false; // Variable to track loading state

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true; // Show loading indicator when fetching location
    });

    try {
      Position? currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      if (currentPosition != null) {
        double latitude = currentPosition.latitude;
        double longitude = currentPosition.longitude;

        List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

        setState(() {
          strtAddress=placemarks.reversed.last.street.toString();
          cityNAme=placemarks.reversed.last.locality.toString();
          atAddres = placemarks.reversed
              .last.country.toString() +
              " " +
              placemarks.reversed.last.locality.toString() +
              " " +
              placemarks.reversed.last.administrativeArea.toString() +
              " " +
              placemarks.reversed.last.subAdministrativeArea.toString() +
              " " +
              placemarks.reversed.last.subLocality.toString() +
              " " +
              placemarks.reversed.last.thoroughfare.toString() +
              " \nStreet Address:" +
              placemarks.reversed.last.street.toString();
        });
        print(atAddres);
      } else {
        print('Current position is null.');
      }
    } catch (error) {
      print("Error happened: $error");
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator after fetching location
      });
      Get.to(()=>EnterRestauranDetails(cityname: cityNAme,streetAddress: strtAddress,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/getlocation.jpg'),
                ),
              ),
            ),
             GreenText(text: 'What is Your Location?'),
             GreyText(
                text: 'We need your location to get your \nRestaurant Location'),
            const SizedBox(height: 20),
            isLoading
                ? MyLoading() // Show loading indicator when fetching location
                : OrangeButton(
              text: 'Allow Location Access',
              onPress: () {
                _getCurrentLocation();
              },
              width: 300,
              backcolor: Colors.green,
            ),
            Text(atAddres),
          ],
        ),
      ),
    );
  }
}
