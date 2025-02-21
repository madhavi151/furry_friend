// ignore: file_names
import 'package:flutter/material.dart';
import 'package:furry_friend/Screens/auth-ui/welcome-screen.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appMainName),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.signOut();
              Get.offAll(() => WelcomeScreen());
            },
            child: Padding
            (padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.logout),
            ),
          )
        ],
        ),
    );
  }
}