import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localstorage/localstorage.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController();
    final TextEditingController passwordController =
        TextEditingController();

    final LocalStorage storage = new LocalStorage('localstorage_app');


    void login() async {
      FirebaseAuth auth = FirebaseAuth.instance;

      final String email = emailController.text;
      final String password = passwordController.text;

      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        print("User is logged in");


        emailController.clear();
        passwordController.clear();
        // Navigator.of(context).pushNamed("/home");
        storage.setItem('userUid', user.user.uid.toString());
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        print("error");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(e.message),
              );
            });
        print(e.message);
      }

      // print("Register");
    }

    return Scaffold(
      body: 
      
       SafeArea(
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
                height: MediaQuery.of(context).size.height*0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

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
                          child: Text('Login')),
                   onPressed: login
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
                          child: Text('Register')),
                   onPressed: (){
        Navigator.pushReplacementNamed(context, '/register');
                   }
                    ),




                ],
              ),

                  ],
                ),
              ),
             
          ],
        ),
            )));
      
      
    //   Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 10),
    //     child: SafeArea(
    //         child: Column(
    //       children: [
    //         TextFormField(
    //           controller: emailController,
    //           decoration: InputDecoration(
    //               border: UnderlineInputBorder(), labelText: "Enter Email"),
    //         ),
    //         TextFormField(
    //           controller: passwordController,
    //           decoration: InputDecoration(
    //               border: UnderlineInputBorder(), labelText: "Enter Password"),
    //         ),
    //         ElevatedButton(onPressed: login, child: Text("Login"))
    //       ],
    //     )),
    //   ),
    // );





  }
}