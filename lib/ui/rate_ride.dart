import 'dart:convert';

import 'package:easyride_app/helpers/apiprefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Screens/home.dart';
import 'package:http/http.dart' as http;

import '../requests/baseurl.dart';
import 'package:easyride_app/Screens/locationsms.dart';

String call = "";

class RateRide extends StatefulWidget {
  const RateRide({Key? key}) : super(key: key);

  @override
  State<RateRide> createState() => _RateRideState();
}

class _RateRideState extends State<RateRide> {
  bool isLoading = false;

  void sendSms(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    String locationUrl;
    final locationSms = LocationSMS();
    await locationSms.userLocation();
    if (locationSms.isGetLocation) {
      locationUrl = await locationSms.launchURL(
        locationSms.locationData!.latitude!,
        locationSms.locationData!.longitude!,
      );
      try {
        final address = await locationSms.getAddress(
          locationSms.locationData!.latitude!,
          locationSms.locationData!.longitude!,
        );
        final country = address[0].country;
        final province = address[0].administrativeArea;
        final district = address[0].subAdministrativeArea;
        final city = address[0].locality;
        final street = address[0].street;
        final locationString =
            "\nCountry:$country\nProvince: $province\nDistrict: $district\nCity: $city\nStreet: $street";
        await LocationSMS().sendSMS(
          call,
          context,
          "Request sent sucesfully",
          'The person has requested for emergency assistant in following location:',
          locationString,
          locationUrl,
        );
        
      } catch (e) {
        print("error");
      }
      setState(() {
          isLoading = false;
        });
    }
  }

    void getEmergency() async {
      try {
        var response = await http
            .get(Uri.parse('${BaseUrl.baseurl}api/passenger/emgDetail/'));
        var jsonData = json.decode(response.body);
        print(jsonData);
        if (response.statusCode == 200) {
          for (var user in jsonData) {
            if (user["email"] == loggedemail) {
              call = user["priorityNumber"];
            }
          }
        }
      } catch (e) {
        print("object");
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: isLoading? Center(child: CircularProgressIndicator()):  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Rate your ride', style: Theme.of(context).textTheme.headline4),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Home())),
              child: const Text('Start another ride'))
        ]),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            elevation: 12,
            onPressed: () {
              getEmergency();
              sendSms(context);
              print(call);
            },
            child: Icon(Icons.medical_services)),
      );
    }
}

