import 'package:flutter/material.dart';

class OwnerDetails extends StatefulWidget {

  String? img;
  String? userImg;
  String? name;
  DateTime? date;
  String? docId;
  String? userId;
  int? downloads;

  OwnerDetails({
    this.img,
    this.userImg,
    this.name,
    this.date,
    this.docId,
    this.userId,
    this.downloads,
});

  @override
  State<OwnerDetails> createState()=>_OwnerDetailsState();



}

class _OwnerDetailsState extends State<OwnerDetails>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink,Colors.deepOrange.shade300],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.2,0.9]
          )
        ),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.red,
                  child: Column(
                    children:[
                    Container(
                      child: Image.network(
                        widget.img!,
                        width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0,),
                const Text(
                    "Owner Information",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0,),
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.userImg!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 15.0,),
                Text(
                  'Uploaded by: ' + widget.name!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}