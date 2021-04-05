import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
String mapKey = "AIzaSyCTVVijIWofDrI6LpSzhUqJIF90X-iyZmE";
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var geolocator = Geolocator();
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> markers = {};
  Position myLocation;
  Position finalPosition;

  _createPolylines(Position start, Position destination) async {
    polylinePoints = PolylinePoints();
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //   mapKey, // Google Maps API Key
    //   PointLatLng(start.latitude, start.longitude),
    //   PointLatLng(destination.latitude, destination.longitude),
    //   travelMode: TravelMode.transit,
    // );
    // print(result.status);
    // print(result.errorMessage);
    // print(result.points);

    http.Response response= await http.get('https://apis.mapmyindia.com/advancedmaps/v1/5ug2mtejb2urr2zwgdg8l8mh3zdtm2i3/route_adv/driving/${start.longitude},${start.latitude};${destination.longitude},${destination.latitude}');
    var body = jsonDecode(response.body);
    print(body["routes"][0]["geometry"]);
    List<PointLatLng> polylinePoint = polylinePoints.decodePolyline(body["routes"][0]["geometry"]);
    String distanceBetween = body["routes"][0]["distance"].toString();
    print(distanceBetween);
    print(polylinePoint);
    // Adding the coordinates to the list
    if (polylinePoint.length != 0) {
      polylinePoint.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  void showMarkerAtPosition(Position position, String markerID)async{
    Marker newMarker = Marker(
      markerId: MarkerId(markerID),
      position: LatLng(
        position.latitude,
        position.longitude,
      ),
    );
    setState(() {
      markers.add(newMarker);
    });
  }

  void findDistanceBetweenPositions(Position initialPosition, Position finalPosition)async{
    http.Response response = await http.get('https://apis.mapmyindia.com/advancedmaps/v1/5ug2mtejb2urr2zwgdg8l8mh3zdtm2i3/distance_matrix/driving/${initialPosition.longitude},${initialPosition.latitude};${finalPosition.longitude},${finalPosition.latitude}');
    var result = jsonDecode(response.body);
    var distance = result["results"]["distances"][0][1];
    print('${distance/1000} kms');
  }

  void searchInputValueAndShowMarker(String value, String valueType) async{
    http.Response tokenGet = await http.post('https://outpost.mapmyindia.com/api/security/oauth/token?grant_type=client_credentials&client_id=33OkryzDZsJmp0siGnK04TeuQrg3DWRxswnTg_VBiHew-2D1tA3oa3fthrGnx4vwbwlbF_xT2T4P9dykuS1GUNmbRb8e5CUgz-RgWDyQspeDCXkXK5Nagw==&client_secret=lrFxI-iSEg9xHXNZXiqUoprc9ZvWP_PDWBDw94qhrze0sUkn7LBDwRNFscpDTVFH7aQT4tu6ycN0492wqPs-ewpjObJ6xuR7iRufmSVcnt9fys5dp0F5jlHLxBEj7oqq');
    var body = jsonDecode(tokenGet.body);
    var token = body["access_token"];

    http.Response response = await http.get('https://atlas.mapmyindia.com/api/places/geocode?address=$value&bias=1',
        headers: {HttpHeaders.authorizationHeader: "$token"},);
    print(response.statusCode);
    print(response.body);
    var eloc = (jsonDecode(response.body))["copResults"]["eLoc"];
    http.Response responseLat = await http.get('https://apis.mapmyindia.com/advancedmaps/v1/5ug2mtejb2urr2zwgdg8l8mh3zdtm2i3/place_detail?place_id=$eloc');
    var lat = (jsonDecode(responseLat.body))["results"][0]["latitude"];
    var long = (jsonDecode(responseLat.body))["results"][0]["longitude"];
    showMarkerAtPosition(Position(latitude: lat, longitude: long), valueType);
  }

  void getCurrentLocationAndAnimate() async {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
      LatLng coordinates = LatLng(position.latitude, position.longitude);
      print(coordinates);
      myLocation = Position(latitude:position.latitude, longitude: position.longitude);
      CameraPosition cameraPosition = CameraPosition(target: coordinates, zoom: 12);
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition),);//camera moved to user's position
      // http.Response response = await http.get('http://apis.mapmyindia.com/advancedmaps/v1/5ug2mtejb2urr2zwgdg8l8mh3zdtm2i3/rev_geocode?lat=${position.latitude}&lng=${position.longitude}');
      // var body = jsonDecode(response.body);//gives address
      // print(body["results"][0]["locality"]);
      // print(body["results"][0]);
      Position pos = Position(latitude:28.6139383, longitude:77.20902000000001);
      showMarkerAtPosition(myLocation, "myPosition");
      showMarkerAtPosition(pos, 'Delhi');
      _createPolylines(position, pos);
    }

  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController googleMapController;
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(28.6139383, 77.20902000000001),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Loading Point',
                      hintStyle:
                      TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    onChanged: (value){
                      searchInputValueAndShowMarker(value, "loading Point");
                    },
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    polylines: Set.from(polylines.values),
                    markers:  markers,
                      mapType: MapType.normal,
                      initialCameraPosition: _initialCameraPosition,
                    onMapCreated: (GoogleMapController controller){
                      _controllerGoogleMap.complete(controller);
                      googleMapController = controller;
                      getCurrentLocationAndAnimate();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
