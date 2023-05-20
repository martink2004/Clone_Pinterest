import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_flutter/log_in/login_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();


}




 class _HomeScreenState extends State<HomeScreen>{

   File? imageFile;
   String? imageUrl;
   String? myImage;
   String? myName;

   final FirebaseAuth _auth=FirebaseAuth.instance;

   void _showImageDialog()
   {

     showDialog(
         context: context,
         builder: (context){
           return AlertDialog(
             title: const Text( "Please choose an option"),
             content:  Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 InkWell(
                   onTap: (){
                     _getFromCamera();
                   },
                   child:  const Row(
                     children: [
                       Padding(
                           padding: EdgeInsets.all(4.0),
                           child: Icon(
                             Icons.camera,
                             color: Colors.red,
                           )
                       ),
                       Text(
                         "Camera",
                         style: TextStyle(color: Colors.red),
                       ),
                     ],
                   ),
                 ),
                 InkWell(
                   onTap:(){
                     _getFromGallery();
                   },
                   child:  const Row(
                     children: [
                       Padding(
                         padding: EdgeInsets.all(4.0),
                         child: Icon(
                           Icons.image,
                           color: Colors.red,
                         ),
                       ),
                       Text(
                         "Galery",
                         style: TextStyle(color: Colors.red),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           );
         }
     );
   }

   void _getFromCamera() async
   {
     XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
     _cropImage(pickedFile!.path);
     Navigator.pop(context);
   }

   void _getFromGallery() async
   {
     XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
     _cropImage(pickedFile!.path);
     Navigator.pop(context);
   }

   void _cropImage(filePath) async
   {
     CroppedFile? croppedImage = await ImageCropper().cropImage(
         sourcePath:filePath, maxHeight: 1080, maxWidth:1080);

     if(croppedImage!= null){
       setState(() {
         imageFile=File(croppedImage.path);
       });
     }
   }

   void  _upload_image() async{
     if(imageFile==null) {
       Fluttertoast.showToast(msg: "Please select an Image");
       return;
     }
    try{
       final ref=FirebaseStorage.instance.ref().child('usersImages').child(DateTime.now().toString() +'jpg' );
       await ref.putFile(imageFile!);
       imageUrl=await ref.getDownloadURL();
       FirebaseFirestore.instance.collection('wallpaper').doc(DateTime.now().toString()).set({
         'id':_auth.currentUser!.uid,
         'userImage': myImage,
         'name': myName,
         'email':_auth.currentUser!.email,
         'Image': imageUrl,
         'downloads': 0,
         'createdAt': DateTime.now(),
       });
       Navigator.canPop(context) ? Navigator.pop(context) : null;
       imageFile = null;
    }
     catch(error){
       Fluttertoast.showToast(msg: error.toString());
     }
   }

   void read_userInfo() async
   {
     FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
         .get().then<dynamic>((DocumentSnapshot snapshot) async
     {
          myImage = snapshot.get('userImage');
          myName=snapshot.get('name');
     });
   }
@override
void initState(){
     super.initState();
     read_userInfo();
}

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
                  _showImageDialog();
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
                  _upload_image();
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
          leading: GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen(),),);
            },
            child: const Icon(
              Icons.login_outlined
            ),
          ),
        ) ,
      ),
    );
  }
}
