import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pract/login/login_page.dart';
//import 'package:pract/login/login_page.dart';
import 'package:pract/methods/common_methods.dart';
import 'package:pract/pages/showroom.dart';


class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  CommonMethods cmethods=CommonMethods();
  CheckIfNetworkisavailable() {
  cmethods.checkconectivity(context);
  signUpForm();
  }

  signUpForm(){
    if(namecontroller.text.trim().length<4){
      cmethods.displaySnackBar("name should be more than 4 characters", context);
    }else if(!emailcontroller.text.contains("@")){
        cmethods.displaySnackBar("provide valid email", context);
    }else if(passwordcontroller.text.trim().length<6){
      cmethods.displaySnackBar("password must be more than 6 chars", context);
    }else{
      registerNewuser();
    }
  }
  registerNewuser() async{
    final User? userFirebase=(
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
        ).catchError((errorMsg){
          Navigator.pop(context);
          cmethods.displaySnackBar(errorMsg.toString(),context);
        })
    ).user;
    if(!context.mounted) return;
    Navigator.pop(context);

    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
    Map userDataMap ={
      "name":namecontroller.text.trim(),
      "email":emailcontroller.text.trim(),
      "id":userFirebase.uid,
    };
    usersRef.set(userDataMap);
    Navigator.push(context, MaterialPageRoute(builder: (c)=> Showroom()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack( //thanks for watching
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
                  'Create Your\nAccount',
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
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: namecontroller,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey,),
                          labelText: 'Full Name', labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff281537),
                        ),
                        ),
                      ),
                      TextField(
                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey,),
                          labelText: 'Gmail', labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff281537),
                        ),
                        ),
                      ),
                      TextField(
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility_off, color: Colors.grey,),
                          labelText: 'Password', labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff281537),
                        ),
                        ),
                      ),
                      const SizedBox(height: 70,),
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
                          child: const Center(child: Text('SIGN UP',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white
                            ),),),
                        ),
                      ),
                      const SizedBox(height: 70),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            c) => Login_Page()));
                      },
                          child: const Text("Already have an account  SignIn",
                            style: TextStyle(color: Color(0xff281537),
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
