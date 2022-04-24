import 'dart:convert';

import 'package:easyride_app/Screens/customer_care.dart';
import 'package:easyride_app/Screens/feedback.dart';
import 'package:easyride_app/Screens/travel_history.dart';
import 'package:easyride_app/helpers/apiprefs.dart';
import 'package:easyride_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../requests/baseurl.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool messages = true;
  bool accountActivity = true;
  bool rideAlert = true;
  bool location = true;
  bool userValid = false;
  bool emptyValid = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // TextEditingController emergencyNumController = TextEditingController();
  TextEditingController emergencyNumControl = TextEditingController();

  bool feedbackSent = false;
  String mainEmail = "feedback.easyride@gmail.com";

  void getUserEmails() async {
    try {
      var response =
          await http.get(Uri.parse('${BaseUrl.baseurl}api/rider/userDetails/'));
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var user in jsonData) {
          if (user["username"] == usernameController.text) {
            print(user["username"]);
            userValid = true;
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Not connected to the internet!'),
      ));
    }
  }

  void emergency() async {
    try {
      print(loggeduserid);
      var response =
          await http.put(Uri.parse("${BaseUrl.baseurl}api/passenger/em/$loggeduserid/"),
        body: {
          'priorityNumber' : emergencyNumControl.text,
          'email': loggedemail
          
        });
      var jsonData = json.decode(response.body);
      print (jsonData);
      number = emergencyNumControl.text;

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Not connected to the internet!'),
      ));
    }
  }

  void checkFeedback() {
    if (descriptionController.text == "") {
      descriptionController.text = "No feedback";
    }
  }

  sendFeedback() async {
    String email = "noreply.easyride@gmail.com";
    String password = 'punknotdead20';

    final smtpServer = gmail(email, password);

    final message = Message()
      ..from = Address(email, mainEmail)
      ..recipients.add(mainEmail)
      ..subject = "${usernameController.text} has been reported (Rider)"
      ..text =
          "Submitted by: $loggedusername \nEmail: $loggedemail\nReported rider: ${usernameController.text}\nMessage: ${descriptionController.text}";

    try {
      final sendReport = await send(message, smtpServer);
      setState(() {
       feedbackSent = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Thank you, the user has been reported!'),
      ));
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            const Text(
              "Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Additional information",
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
            buildTravelHistory(context, "Travel History"),
            buildCustomer(context, "Customer Care Support"),
            buildReportScreen(context, "Report Rider"),
            buildFeedback(context, "Feedback and Bug Reports"),
            buildEmergencyScreen(context, "Add Emergency Number"),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Messages",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
                Transform.scale(
                  scale: 1,
                  child: Checkbox(
                    value: this.messages,
                    onChanged: (value) {
                      setState(() {
                        this.messages = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Account Activity",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
                Transform.scale(
                  scale: 1,
                  child: Checkbox(
                    value: this.accountActivity,
                    onChanged: (value) {
                      setState(() {
                        this.accountActivity = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ride Alert",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
                Transform.scale(
                  scale: 1,
                  child: Checkbox(
                    value: this.rideAlert,
                    onChanged: (value) {
                      setState(() {
                        this.rideAlert = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
                Transform.scale(
                  scale: 1,
                  child: Checkbox(
                    value: this.location,
                    onChanged: (value) {
                      setState(() {
                        this.location = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return HomePage();
                      },
                    ),
                    (_) => false,
                  );
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text("SIGN OUT",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildReportScreen(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Report a rider",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.blue,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Username of the rider",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          // errorText:  emptyValid== false? userValid? null : 'Invalid email!' : 'Email cannot be empty!',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    TextField(
                      controller: descriptionController,
                    ),
                  ],
                ),
                actions: [
                  FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: feedbackSent
                          ? () {}
                          : () {
                            
                              // userValid = false;
                              // setState(() {
                              // usernameController.text.isEmpty ? emptyValid = false : emptyValid = false;
                              getUserEmails();
                              // });
                              // if (emptyValid == false){
                              if (userValid == true) {
                                print('validated');
                                userValid = false;
                                checkFeedback();
                                sendFeedback();
                                setState(() {
                                  feedbackSent = true;
                                });
                                Navigator.of(context).pop();
                                
                              } else {
                                print('object');
                                showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("⚠ Error! Invalid username⚠", style: TextStyle(color: Colors.redAccent),),);});
                
                                
                              }
                            },
                      child: feedbackSent
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ))
                          : const Text("Report")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildEmergencyScreen(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Emergency number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Provide Emergency Number",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IntlPhoneField(
                      controller: emergencyNumControl,
                      showCountryFlag: false,
                      decoration: const InputDecoration(
                          labelText: "Phone number",
                          hintText: "Enter your phone number"),
                      initialCountryCode: 'NP',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                actions: [
                  FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () {
                        emergency();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Add Number")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildTravelHistory(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        getTravelHistory();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TravelHistory()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildFeedback(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeedbackPage()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildCustomer(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CustomerCarePage()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
