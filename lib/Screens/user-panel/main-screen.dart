// ignore: file_names

// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furry_friend/Utils/app-constant.dart';
import 'package:furry_friend/Widgets/banner-widget.dart';
import 'package:furry_friend/Widgets/custom-drawer-widget.dart';
import 'package:furry_friend/Widgets/heading-widget.dart';
import 'package:get/get.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondaryColor,
          statusBarBrightness: Brightness.light),
          backgroundColor: AppConstant.appMainColor,
          title: Text(
            AppConstant.appMainName,
            style: TextStyle(color: AppConstant.appTextColor),
          ),
          centerTitle: true,
          
      ),
      drawer: DrawerWidget( ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height/ 90.0,
              ),
              //banners
              BannerWidget(),
              //heading
              HeadingWidget(
                headingTitle: "Categories",
                headingSubTitle: "According to your pets",
                onTap: () {},
                buttonText: "See More -->",   
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}

        