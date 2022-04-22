import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/mapbox_handler.dart';
import '../helpers/shared_prefs.dart';
import '../Screens/review_ride.dart';

Widget reviewRideFaButton(BuildContext context) {
  return FloatingActionButton.extended(
      icon: const Icon(Icons.motorcycle),
      onPressed: () async {
        LatLng sourceLatLng = getTripLatLngFromSharedPrefs('source');
        LatLng destinationLatLng = getTripLatLngFromSharedPrefs('destination');
        Map modifiedResponse =
            await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);

        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 10), () {
                          Navigator.of(context).pop(true);
                        });
             return AlertDialog(
            title: Text(
              "Ride request placed. Looking for riders nearby please wait for moment",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.green,
              ),
            ),
            actions: [
              SpinKitFadingCircle(
                color: Colors.lightBlue,
                size: 200,
                duration: Duration(milliseconds: 5000),
              ),
              FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel the ride request")),
            ],
          );}
        );
        Future.delayed(Duration(seconds: 10), (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    ReviewRide(modifiedResponse: modifiedResponse)));


        });

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) =>
        //             ReviewRide(modifiedResponse: modifiedResponse)));
      },
      label: const Text('Review Ride'));
}
