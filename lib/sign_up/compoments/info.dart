import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/widgets/input_field.dart';
import 'package:image_cropper/image_cropper.dart';

class Credentials extends StatefulWidget {

  State<Credentials> createState() => _CredentialsState();
}


class _CredentialsState  extends State<Credentials> {

  final TextEditingController  _fullNameController = TextEditingController(text: "");
  final TextEditingController  _emailTextController = TextEditingController(text: "");
  final TextEditingController  _passController = TextEditingController(text: "");
  final TextEditingController  _phoneController = TextEditingController(text: "");

  File? imageFile;

  void _showImageDialog(){
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


  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()
            {
              _showImageDialog();
            },
            child: CircleAvatar(
              radius: 90,
              backgroundImage:imageFile==null
               ?
                const AssetImage("images/avatar.png")
           :
              Image.file(imageFile!).image,
            ),
          ),
        const  SizedBox(height: 10.0,),
          InputField(
              hintText: "Enter Username"
              , icon: Icons.person
              , obscureText: false,
              textEditingController: _fullNameController,
          ),
          const  SizedBox(height: 10.0,),
          InputField(
              hintText: "Enter Email",
            icon: Icons.email_rounded,
            obscureText: false,
            textEditingController: _emailTextController,
          ),
          const  SizedBox(height: 10.0,),
          InputField(
            hintText: "Enter Password",
            icon: Icons.lock,
            obscureText: true,
            textEditingController: _passController,
          ),
          const  SizedBox(height: 10.0,),
          InputField(
            hintText: "Enter Phone number",
            icon: Icons.phone,
            obscureText: false,
            textEditingController: _phoneController,
          ),
        ],
      ),
    );
  }
}



