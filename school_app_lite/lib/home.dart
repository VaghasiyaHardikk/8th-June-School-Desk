// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:school_app_lite/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text('Home Page'),
            SizedBox(height: 50,),
            OutlinedButton.icon(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            }, icon: Icon(Icons.exit_to_app,size: 20,),label: Text('Logout'),)
          ],
        ),
      ),),
    );
  }
}