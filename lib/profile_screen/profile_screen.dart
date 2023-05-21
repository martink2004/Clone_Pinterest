import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/home_screen/home_screen.dart';
import 'package:project_flutter/log_in/login_screen.dart';

class ProfileScreeen  extends StatefulWidget {


  @override
  State<ProfileScreeen> createState() => _ProfileScreeenState();
}

class _ProfileScreeenState extends State<ProfileScreeen> {


  String? name='';
  String? email='';
  String? image='';
  String? phoneNo='';
  File? imageXFile;

  Future _getDataFromDatabase() async{
    await FirebaseFirestore.instance.collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
    .get()
     .then((snapshot) async
    {
       if(snapshot.exists)
       {
         setState(() {
           name=  snapshot.data()!["name"];
           email= snapshot.data()!["email"];
           image= snapshot.data()!["UserImage"];
           phoneNo=  snapshot.data()!["phoneNumber"];
         });
       }
    } );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink,Colors.deepOrange.shade300],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.2,0.9],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade400,
        title: const Center(
          child: Text('Profile Screen',style: TextStyle(
            fontSize:30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Signatra",
          ),),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink,Colors.deepOrange.shade300],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.2,0.9],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                //showimageDialog
              },
              child:  CircleAvatar(
                backgroundColor: Colors.amberAccent,
                minRadius: 60.0,
                child: CircleAvatar(
                  radius:50.0,
                  backgroundImage: imageXFile==null
                    ?
                      NetworkImage(
                        image!
                      )
                      :
                      Image.file(
                        imageXFile!
                      ).image,
                ),
              ),
            ),
            const SizedBox(height: 10.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name${name!}",
                  style: const TextStyle(
                    fontSize:25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                    onPressed: (){
                      //displayTextinput
                    },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Text(
              "Email${email!}",
            style: const TextStyle(
            fontSize:20.0,
              color: Colors.white,
            ),
            ),
            const SizedBox(height: 20.0,),
            Text(
              "PhoneNymber: ${phoneNo!}",
              style: const TextStyle(
                fontSize:20.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10.0,),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                },
            child: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
