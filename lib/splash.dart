import 'package:flutter/material.dart';
import 'dart:async';

import 'package:newsapp/home.dart';
import 'package:newsapp/register.dart';

class Splash extends StatefulWidget {
@override
_SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
@override
void initState() {
	super.initState();
	Timer(Duration(seconds: 3),
		()=>Navigator.pushReplacement(context,
										MaterialPageRoute(builder:
														(context) =>
														Register()
														)
									)
		);
}
@override
Widget build(BuildContext context) {
	return Container(
    
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
      ),	child:Image(image: AssetImage ("assets/splash.png")
      ,width: MediaQuery.of(context).size.height,)
	);
}
}