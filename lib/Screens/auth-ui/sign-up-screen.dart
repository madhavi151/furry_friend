// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:furry_friend/Screens/auth-ui/sign-in-screen.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible){
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppConstant.appSecondaryColor,
          title: Text("Sign Up"),
          ),

          body:SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children:[
                   SizedBox(
                    height: Get.height/15
                    ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Welcome to Furry Friend", 
                    style: TextStyle(
            color: AppConstant.appSecondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 35,
            
                    ),
                ),
       ),

////email id ke box ke upar ke space ke liye 
                  SizedBox(
                    height: Get.height/15
                    ),
            
            ////EMAIL ID KA BOX KA CODE 
                Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              width: Get.width,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5), // Light background for input field
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: TextFormField(
                  cursorColor: Color(0xFFC78265),  // Matching cursor color
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Color(0xFF2C3E5F), 
                  fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: "Enter your Email",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Icon(Icons.email, color: Color(0xFFC78265)),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            
            
            ////USERNAME BOX KA CODE
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              width: Get.width,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5), // Light background for input field
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: TextFormField(
                  cursorColor: Color(0xFFC78265),  // Matching cursor color
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Color(0xFF2C3E5F), 
                  fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Icon(Icons.person, color: Color(0xFFC78265)),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            
            /////Phone number ke box ka code 
              Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              width: Get.width,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5), // Light background for input field
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: TextFormField(
                  cursorColor: Color(0xFFC78265),  // Matching cursor color
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Color(0xFF2C3E5F), 
                  fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: "Mobile No.",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Icon(Icons.phone, color: Color(0xFFC78265)),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            
            
            
            ////PASSWORD KE BOX KA CODE 
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              width: Get.width,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5), // Light background for input field
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: TextFormField(
                  cursorColor: Color(0xFFC78265),  // Matching cursor color
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(color: Color(0xFF2C3E5F),
                   fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Icon(Icons.lock, color: Color(0xFFC78265)),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
             
            /////NICHE KE  SIGN UP BUTTON KA CODE 
            SizedBox(
              height: Get.height / 50,
            ),
            
            Container(
              width: Get.width / 2,
              height: Get.height / 18,
              decoration: BoxDecoration(
                color: AppConstant.appSecondaryColor,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: AppConstant.appSecondaryColor,
                ),
                onPressed: () {
            // Action for sign in
                },
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    color: AppConstant.appTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            
            
            
            ///SIGN UP AUR USKE NICHE LIKHA HUA KE BECH KE SPACING KE LIYE
              SizedBox(
                    height: Get.height/ 20
                    ),
            /////SIGN UP BUTTON KE NICHE VLA LIKHA HUA USKA CODE 
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: AppConstant.appTextColor2,
                    fontSize: 20,
                  ),
                ),
                  GestureDetector(
                    onTap:() => Get.offAll(() => SignInScreen()),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                                color: AppConstant.appSecondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                
              ],
            )
            
                  
                ],
              ),
            ),
          ),


        );
    }
      
    );
  }
}