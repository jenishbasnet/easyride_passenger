import 'dart:convert';
import 'package:easyride_app/Model/travel_details.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Model/notification_model.dart';
import '../requests/baseurl.dart';

// class APIRef{

final String baseUrl = "http://192.168.1.100:8000";

String ? loggedusername; 
String ? loggedemail;
String ? loggeduserid;
String ? number;
List<Notifications> notifications = [];




//UserDetail userDetail = UserDetail(email: '', password: '', userid: '', username: '', phoneNumber: '', profilephoto: '');



String user_id = '';
Future getTravelHistory() async
{
  var response = await http.get(Uri.parse('${BaseUrl.baseurl}api/passenger/travelhistory/'),headers:{'Cookie':'${CookieSession.cookiesession}'});
  print(response.body.toString());
  var jsonData = json.decode(response.body);
  List<PassengerTravel> travel = [];

  for (var h in jsonData)
  {
    PassengerTravel details = PassengerTravel(
      h["source_address"].toString(),
      h["destination_address"].toString(), 
      h["booked_time"].toString(), 
      h["username"].toString(),
    ); 
    travel.add(details);
  }
  // print(jsonData);
  return travel;
}

Future getUserNotifications() async
{
  try
  {
    var notificationResponse = await http.get(Uri.parse('${BaseUrl.baseurl}api/passenger/userNotifications/?userID=$loggeduserid'), headers: {'Cookie': '${CookieSession.cookiesession}'});
    var notificationJsonData = json.decode(notificationResponse.body);
    print(notificationResponse.toString());

    notifications = [];

    for (var n in notificationJsonData)
    {
      

      Notifications userNotifications = Notifications
      (
        n["userID"],
        n["other"],
        n["notificationMessage"], 
        n["notificationDate"],  

      ); 
      
      notifications.add(userNotifications);
    }
    
    return notifications;
  }
    
  catch(e)
  {
    print("no internet");
  }
}
//  void login(String email , password) async {
    
//     try{
      
//       final response = await post(
//         Uri.parse('$baseUrl/api/passenger/login/'),
//         body: {
//           'email' : email,
//           'password' : password
//         }
//       );
//       print(response.body);

//       var data = json.decode(response.body) as Map <String, dynamic>;
//       if(response.statusCode == 200){
//        UserDetail tempUserdetails =  UserDetail(email: data['UserDetails']['email'], password: data['UserDetails']['password'], userid: data['userID'].toString(), username: data['username'] ,phoneNumber:  data['phoneNumber'], profilephoto:  data['profilePhoto']);
//         userDetail = tempUserdetails;
//         print(userDetail.email);
//         print(userDetail.password);
//         print(userDetail.userid);
//         print(userDetail.username);
//         print(userDetail.phoneNumber);
//         print(userDetail.profilephoto);
        
//         print(data);
//         //user_id = (data['userID'].toString());
//         //print (user_id);
        
//         // var data = jsonDecode(response.body.toString());
//         // print(data['token']);
//         print('Login successfully');
        

//       }else {
//         print('failed');
//       }
//     }catch(e){
//       print(e.toString());
//     }
//   }// For login


// void signup(String username, String email , password) async {
    
//     try{
      
//       final response = await post(
//         Uri.parse('$baseUrl/api/passenger/addUser/'),
//         body: {
//           'username': username,
//           'email' : email,
//           'password' : password
//         }
//       );
//       print(response.body);

//       var data = jsonDecode(response.body.toString());
//       print(data['username']);
//       if(response.statusCode == 200){
        
//         // var data = jsonDecode(response.body.toString());
//         //  print(data['token']);
//         // print('Signup successfully');
        

//       }else {
//         print('failed');
//       }
//     }catch(e){
//       print(e.toString());
//     }
//   }// For login


// // }
