import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();


}
 class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink,Colors.deepOrange.shade300],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.2,0.9],
        ),
      ),
      child: Scaffold(
        floatingActionButton: Wrap(
          direction: Axis.horizontal,
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: FloatingActionButton(
                heroTag: "1",
                backgroundColor: Colors.deepOrange.shade400,
                onPressed: (){
                  //showImageDialog
                },
                child: const Icon(Icons.camera_enhance),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: FloatingActionButton(
                heroTag: "2",
                backgroundColor: Colors.pink.shade400,
                onPressed: (){
                      //upload_image
                  },
                child: Icon(Icons.cloud_upload),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        appBar:AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange.shade300, Colors.pink],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.2,0.9],
              ),
            ),
          ),
        ) ,
      ),
    );
  }
}
