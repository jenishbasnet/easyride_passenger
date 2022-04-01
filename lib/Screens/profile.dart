import 'dart:convert';
import 'dart:io';

import 'package:easyride_app/helpers/apiprefs.dart';
import 'package:flutter/material.dart';
import 'package:easyride_app/Screens/navigation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../Model/user_model.dart';
import '../requests/baseurl.dart';

class Profile extends StatelessWidget {
  static String? emailHolder;
  static String? passwordHolder;
  late String Jenish;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {

  
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  final ImagePicker image = ImagePicker();
  File? imgfile;

  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();  
  TextEditingController phonenumberController = TextEditingController();

  String? emailHolder = Profile.emailHolder;
  String? passwordHolder= Profile.passwordHolder;


  Future<File?> imgpicker(ImageSource source) async {
    final pickedFile = await image.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imgfile = File(pickedFile.path);
      });
    }
  }
  UserModel usermodel = UserModel();
  bool circular = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var res = await http.post(Uri.parse("${BaseUrl.baseurl}api/passenger/login/"),
        body: {
          'email' : emailHolder,
          'password' : passwordHolder
        }
    
    );
    var r = json.decode(res.body);
    setState(() {      
      usermodel = UserModel.fromJson({"data": r});
      circular = false;
    });
    emailController.text = r["email"];    
    usernameController.text = r["username"];    
    phonenumberController.text = r["phoneNumber"];
    passwordController.text = r["password"];
    print(r["profilePhoto"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imgfile == null
                              ? AssetImage("assests/image/profile.jpg")
                              : FileImage(
                                  File(
                                    imgfile!.path,
                                  ),
                                ) as ImageProvider,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: InkWell(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onTap: () {
                              bottomsheets(context);
                            },
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              // buildTextField("emauk", "a", false, emailController),
              buildTextField("User Name", "", false, usernameController ),
              buildTextField("E-mail", "", false, emailController),
              buildTextField("Password", "********", true, passwordController),
              buildTextField("Phone Number", "", false, phonenumberController),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            SpinKitFadingCircle(
                              color: Colors.lightBlue,
                              size: 200,
                              duration: Duration(milliseconds: 3000),
                            ),
                          ],
                        ),
                      );
                    },
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
     label, placeholder, bool isPasswordTextField, controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  ListTile listTile(IconData icon, String title, void Function() function) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Colors.blue,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: function,
    );
  }

  void bottomsheets(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            listTile(Icons.camera, "Upload from camera", () async {
              await imgpicker(ImageSource.camera);
            }),
            listTile(Icons.image, "Upload from gallery", () async {
              await imgpicker(ImageSource.gallery);
            }),
            listTile(Icons.delete_forever, "Delete the photo", () async {
              setState(() {
                imgfile = null;
              });
            }),
          ],
        ),
      ),
    );
  }
}
