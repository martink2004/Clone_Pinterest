import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/log_in/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _inianlization=Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return FutureBuilder(
     future: _inianlization,
     builder: (context, snapshot)
     {
       if(snapshot.connectionState == ConnectionState.waiting){
         return const MaterialApp(
           debugShowCheckedModeBanner: false,
           home: Scaffold(
             body: Center(
               child:Center(
                child: Text("Welcome to PhotoSharing Clone App"),
                   ),
                ),
              ),
           );
         }
       else if (snapshot.hasError){
         return const MaterialApp(
           debugShowCheckedModeBanner: false,
           home: Scaffold(
             body: Center(
               child:Center(
                 child: Text("An Error occured,Please wait"),
               ),
             ),
           ),
         );
       }
       return  MaterialApp(
         debugShowCheckedModeBanner: false,
         title: "Flutter PhotoSharing Clone App",
         home: LoginScreen(),
       );
      }
    );
  }
}
