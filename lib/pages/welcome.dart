import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pract/login/login_page.dart';
import 'package:pract/pages/showroom.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}


class _SplashState extends State<Splash> {

  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;

    final user =  auth.currentUser ;

    // if(user != null){
    //   Timer(const Duration(seconds: 3),
    //           ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Showroom()))
    //   );
    // }else {
    //   Timer(const Duration(seconds: 3),
    //           ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login_Page()))
    //   );
    // }
    if (user != null) {
      Future.delayed(const Duration(seconds: 2), () {
        if (context != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Showroom()),
                (route) => false,
          );
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        if (context != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login_Page()),
                (route) => false,
          );
        }
      });
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Car Rental' , style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
