import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({ Key? key }) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [const Text(
              "Notifications",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Icon(
                  Icons.notifications,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Earlier Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const[
                Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                  "The Ride has been sucesfully completed",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  ),
                ),
                

            ],),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const[
                Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                  "The Ride has been started to the location Malah Nagar,Nepal",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  ),
                ),

            ],),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const[
                Icon(
                  Icons.notifications,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                  "The Rider has reached the pickup location",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  ),
                ),

            ],),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const[
                Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                  "Rider: Himal Acharya has accepted your ride request.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  ),
                ),

            ],),
            SizedBox(
              height: 50,
            ),
            SpinKitThreeBounce(color: Colors.lightBlue,size: 50,duration: Duration(milliseconds: 3000),),

            
            ],
        ),
      ),
    );
  }
}