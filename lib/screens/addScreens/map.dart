
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hakim_dash/providers/hospitalProvider.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class hakimMap extends StatefulWidget {
  const hakimMap({super.key});

  @override
  State<hakimMap> createState() => _hakimMapState();
}

class _hakimMapState extends State<hakimMap> {
  String googleApikey = "GOOGLE_MAP_API_KEY";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(15.5007, 32.5599);
  String location = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Longitude Latitude Picker in Google Map"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Stack(children: [
          GoogleMap(
            //Map widget from google_maps_flutter package
            zoomGesturesEnabled: true, //enable Zoom in, out on map

            initialCameraPosition: CameraPosition(
              //innital position in map
              target: startLocation, //initial position
              zoom: 14.0, //initial zoom level
            ),
            mapType: MapType.normal, //map type
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
            onCameraMove: (CameraPosition cameraPositiona) {
              cameraPosition = cameraPositiona; //when map is dragging
            },
            onCameraIdle: () async {
              //when map drag stops
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPosition!.target.latitude,
                  cameraPosition!.target.longitude);
              print(cameraPosition!.target.latitude);
              setState(() {
                print(placemarks.first.toJson());
                //get place name from lat and lang
                location = placemarks.first.administrativeArea.toString() +
                    ", " +
                    placemarks.first.street!;
              });
            },
          ),
          Center(
            //picker image on google map
            child: Icon(
              Ionicons.location_outline,
              size: 30,
            ),
          ),
          Positioned(
              //widget to display location name
              bottom: 100,
              child: InkWell(
                onLongPress: () {
                  Provider.of<HospitalProvider>(context, listen: false)
                          .determinePosition( 
                      LatLng(cameraPosition!.target.latitude,
                          cameraPosition!.target.longitude));
                  Navigator.pop(
                      context
                     );
                },
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Card(
                    child: Container(
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width - 40,
                        child: ListTile(
                          leading: Icon(Icons.pin_drop),
                          title: Text(
                            location,
                            style: TextStyle(fontSize: 18),
                          ),
                          dense: true,
                        )),
                  ),
                ),
              ))
        ]));
  }
}
