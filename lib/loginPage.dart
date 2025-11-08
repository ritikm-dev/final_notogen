
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
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      Get.snackbar("Error", "Please enter email and password",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    setState(() => isLoading = true);

    try {
      var ibody = {
        'email': email.text,
        'password': password.text,
      };

      final response = await http.post(
        Uri.parse('http://192.168.91.11:3500/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(ibody),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Login Successful",
            backgroundColor: Colors.green, colorText: Colors.white);

        Get.to( DashboardScreen(
              useremail: email.text,
              user_name: 'Guest',
            ));
      } else if (response.statusCode == 401) {
        Get.snackbar("Error", "Invalid email or password",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Server problem (${response.statusCode})",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Network error: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    labelText: "Enter Your Email-ID",
                    labelStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    labelText: "Enter Your Password",
                    labelStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : login,
                    icon: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Icon(Icons.login, color: Colors.black, size: 25),
                    label: Text(
                      isLoading ? "Logging in..." : "LOGIN",
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(color: Colors.black12, width: 3),
                      backgroundColor:
                          const Color.fromARGB(255, 68, 255, 74),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
