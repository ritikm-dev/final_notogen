import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notogen/dashboard.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
     void login() async{
             var ibody={
                'email':email.text,
                'password' : password.text,
             };
             final response = await http.post(Uri.parse('http://192.168.91.11:3500/login'),
             headers: { 'Content-Type' : 'application/json'}
             ,body: jsonEncode(ibody));
             if(response.statusCode == 200){
               Get.snackbar("Succesful", "Sucessful Login",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      
    );
    Get.to(Dashboard());
    
             }
             else if(response.statusCode == 401){
               Get.snackbar("Error", "Email already registered",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );

             }
             else{
               Get.snackbar("Error", "Server Problem",
      backgroundColor: Colors.red,
      colorText: Colors.white,
               );
             }
     }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Login Page',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),centerTitle: true,backgroundColor: Colors.blue,),
      body: Container(
        
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                Text("LOGIN",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
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
                  prefixIcon: Icon(Icons.password,color: Colors.red,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  labelText: "Enter Your Password",
                  labelStyle: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold)
                ),
              ),
              SizedBox(height: 30,),
              SizedBox(
                width: 300,
              child: ElevatedButton.icon(
                
                onPressed:login ,
                icon: Icon(Icons.app_registration,color: Colors.black,size: 25,),
                label: Text("LOGIN",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
                 style: ElevatedButton.styleFrom(
                  
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
            
                  ),
                  side: BorderSide(color: Colors.black12,width: 3),
                  foregroundColor: const Color.fromARGB(255, 20, 20, 20),
                  backgroundColor: const Color.fromARGB(255, 68, 255, 74)
                ),
                
                )
              )

          ],
        ),
      ),
    );
  }
}
