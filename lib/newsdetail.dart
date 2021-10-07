import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class Newsdetail extends StatefulWidget {

  @override
  _NewsdetailState createState() => _NewsdetailState();
}

class _NewsdetailState extends State<Newsdetail> {
  Color _favIconColor = Colors.white;



  @override
  Widget build(BuildContext context) {
 Map data = ModalRoute.of(context).settings.arguments;
  final LocalStorage storage = LocalStorage('localstorage_app');

void addToFavourite() async{
    //  print(data);
    if(_favIconColor == Colors.pink){


 final userUid = storage.getItem('userUid'); 
       print(userUid);
       data["uid"] = userUid;

      var response = await http.post(Uri.parse("https://three-mixolydian-bait.glitch.me/setfavourite"),body: data);
      var responseData = await jsonDecode(response.body);
      print(responseData["success"]);

      if(responseData["success"] == "0" ){

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Already Added to favourite Before"),
              );});
      }else if(responseData["success"] == "1" ){
         showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(" Added to favourite Successfully"),
              );});
      }else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(" Something went wrong please try again later"),
              );});
      }




      }
      

    }


    return  Scaffold(
          appBar: AppBar(
            backgroundColor:Colors.blueGrey[700],
            title: Center(child: Text("News")),
            actions: [
    IconButton(
      icon: Icon(Icons.favorite),
      iconSize: 30.0,
      splashColor: Colors.pink,
      color: _favIconColor,
      onPressed: () {
        setState(() {
                          if(_favIconColor == Colors.pink){
                            _favIconColor = Colors.white;
                          }else{
                        _favIconColor = Colors.pink;
                    }
                    addToFavourite();
                    });
        
      }
    ),]
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


            child: SingleChildScrollView(
      child: Column(
        children: [
         
         Container(
           height: 300,
           width: MediaQuery.of(context).size.width,
           child: Image.network(data["urlToImage"] != null ? data["urlToImage"] : "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",fit: BoxFit.cover,)),


           Container(
             height:MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Text(data["title"],style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                  color: Colors.blueGrey[200]),
                            ),

                   Text("by "+data["author"]),
                   Text(data["publishedAt"]),
                   
                   Padding(
                     padding: const EdgeInsets.only(top:18.0),
                     child: Text(data["description"],
                     style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                   ),
                   
                   Padding(
                     padding: const EdgeInsets.only(top:18.0),
                     child: Text(data["content"],style: TextStyle(
                         fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    color: Colors.white
                     ),),
                   )
                 ],
               ),
             )
           ),
        ],
      ),
    )
          ),
        );
    
    
    
    
    
    
    
    
    
    
    
  }
}