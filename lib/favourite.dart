import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class Favourite extends StatefulWidget {

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite>{
@override
  final LocalStorage storage = LocalStorage('localstorage_app');

  var lst = ["hello","how","are","you","my","name","is","hamza","hoda"];



 getfavourites() async {
    var favourites = [];

    
   final userUid = storage.getItem('userUid'); 

    Map data = {
      "uid":userUid
    };

      var response = await http.post(Uri.parse("https://three-mixolydian-bait.glitch.me/getfavourite"),body: data);

    print(response.body);
    var jsonData = await jsonDecode(response.body);
    // print(jsonData);
    for (var i in jsonData["data"]) {
      if(i["author"] !=null){
      FavouriteModel headline =
          FavouriteModel(i["author"], i["title"], i["description"], i["urlToImage"],i["publishedAt"],i["content"]);
      favourites.add(headline);
      }
    }
    print(favourites);
    return favourites;
  }




  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: FutureBuilder(
      future: getfavourites(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: Container(width: 50,height: 50,child: CircularProgressIndicator()));
        }else if(snapshot.data.length == 0){
          return Padding(
            padding: const EdgeInsets.only(top:80.0),
            child: Center(child: Container(child: Text("No News marked as favourite",style: TextStyle(fontSize: 23,color: Colors.white),))),
          );

        } 
        
        else
          return  Column(
        children: [
          ListView.builder(
      shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
    
             itemCount: snapshot.data.length,
              itemBuilder: (context, i){
            return GestureDetector(
              onTap: (){
                Map data = {
                  "title":snapshot.data[i].title,
                  "description":snapshot.data[i].description,
                  "author":snapshot.data[i].author,
                  "urlToImage":snapshot.data[i].urlToImage,
                  "publishedAt":snapshot.data[i].publishedAt,
                  "content":snapshot.data[i].content
                };
                print(data);
                Navigator.of(context).pushNamed("/newsdetail",arguments: data);

              },
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                
                  Container(
                    color: Colors.blueGrey[600],
                    margin: EdgeInsets.only(bottom: 20),
                    height: 110,
                    width: 100,
                    child: Row(
                      children: [
                       Container(
                       height: MediaQuery.of(context).size.height,
                       width: MediaQuery.of(context).size.width*0.5,
                       child: Image.network(snapshot.data[i].urlToImage != null ? snapshot.data[i].urlToImage:"https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",fit: BoxFit.cover,)),
            
            
                        Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top:8.0,left: 8.0,bottom: 8.0),
                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                snapshot.data[i].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                            ),
            
                                Row(
                                  children:[
                                    Text("24h",style: TextStyle(color: Colors.blueGrey[200]),),
                                    SizedBox(width: 10,),
                                    SizedBox(
                                      child: Text("|",style: TextStyle(color: Colors.blueGrey[100]),),),
                                    SizedBox(width: 10,),
            
                                    Text("UK",style: TextStyle(color: Colors.blueGrey[200]),),
                                    
                                    ]
                                ),
                          ],
                        ),
                      ),
                    ),
                  )
                          
                      ],
                    ),
                    
                  )
                ],
              ),
            ); 
            
            
          }),
        ],
      );
      },
    )
      
      
      
      
    );
  }
}




class FavouriteModel {
  var author;
  var title;
  var description;
  var urlToImage;
  var publishedAt;
  var content;

  FavouriteModel(this.author, this.title, this.description,this.urlToImage,this.publishedAt,this.content);
}
