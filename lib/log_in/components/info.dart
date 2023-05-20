import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/account_check/account_check.dart';
import 'package:project_flutter/forget_password/forget_password.dart';
import 'package:project_flutter/home_screen/home_screen.dart';
import 'package:project_flutter/widgets/input_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../sign_up/sign_up_screen.dart';
import '../../widgets/button_login.dart';

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
            textEditingController: _emailTextController,
          ),
          const SizedBox(height: 15.0,),
          InputField(
            hintText: "Enter Email",
            icon: Icons.lock,
            obscureText: false,
            textEditingController: _passTextController,
          ),
          const SizedBox(height: 15.0,),
          Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: () {
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>ForgetPasswordScreen()));
        },
        child: const Text(
          "Forget Password?",
              style:TextStyle(
               fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          ButtonLogin(
              text: "Login",
              colors1: Colors.red,
              colors2: Colors.redAccent,

            press: () async {
              try {
                await _auth.signInWithEmailAndPassword(
                  email: _emailTextController.text.trim().toLowerCase(),
                  password: _passTextController.text.trim().toLowerCase(),


                );
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>HomeScreen()));
              } catch (error) {
                Fluttertoast.showToast(msg: error.toString());
                }
              }
            ),
          AccountCheck(
              login: true,
            press: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>SignUpScreen()));
            },
             )
          ],
        ),
      );
    }
  }
