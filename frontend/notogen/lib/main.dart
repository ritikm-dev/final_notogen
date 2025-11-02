import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notogen/loginPage.dart';
import 'dashboard.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   final String uName ='';
   String u_name='';
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
 
   void registerUser() async {
    print("register called");
  var reqbody = {
    'name': username.text,
    'password': password.text,
    'email': email.text
  };

  var response = await http.post(
    Uri.parse('http://10.1.15.253:3500/registration'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(reqbody),
  );
print(response.body);
  if (response.statusCode == 200) {
   Get.snackbar("Success", "Registration Successful",
      backgroundColor: const Color.fromARGB(255, 85, 255, 90),
      colorText: const Color.fromARGB(255, 15, 13, 13),
      icon: Icon(Icons.sentiment_very_satisfied_rounded,color: Colors.black,size: 40,),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Get.to(Dashboard());
  } 
  else if(response.statusCode == 409){
    Get.snackbar("      Error", "       Email already registered",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: Icon(Icons.sentiment_very_dissatisfied_outlined,color: Colors.white,size: 40,)
    );
    
  }
  else if (response.statusCode == 401) {
    Get.snackbar("Error", "Email already registered",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    
  } else {
    Get.snackbar("Error", "Registration failed",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
     
  }
}
void page (){
      Get.to(LoginPage());
}
void demo() async {
  var demo = {
    email : email.text
  };
  http.post(Uri.parse('http://10.1.15.253:3500/demo'),headers: {"Content-Type" : "application/json"},body: jsonEncode(demo));
}

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    email.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("We Ensure Your Growth",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        surfaceTintColor: Colors.red,
        foregroundColor: const Color.fromARGB(255, 15, 15, 16),
      ),
      backgroundColor: const Color.fromARGB(255, 252, 252, 254),
      body: SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/notogen_logo.png',width: 200,height: 200,),
              const Text(
                "REGISTER",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: username,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 2)
                  ),
                  prefixIcon: Icon(Icons.person,color: Colors.red,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    
                  ),
                  labelText: "Enter Your Username",
                  labelStyle: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold)
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2)),
                  prefixIcon: Icon(Icons.email,color: Colors.red,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  labelText: "Enter Your Email-ID",
                  labelStyle: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold)
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2)),
                  prefixIcon: Icon(Icons.password,color: Colors.red,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  labelText: "Enter Your Password",
                  labelStyle: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold)
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                width: 250,
              child:ElevatedButton.icon(
                
                icon: Icon(Icons.app_registration,color: Colors.black,size: 25,),
                label: Text("REGISTER",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.black12,width: 10),
                  backgroundColor: const Color.fromARGB(255, 94, 255, 69),
                  foregroundColor: Colors.yellow,
                  
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                    
                    
                  ),
                  
                ),
                onPressed:registerUser,
                ),
              ),
              
              SizedBox(height: 5,),
              GestureDetector(
                onTap: page,
                 child: Text("Already Registered? Click Here",
                 style: TextStyle(
                  fontSize: 17,
                  color: Colors.blueAccent
                 ),),
              ),
              ElevatedButton(onPressed: demo, child: Text("demo"))
                          
            ],
          ),
        ),
      ),
    );
  }
}