import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    String imagePath;
  final LocalStorage storage = LocalStorage('localstorage_app');
  String hostedImage;

getuserdata() async {
    final userUid = storage.getItem('userUid'); 
    Map data = {
      "uid":userUid
    };

    var response = await http.post(Uri.parse("https://three-mixolydian-bait.glitch.me/singleuserdata"),body: data);
      var jsonData = await jsonDecode(response.body);
      print(jsonData["result"]);

    usernameController.text = jsonData["result"]["username"];
    emailController.text = jsonData["result"]["email"];
    numberController.text = jsonData["result"]["number"];
    addressController.text = jsonData["result"]["address"];
    setState(() {
    hostedImage = jsonData["result"]["url"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getuserdata();
  }


  @override
  Widget build(BuildContext context) {


    void update() async {

      final String username = usernameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;
      final String number = numberController.text;
      final String address = addressController.text;


  try {
        String imageName = path.basename(imagePath);

        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('/$imageName'); //Stribg Interpolation

        File file = File(imagePath);
        await ref.putFile(file);
        String downloadedURL = await ref.getDownloadURL();
       
    final userUid = storage.getItem('userUid'); 

    Map data = {
      "uid":userUid,
      "username":usernameController.text,
      "email":emailController.text,
      "password":passwordController.text,
      "number":numberController.text,
      "address":addressController.text,
      "url":downloadedURL
    };

 var response = await http.post(Uri.parse("https://three-mixolydian-bait.glitch.me/updateuser"),body: data);
      var responseData = await jsonDecode(response.body);
      print(responseData["success"]);

      if(responseData["success"] == "1"){
        setState(() {
          hostedImage = downloadedURL;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content:Text("Profile Updated successfully")
              );});
      }else{
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Profile not updated")
              );});
      }

        print("File uploaded successfully");
        
      } catch (e) {
        print(e.message);
         showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("something went wrong")
              );});
      }








      // print("update");
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


              child: SingleChildScrollView(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  height: MediaQuery.of(context).size.height*0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
          
                      CircleAvatar(    radius: 50.0,
                  backgroundImage:
                      NetworkImage(hostedImage !=null ? hostedImage : "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg"),
                  backgroundColor: Colors.transparent,),
          
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
                            child: Text('update')),
                     onPressed: update
                      ),
              
                  ],
                ),
          
                  
          
                    ],
                  ),
                ),
               
            ],
                  ),
          )
            )
      )
    );
  }
}