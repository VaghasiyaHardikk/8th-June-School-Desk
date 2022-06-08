// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:school_app_lite/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHiddenPassword = true;
  GlobalKey <FormState> formkey = GlobalKey<FormState>();
  var UserNameController = TextEditingController();
  var PasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 255, 215, 55),
        systemNavigationBarDividerColor: Color.fromARGB(255, 170, 167, 167),
        systemNavigationBarColor: Color.fromARGB(255, 170, 167, 167),
        systemNavigationBarIconBrightness: Brightness.dark));
    // ignore: unused_element
    Future hideBar() async =>
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);
    return Scaffold(
                 resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: 50.0,
                ),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                        width: 30,
                      ),
                      Image.asset(
                        'assets/bee.png',
                        height: 80.0,
                        width: 120.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'SCHOOL DESK',
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(fontSize: 18, letterSpacing: 5),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20, letterSpacing: 2),
                        ),
                      ),
                    ],
                  ),

      Container(
        padding:
        const EdgeInsets.only(left: 30, right: 30, top: 27),
        decoration: const BoxDecoration(),
        child:
        //////////////////////////////////////////////////////////////////////////////////////////
            TextFormField(
                      controller: UserNameController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                      cursorColor: Color.fromARGB(255, 255, 204, 0),
                      decoration: InputDecoration(
                        labelText: 'Your E-mail',
                        hintText: 'abc@gmail.com',
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(27)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(27),
                            borderSide: BorderSide(color: Colors.black45)),
                      ),
                      
                    ),
                  ),
          ////////////////////////////////////////////////////////////////////////////////////////
            Container(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 27),
                    decoration: const BoxDecoration(),
                    child: TextFormField(
                      controller: PasswordController,
                      keyboardType: TextInputType.text,
                      cursorColor: Color.fromARGB(255, 255, 204, 0),
                      obscureText: isHiddenPassword,
                  
                      decoration: InputDecoration(
                          hoverColor: Color.fromARGB(255, 255, 204, 0),
                          labelText: 'Password:',
                          hintText: '****',
                          
                          
                          suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(Icons.visibility)),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle:
                              TextStyle(color: Colors.black45, fontSize: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(27)),
                          ),
                          
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(27),
                              borderSide: BorderSide(color: Colors.black45)),
                            ),
                          validator: MinLengthValidator(6, errorText: "At least 6 Character"),    
                    ),
                  ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                login();
              },
              child: Padding(
                padding: const EdgeInsets.only(left:30.0, right:30),
                child: Container(
                  height: 50,
                  
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text('Login'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    )))));
  }
  void _togglePasswordView(){
    if(isHiddenPassword == true){
      isHiddenPassword = false;
    }else{
      isHiddenPassword = true;
    }
    setState(() {
      
    });
  }

  Future<void> login() async {
    if (PasswordController.text.isNotEmpty && UserNameController.text.isNotEmpty) {
      var response =
          await http.post(Uri.parse("https://mtestsd.rbkei.in/api/CreateTokan"),
              body: ({
                'UserName': UserNameController.text,
                'Password': PasswordController.text,
              }));
              if(response.statusCode == 200){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Credentials' )));
              }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Blank Field Not Allowed')));
    }
  }
}
  