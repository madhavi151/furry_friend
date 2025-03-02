// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/auth-ui/welcome-screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppConstant.appMainColor, AppConstant.appSecondaryColor],
            ),
          ),
          child: Column(
            children: [
              // App Logo & Version
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Furry Friend",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Version 1.0.1",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.white24,
                    child: Text(
                      "FF",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),

              Divider(color: Colors.white38, thickness: 1, indent: 15, endIndent: 15),

              // Drawer Items
              Expanded(
                child: ListView(
                  children: [
                    _buildDrawerItem("Home", Icons.home, () {
                      Get.back();
                    }),
                    _buildDrawerItem("Products", Icons.shopping_cart, () {
                      Get.back();
                    }),
                    _buildDrawerItem("Orders", Icons.shopping_bag, () {
                      Get.back();
                    }),
                    _buildDrawerItem("Contact", Icons.contact_support, () {
                      Get.back();
                    }),
                  ],
                ),
              ),

              Divider(color: Colors.white38, thickness: 1, indent: 15, endIndent: 15),

              // Logout Button
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: _buildDrawerItem("Logout", Icons.logout, () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(() => WelcomeScreen());
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Drawer Item with Hover Effect
  Widget _buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.white30,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white10,
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
