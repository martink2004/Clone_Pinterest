import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/widgets/input_field.dart';

class Credentials extends StatelessWidget {

  final FirebaseAuth _auth=FirebaseAuth.instance;


  TextEditingController _emailTextController=TextEditingController(text: '');
  TextEditingController _passTextController=TextEditingController(text: '');


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius:100,
              backgroundImage: const AssetImage(
                "images/logo1.png"
              ),
              backgroundColor: Colors.orange.shade800,
            ),
          ),
          const SizedBox(height: 15.0,),
          InputField(
            hintText: "Enter Email",
            icon: Icons.email_rounded,
            obscureText: false,
            textEditingController: _emailTextController ,
          ),
          const SizedBox(height: 15.0,),
          InputField(
            hintText: "Enter Email",
            icon: Icons.lock,
            obscureText: false,
            textEditingController: _passTextController ,
          ),
        ],
      ),
    );
  }
}
