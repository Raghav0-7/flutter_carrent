import 'package:flutter/material.dart';
import 'package:pract/login/login_page.dart';
import 'package:pract/login/registration.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF7033FF),
                  Color(0xff281537),
                ]
            )
        ),
        child: Center(
          child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Text('Welcome Back',style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                ),),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login_Page()));
                  },
                  child: Container(
                    height: 53,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                    ),
                    child: const Center(child: Text('SIGN IN',style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),),
                  ),
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const RegScreen()));
                  },
                  child: Container(
                    height: 53,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                    ),
                    child: const Center(child: Text('SIGN UP',style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),),),
                  ),
                ),

              ]
          ),
        ),
      ),

    );
  }
}