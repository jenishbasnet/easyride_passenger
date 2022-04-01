import 'package:easyride_app/Screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:easyride_app/Screens/navigation.dart';
import 'package:easyride_app/Screens/signup.dart';
import 'package:http/http.dart' as http;
import 'package:easyride_app/helpers/apiprefs.dart';
import 'dart:convert';

import '../Model/user_model.dart';
import '../requests/baseurl.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  // Model model = Model();
  UserModel usermodel = UserModel();

  bool circular = true;

  
  

  void getData() async {
    var res = await http.post(Uri.parse("${BaseUrl.baseurl}api/passenger/login/"),
        body: {
          'email' : emailController.text,
          'password' : passwordController.text
        }
    
    );
    var r = json.decode(res.body);
    if (res.statusCode == 200){
      Navigator.push(
          context,
          MaterialPageRoute( 
          builder: (context) => cusNav()));

    }
    else{
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog
        (
          title: Text("Error"),
          content: Text("Invalid credentials!"),
          actions: <Widget>
          [
            FlatButton
            (
              onPressed: () 
              {
                Navigator.of(ctx).pop();
              },
              child: Text("ok"),
            ),
          ],
        ),
      );

    }
    setState(() {      
      usermodel = UserModel.fromJson({"data": r});
      Profile.emailHolder = r["email"];
      Profile.passwordHolder = r["password"];
      circular = false;
    });
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Login to your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      inputFile(label: "Email", controller:emailController,),
                      inputFile(label: "Password", obscureText: true, controller: passwordController,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
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
                        onPressed: () 
                        {
                          getData();
                          // getHostelData(emailController.text.toString(), passwordController.text.toString());
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                                
                          //         builder: (context) => cusNav()));
                        },
                        color: const Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Don't have an account?"),
                    InkWell(
                      child: const Text("Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 100),
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assests/image/login.png"),
                          fit: BoxFit.fitHeight),
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}

Widget inputFile({label, obscureText = false, controller}) {
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
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
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
