import 'package:flutter/material.dart';

import '../helpers/shared_prefs.dart';
import '../Screens/turn_by_turn.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:telephony/telephony.dart';


Future<bool?> call(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
final Telephony telephony = Telephony.instance;
Future<void> sendSMS(
    String number,
    
    
  ) async {
    try {
      
      final bool? permissionsGranted =
          await telephony.requestPhoneAndSmsPermissions;

      if (permissionsGranted != null && permissionsGranted) {
       
        
        await telephony.sendSmsByDefaultApp(
          to: number,
          message: 'Hey!!! Whats the arrival time?',
          
        );
      }
    } catch (error) {
      print(error);
      print('Phone Denied:' + error.toString());
    }
  }

Widget reviewRideBottomSheet(
    BuildContext context,
    String distance,
    String dropOffTime,
    String rider_name,
    String rider_email,
    String phone,
    String license) {
  String sourceAddress = getSourceAndDestinationPlaceText('source');
  String destinationAddress = getSourceAndDestinationPlaceText('destination');
  double a = double.parse(distance);
  double b = (a * 20);
  String price = b.toString();

  return Positioned(
    bottom: 0,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$sourceAddress ➡ $destinationAddress',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Colors.indigo)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    leading: const Image(
                        image: AssetImage('assests/image/sport-car.png'),
                        height: 50,
                        width: 50),
                    title: const Text('Premier',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text('$distance km, $dropOffTime drop off'),
                    trailing: Text('\RS $price',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    leading: const Image(
                        image: AssetImage('assests/image/rider.png'),
                        height: 50,
                        width: 50),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Rider Details ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        ClipRRect(
                           borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                             color: Colors.green,
                            child: IconButton(onPressed: () async{await call('$phone');}
                            , icon: Icon(Icons.phone, color: Colors.black)),
                          ),
                        ),
                        ClipRRect(
                           borderRadius: BorderRadius.circular(10.0),
               
                          child: Container(
                             color: Colors.green,
                            child: IconButton(onPressed: ()async{await sendSMS('$phone');
                        
                            }, icon: Icon(Icons.message_rounded, color: Colors.black)),
                          ),
                        ),
                        
                      ],
                      
                    ),
                    
                  
                    subtitle: Column(
                       
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            Align(alignment: Alignment.centerLeft,child: Text('Rider Username   ', style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                            Text("$rider_name", style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                          ],
                        ),
                        
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            Align(alignment: Alignment.centerLeft,child: Text('Rider Email', style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                            Text("$rider_email",style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            Align(alignment: Alignment.centerLeft,child: Text('Phone Number', style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                            Text("$phone",style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold) )
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            Align(alignment: Alignment.centerLeft,child: Text('License', style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                            Text("$license", style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                          ],
                        ),
                       
                        
                      ],
                    ),

                    // trailing:  Text('aa aa',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  
                  
                ),
                ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const TurnByTurn())),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Start your premier ride now'),
                        ])),
              ]),
        ),
      ),
    ),
  );
}




