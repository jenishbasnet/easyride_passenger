//@dart = 2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easyride_app/helpers/apiprefs.dart';
// import 'package:hotel_booking_app/pages/hostel_profile_page.dart';
// import 'package:hotel_booking_app/pages/saved_page.dart';
// import 'package:hotel_booking_app/utils/drawer.dart';
// import 'package:hotel_booking_app/utils/routes.dart';
// import 'package:hotel_booking_app/utils/search.dart';
import 'package:geocoding/geocoding.dart';


class TravelHistory extends StatefulWidget {
  const TravelHistory({Key key}) : super(key: key);

  @override
  State<TravelHistory> createState() => _TravelHistoryState();
}

class _TravelHistoryState extends State<TravelHistory> {
  @override

double latitude1;

double longitude1;

String source;

double latitude2;

double longitude2;

String dest;

List<String> destinationad = ['a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D'];

List<String> soorad = ['a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D','a' , 'B', 'C', 'D'];

  void convert(source_ad){
    String a = source_ad;
    // print(a);
    List <String> latlong = a.split(',');
    latitude1 = double.parse(latlong[0]);
    longitude1 = double.parse(latlong[1]);

  }

  Future<void> getAddress(double lat, double long, int gan) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
    // MapsLauncher.launchCoordinates(26.822304, 87.285116);
    // print(MapsLauncher.createCoordinatesUrl(26.822304, 87.285116));
    // print(placemark[0]);
    Placemark place = placemark[0]; 
    source = place.name+ ' '+ place.locality;
    soorad [gan] = source.toString();
  }

  void convertdes(dest_ad){
    String b = dest_ad;
    // print(a);
    List <String> latlong2 = b.split(',');
    latitude2 = double.parse(latlong2[0]);
    longitude2 = double.parse(latlong2[1]);

  }

  Future<void> getAddressdes(double lat1, double long1, int cnt) async {
    List<Placemark> placemark1 = await placemarkFromCoordinates(lat1, long1);
    // MapsLauncher.launchCoordinates(26.822304, 87.285116);
    // print(MapsLauncher.createCoordinatesUrl(26.822304, 87.285116));
    // print(placemark[0]);
    Placemark place1 = placemark1[0]; 
    dest = place1.name +' '+ place1.locality;
    destinationad [cnt] = dest.toString();
    print (destinationad [cnt]);
  }

  Widget build(BuildContext context) { 
    return WillPopScope
    (
      onWillPop: () async => false,
      child: Scaffold
      
      (
        appBar: AppBar(
        elevation: 4,
        brightness: Brightness.dark,
        backgroundColor: Colors.blue,
        title: Text
            (
              "Travel History", 
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
              
            ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
          
        ),
      ),
        
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
           
            const SizedBox(height: 10),
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
                  print(snapshot.data.length);
                  for (int j = 0; j < snapshot.data.length; j++) {
                          print(snapshot.data.length);
                          convert(snapshot.data[j].source_address);
                        getAddress(latitude1, longitude1, j);
                        convertdes(snapshot.data[j].destination_address);
                        getAddressdes(latitude2, longitude2, j);
                        print('object');
                        print(snapshot.data[j].destination_address);
                        // print(snapshot.data[j].destination_address);
                        // 
                        // print(j);
                        // print(destinationad[j]);
                        // print(sourcead.length);
                        // print(destinationad[j]);
                        }
                  
                  return Expanded
                  (
                    child: ListView.builder
                    (
                      // scrollDirection: Axis.vertical,
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
                                onTap: () 
                                {
                                  
                                },
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
                                            // bottomLeft: Radius.circular(45),
                                            // bottomRight: Radius.circular(45),
                                          ),
                                          color: Colors.white
                                        ),
                                        child: Image.network(
                                            'https://assets-global.website-files.com/6050a76fa6a633d5d54ae714/609147088669907f652110b0_report-an-issue(about-maps).jpeg', 
                                            fit: BoxFit.fill,
                                          ),
                                        
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                        child: Row
                                        (
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: 
                                          [
                                            Text("Rider : ", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: 
                                          [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text("Pickup : ", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                                Text(soorad[i], style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                                                
                                              ],
                                            ),
                                               
                                          ],
                                        ),
                                      ),
                                      
                                      Row(children: [
                                        Text("Destination : ", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                        Text(destinationad[i], style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold))]),
                                       SizedBox(
                                         height: 20,
                                       ), 
                                      Text
                                      (
                                        snapshot.data[i].booked_time.substring(0,19).replaceAll("T",'   '), 
                                        style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold, backgroundColor: Colors.black12)
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
