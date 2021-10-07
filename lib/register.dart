import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    String imagePath;

  @override
  Widget build(BuildContext context) {
   


    void saveToMongodbAndFirebaseStorage(user) async{
  try {
        String imageName = path.basename(imagePath);

        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('/$imageName'); //Stribg Interpolation

        File file = File(imagePath);
        await ref.putFile(file);
        String downloadedURL = await ref.getDownloadURL();
       

    Map data = {
      "uid":user.user.uid.toString(),
      "username":usernameController.text,
      "email":emailController.text,
      "password":passwordController.text,
      "number":numberController.text,
      "address":addressController.text,
      "url":downloadedURL
    };

 var response = await http.post(Uri.parse("https://three-mixolydian-bait.glitch.me/signup"),body: data);
      var responseData = await jsonDecode(response.body);
      print(responseData["success"]);

        print("File uploaded successfully");
        
        print(downloadedURL);
      } catch (e) {
        print(e.message);
      }
    }




    void register() async {
   showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Center(child: Container(width: 50,height: 50,child: CircularProgressIndicator()))
              );});

      FirebaseAuth auth = FirebaseAuth.instance;

      final String username = usernameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;

      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print("User is registered ");
        await saveToMongodbAndFirebaseStorage(user);

       Navigator.pushReplacementNamed(context,"/login");

      } catch (e) {
        print("error");
         showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Error something went wrong")
              );});
      }

      // print("Register");
    }


 void pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.getImage(source: ImageSource.gallery);

      setState(() {
        imagePath = image.path;
      });
 }


    return Scaffold(
      body:  SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,

decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.blueGrey[800],
            Colors.blueGrey[700],
            Colors.blueGrey[600],
            Colors.blueGrey[400],
          ],
        ),
      ),


              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Container(
                width: MediaQuery.of(context).size.width*0.7,
                height: MediaQuery.of(context).size.height*0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    TextFormField(
                    style: TextStyle(color: Colors.white),
                      controller: usernameController,

                        decoration: InputDecoration(
                labelText: 'Enter Username',
                labelStyle: TextStyle(
                color: Colors.white,
              ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey)
                  ,
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                )),
                    ),



                     TextFormField(
                controller: emailController,

                    style: TextStyle(color: Colors.white),

                 decoration: InputDecoration(
                labelText: 'Enter Email',
                 labelStyle: TextStyle(
                color: Colors.white,
              ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey)
                  ,
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                )),


              ),
              TextFormField(
                controller: passwordController,
                    style: TextStyle(color: Colors.white),

                decoration: InputDecoration(
                labelText: 'Enter Password',
                        labelStyle: TextStyle(
                color: Colors.white,
              ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey)
                  ,
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                )),

              ),
                TextFormField(
                controller: numberController,
                    style: TextStyle(color: Colors.white),

                decoration: InputDecoration(
                labelText: 'Enter Mobile Number',
                        labelStyle: TextStyle(
                color: Colors.white,
              ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey)
                  ,
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                )),

              ),
                TextFormField(
                controller: addressController,
                    style: TextStyle(color: Colors.white),

                decoration: InputDecoration(
                labelText: 'Enter Address',
                        labelStyle: TextStyle(
                color: Colors.white,
              ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey)
                  ,
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                )),

              ),
              ElevatedButton(onPressed: pickImage, child: Text("pick image")),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                       shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                    primary: Colors.blueGrey[700], // background
                    onPrimary: Colors.white, // foreground
                  ),
                    child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('Register')),
                   onPressed: register
                    ),
                    
     ElevatedButton(
                    style: ElevatedButton.styleFrom(
                       shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                    primary: Colors.blueGrey[700], // background
                    onPrimary: Colors.white, // foreground
                  ),
                    child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('SignIn')),
                   onPressed: (){
        Navigator.pushReplacementNamed(context, '/login');
                   }
                    ),




                ],
              ),

                

                  ],
                ),
              ),
             
          ],
        ),
            )),
      );
  }
}