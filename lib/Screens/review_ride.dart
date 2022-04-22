import 'dart:convert';

import 'package:easyride_app/Screens/prepare_ride.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:easyride_app/helpers/mapbox_handler.dart';
import 'package:easyride_app/helpers/shared_prefs.dart';

import '../Model/availableride_model.dart';
import '../helpers/commons.dart';
import '../requests/baseurl.dart';
import '../widgets/review_ride_bottom_sheet.dart';
import 'package:http/http.dart' as http;

class ReviewRide extends StatefulWidget {
  final Map modifiedResponse;
  const ReviewRide({Key? key, required this.modifiedResponse})
      : super(key: key);

  @override
  State<ReviewRide> createState() => _ReviewRideState();
}

class _ReviewRideState extends State<ReviewRide> {
  // Mapbox Maps SDK related
  final List<CameraPosition> _kTripEndPoints = [];
  late MapboxMapController controller;
  late CameraPosition _initialCameraPosition;

  // Directions API response related
  late String distance;
  late String dropOffTime;
  late Map geometry;
  AvailableModel availablemodel1 = AvailableModel();
  String rider_name = "";
  late String rider_email = "";
  late String phone = "";
  late String license= "";


  @override
  void initState() {
    // initialise distance, dropOffTime, geometry
    _initialiseDirectionsResponse();

    // initialise initialCameraPosition, address and trip end points
    _initialCameraPosition = CameraPosition(
        target: getCenterCoordinatesForPolyline(geometry), zoom: 11);

    for (String type in ['source', 'destination']) {
      _kTripEndPoints
          .add(CameraPosition(target: getTripLatLngFromSharedPrefs(type)));
    }
    LatLng source = getTripLatLngFromSharedPrefs('source');
    LatLng destination = getTripLatLngFromSharedPrefs('destination');
    getRiderInfo();
    
    

    super.initState();
  }

  void getRiderInfo() async{
    LatLng source = getTripLatLngFromSharedPrefs('source');
    LatLng destination = getTripLatLngFromSharedPrefs('destination');
    String src = source.toString();
    String dst = destination.toString();

    print(src);
    print (dst);
    String source_ad = src.substring(7, src.length-1);
    String dest_ad = dst.substring(7, dst.length-1);

    print(source_ad);
    print(dest_ad);

    String c = source_ad;
    String d = dest_ad;

     var res = await http.post(Uri.parse("${BaseUrl.baseurl}api/passenger/available_ride/"),headers:{'Cookie':'${CookieSession.cookiesession}'},
        body: {
          'Source_address' : c,
          'Destination_address' : d
        }
    
    );
     setState(() {
    try{
    var nc = json.decode(res.body);
    rider_name =nc[0]['username'];
    rider_email =nc[0]['email'];
    phone =nc[0]['phoneNumber'];
    license =nc[0]['license'];
    bookRide();
    
    print(rider_name+rider_email+phone+license);
    }catch(e){
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog
        (
          title: Text("Error"),
          content: Text("Seems like there is no rider avaialable in your location at the moment"),
          actions: <Widget>
          [
            FlatButton
            (
              onPressed: () 
              {
                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const PrepareRide()));
                Navigator.of(ctx).pop();
              },
              child: Text("ok"),
            ),
          ],
        ),
      );

    }
     });
    // List rider = [];
    // // Map <String,String> detail = {};
    // // detail = res.body[0] as Map<String,String>;
    // print(res.body[0].toString().isEmpty);
    // rider.add(res.body[1]);
    // print (rider);
    // setState(() {      
    //   availablemodel1 = AvailableModel.fromJson({"data": nc});
    //   // circular = false;
    // });
    // print (availablemodel1.username);
   
    // print (res.body.toString());
    // print(nc["license"]);
    // print(r["license"]);
    // print(r["license"]);
    // print(r["license"]);
    // print(r["license"]);
    // print(r["license"]);

  }

  void bookRide() async{
    var bokkride = await http.post(Uri.parse("${BaseUrl.baseurl}api/passenger/bookride/"),headers:{'Cookie':'${CookieSession.cookiesession}'},
        body: {
          'phoneNumber' : phone
        }
    
    );
    print(bokkride.body.toString());
  }

  _initialiseDirectionsResponse() {
    distance = (widget.modifiedResponse['distance'] / 1000).toStringAsFixed(1);
    dropOffTime = getDropOffTime(widget.modifiedResponse['duration']);
    geometry = widget.modifiedResponse['geometry'];
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {
    for (int i = 0; i < _kTripEndPoints.length; i++) {
      String iconImage = i == 0 ? 'circle' : 'square';
      await controller.addSymbol(
        SymbolOptions(
          geometry: _kTripEndPoints[i].target,
          iconSize: 0.1,
          iconImage: "assests/icon/$iconImage.png",
        ),
      );
    }
    _addSourceAndLineLayer();
  }

  _addSourceAndLineLayer() async {
    // Create a polyLine between source and destination
    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    // Add new source and lineLayer
    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.indigo.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Review Ride'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: MapboxMap(
                accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                minMaxZoomPreference: const MinMaxZoomPreference(11, 11),
              ),
            ),
            reviewRideBottomSheet(context, distance, dropOffTime, rider_name, rider_email, phone, license),
          ],
        ),
      ),
    );
  }
}