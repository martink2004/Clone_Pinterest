import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/home_screen/home_screen.dart';

class SearchPost extends StatefulWidget {


  @override
  State<SearchPost> createState() => _SearchPostState();
}

class _SearchPostState extends State<SearchPost> {

  Future<QuerySnapshot>? postDocumentstList;
  String userNameText='';

  initSearchingPost(String textEntered){
    postDocumentstList=FirebaseFirestore.instance.collection("users").where("name",isGreaterThanOrEqualTo: textEntered).get();

    setState(() {
      postDocumentstList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink,Colors.deepOrange.shade300],
              ),
            ),
          ),
          title: TextField(
            onChanged: (textEnetered){
              setState(() {
                userNameText=textEnetered;
              });
              initSearchingPost(textEnetered);
            },
            decoration: InputDecoration(
              hintText: "Search Post here,,",
              hintStyle: const TextStyle(color: Colors.white54),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: const Icon(Icons.search,color: Colors.white,),
                onPressed: (){
                  initSearchingPost(userNameText);
                },
              ),
              prefixIcon: IconButton(
                icon: const Padding(
                  padding: EdgeInsets.only(right: 12.0,left: 4.0),
                  child: Icon(Icons.arrow_back,color: Colors.white,),
                ),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
