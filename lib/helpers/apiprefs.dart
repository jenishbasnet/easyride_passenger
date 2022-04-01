import 'dart:convert';
import '../Model/user_details.dart';
import 'package:http/http.dart';

// class APIRef{

final String baseUrl = "http://192.168.1.100:8000";



//UserDetail userDetail = UserDetail(email: '', password: '', userid: '', username: '', phoneNumber: '', profilephoto: '');



String user_id = '';


Future getHostelData(String email, password) async
{
  var response = await post(
        Uri.parse('$baseUrl/api/passenger/login/'),
        body: {
          'email' : email,
          'password' : password
        }
      );
      print(response.body);

  
  
  var jsonData = json.decode(response.body);
  List<UserDetail> hostels = [];

  if(response.statusCode == 200){
    for (var h in jsonData){
      UserDetail details = UserDetail(
        h[0]['UserDetails']['email'],
        h[0]['UserDetails']['password'],
        h[0]['userID'],
        h[0]['username'],
        h[0]['phoneNumber'], 
        h[0]['profilePhoto'],
      );
      hostels.add(details);
    }
    print(hostels);

    return hostels;
    

  }else{
    print('failed');
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
