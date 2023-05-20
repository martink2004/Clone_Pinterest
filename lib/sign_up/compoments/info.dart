import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_flutter/widgets/input_field.dart';

class Credentials extends StatefulWidget {

  State<Credentials> createState() => _CredentialsState();
}


class _CredentialsState  extends State<Credentials> {

  final TextEditingController  _fullNameController = TextEditingController(text: "");
  final TextEditingController  _emailTextController = TextEditingController(text: "");
  final TextEditingController  _passController = TextEditingController(text: "");
  final TextEditingController  _phoneController = TextEditingController(text: "");

  File? imageFile;

  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            //onTap: ()
            {


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



