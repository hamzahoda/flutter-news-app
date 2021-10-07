import 'package:flutter/material.dart';
import 'package:newsapp/favourite.dart';
import 'package:newsapp/headlines.dart';
import 'package:newsapp/popular.dart';
import 'package:newsapp/profile.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor:Colors.blueGrey[700],
            title: Center(child: Text("News")),
            bottom: TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.white,
                indicatorColor: Colors.blueGrey[700],
                isScrollable: true,

                tabs: [
                  Tab(
                    child: Text("Headlines"),
                  ),
                  Tab(
                    child: Text("Popular"),
                  ),
                     Tab(
                    child: Text("Favourites"),
                  ),
                   Tab(
                    child: Text("Profile"),
                  )
                ]),
          ),
          body: Container(

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


            child: TabBarView(
              children: [Headlines(), Popular(),Favourite(),Profile()],
            ),
          ),
        ));
  }
}
