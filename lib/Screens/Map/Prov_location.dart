import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';


class Prov_loc with ChangeNotifier
{
  MapType type=MapType.normal;
  String ?newlang;
  String ?newlat;
  String ?newaddress;
  LatLng ? longlat;
  int ? Location_id;
  void change_maptype(MapType maptype)
  {
    type=maptype;
    notifyListeners();
  }

  late LatLng  currentLatLng;
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

   List<Placemark>? placemarks;
  late Placemark placeMark;
   String ? cityname;
   String? countryname;
  String ? address;
   String ? locality;
  Future<Position> getCurrentLocation() async
  {
    var currentPositin = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentLatLng = LatLng(currentPositin.latitude, currentPositin.longitude);
    longlat=currentLatLng;
    return currentPositin;
  }
  void onMapCreated(controller) {
      mapController = controller;
    notifyListeners();
  }
  mylocationnavigate()async{
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:currentLatLng, zoom: 17, ),));
    await getPlace(currentLatLng.latitude,currentLatLng.longitude);

    final marker = Marker(
      markerId: const MarkerId('place_name'),
      position:currentLatLng,

      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: address,

      ),
    );
   markers[const MarkerId('place_name')] = marker;
   notifyListeners();

  }
  searchnavigate(String searchAdd) async {

    locationFromAddress(searchAdd).then((result) async {
      await getPlace(result[0].latitude, result[0].longitude);
      longlat=LatLng(result[0].latitude, result[0].longitude);
      final marker = Marker(
        markerId: const MarkerId('place_name'),
        position: LatLng(result[0].latitude, result[0].longitude),
        // icon: BitmapDescriptor.,
        infoWindow: InfoWindow(
          title: address,

        ),
      );
     mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(result[0].latitude, result[0].longitude),
        zoom: 16,

      )));
      markers[const MarkerId('place_name')] = marker;
      print(result[0].longitude);
    });
    notifyListeners();
  }
  Future<void> getPlace(double lat,double lang)  async {
    placemarks = await placemarkFromCoordinates(lat, lang);

    // this is all you need
    Placemark placeMark  = placemarks![0];
     cityname = placeMark.administrativeArea!;
     countryname= placeMark.country!;
    locality = placeMark.locality!;
     address = "$locality,$cityname,$countryname";

     notifyListeners();
  }
  void update_loc()
  {
    newlang=longlat!.longitude.toString();
    newlat=longlat!.latitude.toString();
    newaddress=address;
    print(newaddress);
    notifyListeners();
  }

  change_currentlocation(result) async
  {
    await getPlace(result.latitude, result.longitude);
    longlat=LatLng(result.latitude, result.longitude);
    final marker = Marker(
      markerId: const MarkerId('place_name'),
      position: LatLng(result.latitude, result.longitude),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: address,

      ),
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(result.latitude, result.longitude),
      zoom: 16,

    )));
    markers[const MarkerId('place_name')] = marker;
    print(result.longitude);
    notifyListeners();

  }


  Future<void> AddnewAddress({required String name,required String city,required String region,
    required String details,required var long,required var lat,required String notes }) async
  {
    var headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'Authorization': authkey!,
    };
    var request = http.Request('POST', Uri.parse('https://student.valuxapps.com/api/addresses'));
    request.body = json.encode({
      "name": "$name",
      "city": "$city",
      "region": "$region",
      "details": "$details",
      "latitude": long,
      "longitude": lat,
      "notes": "$notes"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res=await http.Response.fromStream(response);
      // print(res.body);
      var js=json.decode(res.body);
      print(js["data"]["id"]);
      Location_id=int.parse(js["data"]["id"].toString());
      notifyListeners();
     
    }
    else {
      print(response.reasonPhrase);
    }


  }

}