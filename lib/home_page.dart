import 'dart:convert';
import 'package:api/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Welcome> welcome = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future:  getData(),
        builder: (context,snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: welcome.length, itemBuilder: (context, index) {
              return Container(
                // height: 200,
                  color: Colors.grey,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("User id : ${welcome[index].userId}", style: TextStyle(fontSize: 15,),),
                      Text("User Id : ${welcome[index].id}", style: TextStyle(fontSize: 15,),),
                      Text(
                        "User Title : ${welcome[index].title}", style: TextStyle(fontSize: 15,),),
                      Text(
                        "User Body :${welcome[index].body}", style: TextStyle(fontSize: 15,),),
                    ],
                  )
              );
            });}
          else{
            return Center(child: CircularProgressIndicator(),);
          }

          },
      ),

    );
  }
  Future<List<Welcome>> getData() async{
     final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
     var data = jsonDecode(response.body.toString());
     if(response.statusCode==200){
       for(Map<String,dynamic> index in data) {
      welcome.add(Welcome.fromJson(index));
       }
         return welcome;

     }
     else{
       return welcome;
     }
}

}