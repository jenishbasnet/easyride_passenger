//@dart = 2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easyride_app/helpers/apiprefs.dart';
// import 'package:hotel_booking_app/pages/hostel_profile_page.dart';
// import 'package:hotel_booking_app/pages/saved_page.dart';
// import 'package:hotel_booking_app/utils/drawer.dart';
// import 'package:hotel_booking_app/utils/routes.dart';
// import 'package:hotel_booking_app/utils/search.dart';

class TravelHistory extends StatelessWidget {
  const TravelHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return WillPopScope
    (
      onWillPop: () async => false,
      child: Scaffold
      (
        
        body: Column
        (
          children:
          [
            const SizedBox
            (
              height: 25.0,
            ),
            SingleChildScrollView
            (
              scrollDirection: Axis.horizontal,
            ),
            const SizedBox(height: 25),
            const Text
            (
              "Travel History", 
              style: TextStyle
              (
                fontSize: 18
              ),
            ),
            const SizedBox(height: 25),
            FutureBuilder
            (
              future: getTravelHistory(),
              builder: (context, snapshot) 
              {
                // print(snapshot.data);
                if(snapshot.data == null)
                {
                  return Container(child: Text("loading...", style: TextStyle(fontSize: 18),));
                }
                else
                {
                  return Expanded
                  (
                    child: ListView.builder
                    (
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i)
                      {
                        return SingleChildScrollView
                        (
                          child: Column
                          (
                            children: 
                            [
                              
                              InkWell(
                                // onTap: () 
                                // {
                                //   HostelProfilePage.hostelID = snapshot.data[i].id;
                                //   Navigator.pushNamed(context, MyRoutes.hostelProfileRoute);
                                // },
                                child: Container
                                (                    
                                  width: 325,
                                  margin: EdgeInsets.fromLTRB(15, 15, 15, 45),
                                  decoration: BoxDecoration
                                  (
                                    boxShadow: 
                                    [
                                      BoxShadow
                                      (
                                        color: Colors.black54,
                                        offset: Offset(1, 5),
                                        blurRadius: 6,
                                      )
                                    ],
                                    border: Border.all(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.cyan
                                  ),
                                                
                                  child: Column
                                  (
                                    children: 
                                    [
                                      Container
                                      (
                                        clipBehavior: Clip.antiAlias,                                       
                                        width: 350,
                                        height: 125,
                                        decoration: BoxDecoration
                                        (
                                          border: Border.all(color: Colors.cyan),
                                          borderRadius: const BorderRadius.only
                                          (
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(45),
                                            bottomRight: Radius.circular(45),
                                          ),
                                          color: Colors.white
                                        ),
                                        child: Image.network(
                                          'https://i.morioh.com/201229/96da41b1.webp', 
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                        child: Row
                                        (
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: 
                                          [
                                            Text
                                            (
                                              snapshot.data[i].username, 
                                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Row
                                        (
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: 
                                          [
                                            Row(
                                              children: [
                                                
                                                Text(snapshot.data[i].source_address, style: TextStyle(color: Colors.white, fontSize: 15)),
                                                Text(", ", style: TextStyle(color: Colors.white, fontSize: 15)),
                                                Text(snapshot.data[i].destination_address, style: TextStyle(color: Colors.white, fontSize: 15)),
                                              ],
                                            ),
                                               
                                          ],
                                        ),
                                      ),
                                      Text
                                      (
                                        snapshot.data[i].booked_time, 
                                        style: TextStyle(color: Colors.white, fontSize: 15)
                                      ),     
                                      
                                      SizedBox(height: 25,)
                                    ]
                                  ),
                                ),
                              ),              
                            ],
                          )
                        );
                      },
                    ),
                  );
                }
              }
            )
          ]
        )      
      ),
    );
  }
}
