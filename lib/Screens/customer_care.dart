import 'dart:convert';
import 'dart:async';
import 'package:easyride_app/Screens/about.dart';
import 'package:easyride_app/Screens/pushnotification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easyride_app/helpers/apiprefs.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../requests/baseurl.dart';
import 'package:easyride_app/helpers/apiprefs.dart';

class CustomerCarePage extends StatefulWidget {
  CustomerCarePage({Key? key}) : super(key: key);

  @override
  State<CustomerCarePage> createState() => _CustomerCarePageState();
}

class _CustomerCarePageState extends State<CustomerCarePage> {
  // List<String> attachments = [];

  bool subjectNotEmpty = true;
  bool messageNotEmpty = true;

  bool messageSent = false;
  String mainEmail = "ticketraised.easyride@gmail.com";

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    // _recipientController.dispose();
    super.dispose();
  }

  // UserModel userModel = UserModel();

  Color fontColorAlt = Colors.white;
  Color containerColorAlt = Colors.white;
  Color buttonFontColorAlt = Colors.lightBlue;
  Color backgroundColorAlt = Colors.lightBlue;
  Color fontColor = Colors.black;
  Color containerColor = Colors.lightBlue;
  Color buttonFontColor = Colors.white;
  Color backgroundColor = Colors.white;
  bool alt = false;

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  sendMessage() async 
  {
    String email = "feedback.easyride@gmail.com";
    String password = 'easyride20';

    final smtpServer = gmail(email, password);

    final message = Message()
      ..from = Address(email, mainEmail)
      ..recipients.add(mainEmail)
      ..subject = "Customer Care"
      ..text = "Submitted by: $loggedusername \nUsername: ${userNameController.text}\nEmail: ${emailController.text}\nSubject: ${subjectController.text}\nMessage: ${messageController.text}";
    try 
    {
      tciketNotification();
      final sendReport = await send(message, smtpServer);
      setState(() {
        messageSent = false;
      });
      ScaffoldMessenger.of(context).showSnackBar
      (
        const SnackBar
        (
          content: Text('Ticket has been created. Kindly wait for us to get back to you via your email!'),
        )
      );
    } 
    on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

    void getUserData() async {
    try
    {
      
      userNameController.text = loggedusername!;
      emailController.text = loggedemail!;
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar
      (
        const SnackBar
        (
          content: Text('Not connected to the internet!'),
        )
      );
    } 
  }

  void isSubjectNotEmpty()
  {
    if(subjectController.text.isNotEmpty)
    {
      subjectNotEmpty = true;
    }
    else
    {
      subjectNotEmpty = false;
    }
  }

    void isMessageNotEmpty()
  {
    if(messageController.text.isNotEmpty)
    {
      messageNotEmpty = true;
    }
    else
    {
      messageNotEmpty = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      // key: _scaffoldKey,
      appBar: AppBar
      (
        leading: IconButton
        (
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () => Navigator.push(
          context,
          MaterialPageRoute( 
          builder: (context) => About())),
        ),
        title: const Text("Customer care"),
        centerTitle: true,
      ), 
      backgroundColor: alt ? backgroundColorAlt : backgroundColor,
      body: Center(
        child: SingleChildScrollView
        (
          child: Column
          (
            children: [
              Container
              (
                
                height: 50,
                decoration: BoxDecoration
                (
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.vertical
                  (
                    bottom: Radius.elliptical
                    (
                      MediaQuery.of(context).size.width, 60.0)
                    ),
                ),
              ),
              SizedBox(height: 20),
              Padding
              (
                padding: const EdgeInsets.all(15),
                child: Container
                (
                  decoration: BoxDecoration
                  (
                    border: Border.all
                    (
                      color: Colors.lightBlue,
                      width: 3
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15.0))
                  ),
                  child: Padding
                  (
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Column
                    (
                      children: 
                      [
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        const Text
                        (
                          "Raise a support ticket",
                          style: TextStyle
                          (
                            fontSize: 28,
                            fontWeight:  FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          readOnly: true,
                          controller: userNameController,
                          decoration: const InputDecoration
                          ( 
                            hintText: "Enter your username",
                            labelText: "Username"
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          readOnly: true,
                          controller: emailController,
                          decoration: const InputDecoration
                          (
                            hintText: "Enter your email",
                            labelText: "Email",
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          controller: subjectController,
                          decoration: InputDecoration
                          (
                            hintText: "Enter your subject",
                            labelText: "Subject",
                            errorText: subjectNotEmpty ? null : 'Subject cannot be empty!'
                          ),
                        ),
                        const SizedBox
                        (
                          height: 20.0,
                        ),
                        TextFormField
                        (
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          controller: messageController,
                          decoration: InputDecoration
                          (
                            errorText: messageNotEmpty ? null : 'Message cannot be empty!',
                            hintText: "Enter your message",
                            labelText: "Message",
                          ),
                        ),
                        const SizedBox
                        (
                          height: 40.0,
                        ),
                        ElevatedButton
                        (
                          onPressed: messageSent 
                          ? () {} 
                          : () 
                          { 
                            setState(() {
                              isSubjectNotEmpty();
                              isMessageNotEmpty();
                            });

                            if(subjectNotEmpty && messageNotEmpty)
                            {
                              sendMessage();
                              setState(() {
                                messageSent = true;
                              });
                            }
                          }, 
                          child: messageSent 
                          ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2, ))
                          : const Text
                          (
                            "Send message",
                            style: TextStyle
                            (
                              color: Colors.white
                            ),
                          ),
                          style: ElevatedButton.styleFrom
                          (
                            minimumSize: const Size(150, 40),
                            side: const BorderSide(width: 2, color: Colors.black),
                          )
                        ),
                      ],
                    ),
                  ),        
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}