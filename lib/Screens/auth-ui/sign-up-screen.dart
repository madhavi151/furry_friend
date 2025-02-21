// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:furry_friend/Controllers/sign-up-controller.dart';
import 'package:furry_friend/Screens/auth-ui/sign-in-screen.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  final SignUpController signUpController =
  Get.put(SignUpController());
  TextEditingController username=TextEditingController();
  TextEditingController userEmail=TextEditingController();
  TextEditingController userPhone=TextEditingController();
  TextEditingController userPassword=TextEditingController();

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
                  controller: userEmail,
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
                  controller: username,
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
                  controller: userPhone,
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
                child: Obx(
                 () => TextFormField(
                        controller: userPassword,
                        obscureText: signUpController.isPasswordVisible.value,
                  cursorColor: Color(0xFFC78265),  // Matching cursor color
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(color: Color(0xFF2C3E5F),
                   fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Icon(Icons.lock, color: Color(0xFFC78265)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                              signUpController.isPasswordVisible.toggle();
                            },
                      child: signUpController.isPasswordVisible.value
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    border: InputBorder.none,
                  ),
                ), 
                ),
              ),
            ),
             
            /////NICHE KE  SIGN UP BUTTON KA CODE 
            SizedBox(
              height: Get.height / 50,
            ),
            
            Material(
                  child: Container(
                    width: Get.width / 2,
                    height: Get.height / 18,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton(
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                      onPressed: () async {
                        
                        String name = username.text.trim();
                        String email = userEmail.text.trim();
                        String phone = userPhone.text.trim();
                        String password = userPassword.text.trim();
                        String userDeviceToken = '';

                        if (name.isEmpty ||
                            email.isEmpty ||
                            phone.isEmpty ||
                            password.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter all details",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appSecondaryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else {
                          UserCredential? userCredential =
                              await signUpController.signUpMethod(
                            name,
                            email,
                            phone,
                            password,
                            userDeviceToken,
                          );

                          if (userCredential != null) {
                            Get.snackbar(
                              "Verification email sent.",
                              "Please check your email.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondaryColor,
                              colorText: AppConstant.appTextColor,
                            );

                            FirebaseAuth.instance.signOut();
                            Get.offAll(() => SignInScreen());
                          }
                        }
                      },
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