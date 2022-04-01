import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart' as nap; 

class RideBook extends StatefulWidget {
  const RideBook({Key? key}) : super(key: key);

  @override
  _RideBookState createState() => _RideBookState();
}

class _RideBookState extends State<RideBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Map());
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        // new FlutterMap(
        //   options: new MapOptions(
        //     center: new nap.LatLng(26.655380, 87.302004),
        //     zoom: 18.0,

        //   ), layers: [
        //     new TileLayerOptions(
        //       urlTemplate: "https://api.mapbox.com/styles/v1/jenish20/cl0v2l506000h15mmhnztltwg/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiamVuaXNoMjAiLCJhIjoiY2wwbnZvMXFrMG1sNzNsa2EzaG1ranU4MyJ9.OQ7IfAkglbMM7rSvRR7iXg",
        //       additionalOptions: {
        //         'accessToken': 'pk.eyJ1IjoiamVuaXNoMjAiLCJhIjoiY2wwbnZvMXFrMG1sNzNsa2EzaG1ranU4MyJ9.OQ7IfAkglbMM7rSvRR7iXg',
        //         'id': 'mapbox.mapbox-streets-v8'
        //       }
        //     ),
        //   ],
        //   ),
        
        // GoogleMap(
        //   initialCameraPosition: CameraPosition(
        //     target: LatLng(26.655466014730937, 87.30191695254963),
        //     zoom: 15,
        //   ),
        // ),
        Positioned(
          top: 100.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.lightBlue,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 10,
                    spreadRadius: 3)
              ],
            ),
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
                hintText: "Pick up",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Positioned(
          top: 160.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.lightBlue,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 10,
                    spreadRadius: 3)
              ],
            ),
            child: TextField(
              onTap: ()async{
                // Prediction? p = await PlacesAutocomplete.show(context: context, apiKey: "AIzaSyC9cRk1zORtVmvqjrHhmhR3YaH409hsPrU"
                // language: "en", components: [
                //   Component(Component.country, "us")
                // ]);
              },
              cursorColor: Colors.black,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {},
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.bike_scooter_sharp,
                    color: Colors.redAccent,
                  ),
                ),
                hintText: "Destination?",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
              ),
            ),
          ),
        ),
        Positioned(
            top: 255.0,
            right: 25.0,
            left: 25.0,
            child: MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      "Your ride request has been placed",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    content: Text(
                        "Please wait for few minutes untill the nearby rider accepts your ride request. You will get notified when your ride request has been accepted.",
                        textAlign: TextAlign.justify,
                        ),
                        actions: [
                          SpinKitFadingCircle(color: Colors.redAccent,size: 200,duration: Duration(milliseconds: 3000),),
                        ],
                  ),
                );
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => RideBook()));
              },
              color: Color(0xff0095FF),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                "Request a Ride",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ))
      ]),
    );
  }
}

