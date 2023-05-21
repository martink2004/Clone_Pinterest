import 'package:flutter/material.dart';
import 'package:project_flutter/search_post/user.dart';

class UsersDesign extends StatefulWidget {


  Users? model;
  BuildContext? context;

  UsersDesign({
    this.model,
    this.context,
});

  @override
  State<UsersDesign> createState() => _UsersDesignState();
}

class _UsersDesignState extends State<UsersDesign> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 240,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.amberAccent,
                minRadius: 90.0,
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundImage: NetworkImage(
                    widget.model!.userImage!,
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              Text(
                widget.model!.name!,
                style: const TextStyle(
                  color: Colors.pink,
                  fontSize: 20,
                  fontFamily: "Bebas",

                ),
              ),
              const SizedBox(height: 10.0,),
              Text(
                widget.model!.email!,
                style: const TextStyle(
                  color: Colors.pink,
                  fontSize: 12,
                  fontFamily: "Bebas",

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
