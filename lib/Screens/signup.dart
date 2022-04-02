import 'dart:convert';

import 'package:easyride_app/Screens/login.dart';
import 'package:easyride_app/helpers/apiprefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;

import '../requests/baseurl.dart';

bool emailValid = true;
bool samePassword = true;
bool emailvalidate = false;
bool usernamevalidate = false;
bool passwordvalidate = false;

class SignUpPage extends StatefulWidget {
  
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  
  TextEditingController confirmPasswordController = TextEditingController();

void signUpUser() async {
    var response = await http.post(Uri.parse('${BaseUrl.baseurl}api/passenger/addUser/'), 
    body: {'username': usernameController.text, 'email': emailController.text, 'password': passwordController.text});
    var jsonData = json.decode(response.body);
    if(response.statusCode == 201)
    {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog
        (
          title: Text("Success"),
          content: Text("User signed up!"),
          actions: <Widget>
          [
            FlatButton
            (
              onPressed: () 
              {                
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => LogInPage()));
              },
              child: Text("ok"),
            ),
          ],
        ),
      );
    }
  }


  // bool validate = false;
  void checkPassword(){
    if (passwordController.text == confirmPasswordController.text){
      samePassword = true;
    }
    else {
      samePassword = false;
    }
 }

  void checkEmail()
  {
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text))
    {
      emailValid = true;
    }
    else
    {
      emailValid = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "If not registered as user create an account ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  usernameFile(label: "Username", controller: usernameController),
                  emailFile(label: "Email", controller: emailController),
                  passwordFile(label: "Password", obscureText: true, controller: passwordController),
                  passwordFile(label: "Confirm Password ", obscureText: true, controller: confirmPasswordController),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: const Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    setState(() {
                    emailController.text.isEmpty ? emailvalidate = true : emailvalidate = false;
                    checkEmail();
                    usernameController.text.isEmpty ? usernamevalidate = true : usernamevalidate = false;                    
                    // confirmPasswordController.text != passwordController.text ? passwordvalidate = true : passwordvalidate = false;                    
                    passwordController.text.isEmpty ? passwordvalidate = true : passwordvalidate = false;
                    checkPassword();
                    
                  });
                  
                  if(emailvalidate == false && usernamevalidate == false && passwordvalidate ==false )
                        {
                          if (emailValid)
                          {
                            if (samePassword)
                            {
                              signUpUser();

                            }
                          }
                        }
                    
                    // signup(usernameController.text.toString(),emailController.text.toString(), passwordController.text.toString());
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => AlertDialog(
                    //       actions: [
                    //         SpinKitFadingCircle(
                    //           color: Colors.lightBlue,
                    //           size: 200,
                    //           duration: Duration(milliseconds: 3000),
                    //         ),
                    //       ],
                    //     ),
                    //   );
                  },
                  color: const Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?"),
                  InkWell(
                    child: const Text(
                      " Login",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogInPage()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Text Field Widget
Widget emailFile({label, obscureText = false, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        controller: controller,
        decoration:  InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            errorText:  emailvalidate == false ? emailValid ? null : 'Invalid email!' : 'Email cannot be empty!',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}


// Text Field Widget
Widget usernameFile({label, obscureText = false, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        controller: controller,
        decoration:  InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            errorText:  usernamevalidate ? 'This field Can\'t Be Empty' : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}


// Text Field Widget
Widget passwordFile({label, obscureText = false, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        controller: controller,
        decoration:  InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            errorText:  passwordvalidate == false ? samePassword ? null : 'Password doesnot match' : 'Password cannot be empty',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}


