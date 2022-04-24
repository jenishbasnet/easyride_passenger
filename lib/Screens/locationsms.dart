import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LocationSMS {
  final Telephony telephony = Telephony.instance;

  Future<void> sendSMS(
    String number,
    BuildContext context,
    String snackBarMessage,
    String smsMessage,
    String locationString,
    locUrl,
  ) async {
    try {
      String loc = locUrl;
      bool? permissionsGranted = await telephony.requestSmsPermissions;
      if (permissionsGranted == null || !permissionsGranted) {
        permissionsGranted = await telephony.requestSmsPermissions;
      }
      if (permissionsGranted != null && permissionsGranted) {
        // ignore: prefer_function_declarations_over_variables
        final SmsSendStatusListener listener = (SendStatus status) {
          if (status == SendStatus.SENT) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              margin: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.black87,
              content: Text(
                snackBarMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              duration: const Duration(
                seconds: 3,
              ),
            ));
          }
        };
        print(smsMessage);
        print(locationString);
        print(loc);
        await telephony.sendSms(
          to: number,
          message: '$smsMessage\n$locationString\n\n$loc',//' $smsMessage\n$locationString\n\n$loc',
          statusListener: listener,
          isMultipart: true,
        );
      }
    } catch (error) {
      print(error);
      print('Phone Denied:' + error.toString());
      // rethrow;
    }
  }

  

  Location location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? locationData;
  bool isGetLocation = false;

  Future<void> userLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        isGetLocation = false;
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.deniedForever) {
      _permissionGranted = await location.requestPermission();
    }
    if (_permissionGranted == PermissionStatus.denied) {
      print('inhere');
      _permissionGranted = await location.requestPermission();
      print(_permissionGranted);
    }
    if (_permissionGranted! != PermissionStatus.granted) {
      isGetLocation = false;
      return;
    }

    locationData = await location.getLocation();

    isGetLocation = true;
    print(locationData!.latitude.toString() +
        ',' +
        locationData!.longitude.toString());
  }

  Future<List<geo.Placemark>> getAddress(double lat, double long) async {
    List<geo.Placemark> placemark = await geo
        .placemarkFromCoordinates(lat, long)
        .onError((error, stackTrace) {
      throw Exception(error);
    });
    print(placemark);
    return placemark;
  }

  Future<String> launchURL(double lat, double long) async {
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=${lat.toString()},${long.toString()}";

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    return encodedURl;
    
  }
}