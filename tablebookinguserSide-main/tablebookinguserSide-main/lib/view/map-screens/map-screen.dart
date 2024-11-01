import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:ui/Views-screen/Table-Booking-screebs/booking-screen-home.dart';

class MapScreen extends StatefulWidget {
  final String lat;
  final String lng;
  final String docid;
  const MapScreen(
      {super.key, required this.docid, required this.lat, required this.lng});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late double latitude;
  late double longitude;
  late GoogleMapController _mapController;
  LocationData? _currentLocation;
  late Location _locationService;
  bool _isLoading = true;

  final LatLng _initialPosition = LatLng(37.42796133580664, -122.085749655962);
  Marker? _currentLocationMarker;
  Marker? _otherLocationMarker;
  Set<Polyline> _polylines = {};
  @override
  void initState() {
    super.initState();
    latitude = double.parse(widget.lat);
    longitude = double.parse(widget.lng);
    _locationService = Location();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final locationData = await _locationService.getLocation();
    setState(() {
      _currentLocation = locationData;
      _isLoading = false;

      // Create a marker for the current location
      _currentLocationMarker = Marker(
        markerId: MarkerId('currentLocation'),
        position:
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        infoWindow: InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );

      // Create a marker for another specific location (for example, some other place)
      _otherLocationMarker = Marker(
        markerId: MarkerId('otherLocation'),
        position: LatLng(latitude, longitude), // Example LatLng
        infoWindow: InfoWindow(title: 'Other Location'),
        onTap: () => Get.to(() => ReservationDetails(docid: widget.docid)),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    });
    _drawPolyline();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    if (_currentLocation != null) {
      // Animate the camera to the current location
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              _currentLocation!.latitude!,
              _currentLocation!.longitude!,
            ),
            zoom: 15,
          ),
        ),
      );
    }
  }

  void _drawPolyline() async {
    final PolylinePoints _polylinePoints = PolylinePoints();
    final PolylineResult result =
        await _polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: 'AIzaSyAt4_V5xkXWJgN4yeeHhcjor7M25gCJYj8',
      request: PolylineRequest(
        origin: PointLatLng(
            _currentLocation!.latitude!, _currentLocation!.longitude!),
        destination: PointLatLng(latitude, longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      PolylineId id = PolylineId('route');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.green,
        points: polylineCoordinates,
        width: 5,
      );

      setState(() {
        _polylines.add(polyline);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resturant Location'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14.0,
                  ),
                  polylines: _polylines,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: {
                    if (_currentLocationMarker != null) _currentLocationMarker!,
                    if (_otherLocationMarker != null) _otherLocationMarker!,
                  },
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
