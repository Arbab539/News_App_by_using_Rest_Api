import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 4),
            () { Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>const LandingPage()));
        });

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height*1;
    final width = MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/images/splash_pic.jpg',
            fit: BoxFit.cover,
            width: width * 0.9,
            height: height * 0.5,
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Text('TOP HEADLINES',style: GoogleFonts.anton(letterSpacing: .6,color: Colors.grey.shade700),),
          SizedBox(
            height: height * 0.04,
          ),
         const  SpinKitChasingDots(
            color: Colors.blue,
            size: 40,
          )
        ],
      ),
    );
  }
}