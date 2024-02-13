import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pract/login/registration.dart';
import 'package:pract/methods/global.dart';
import 'package:pract/pages/showroom.dart';

import '../methods/common_methods.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  CommonMethods cmethods = CommonMethods();
  CheckIfNetworkisavailable() {
    cmethods.checkconectivity(context);
    signInForm();
  }
  signInForm() {
    if (!emailcontroller.text.contains("@")) {
      cmethods.displaySnackBar("provide valid email", context);
    } else if (passwordcontroller.text.trim().length < 6) {
      cmethods.displaySnackBar("password must be more than 6 chars", context);
    } else {
      SignInUser();
    }
  }
  SignInUser() async{
    final User? userFirebase=(
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim(),
        ).catchError((errorMsg){
          Navigator.pop(context);
          cmethods.displaySnackBar(errorMsg.toString(),context);
        })
    ).user;
    // if(!context.mounted) return;
    // Navigator.pop(context);

    if(userFirebase != null){
      DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users").child(userFirebase.uid);
      usersRef.once().then((snap)
      {
        if(snap.snapshot.value != null){
          UserName =(snap.snapshot.value as Map)["name"];
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>Showroom()),(route)=>false);
        }else{
           FirebaseAuth.instance.signOut();
          cmethods.displaySnackBar("record not exist", context);
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF7033FF),
                  Color(0xff281537),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Hello\nSign in!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child:  Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.check,color: Colors.grey,),
                            labelText: 'Gmail',labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xff281537),
                            ),
                        ),
                      ),
                      TextField(
                        controller: passwordcontroller,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.visibility_off,color: Colors.grey,),
                            labelText: 'Password',labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xff281537),
                            ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password?',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xff281537),
                        ),),
                      ),
                      const SizedBox(height: 50,),
                      ElevatedButton(
                        onPressed: () {
                          CheckIfNetworkisavailable();
                        },
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF7033FF),
                                  Color(0xff281537),
                                ]
                            ),
                          ),
                          child: const Center(child: Text('SIGN IN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white
                            ),),),
                        ),
                      ),
                       SizedBox(height: 20),
              TextButton(onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>const RegScreen()),(route) => false);
              },
                  child: const Text("Don't have an account?SignUp",style: TextStyle(color: Color(0xff281537),
           fontWeight: FontWeight.bold,
             fontSize: 15,),))
                  ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}