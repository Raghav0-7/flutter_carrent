

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CommonMethods{

  checkconectivity(BuildContext context) async{
    var connectionResul = await Connectivity().checkConnectivity();
    if(connectionResul!=ConnectivityResult.mobile && connectionResul!=ConnectivityResult.wifi){
      if(!context.mounted) return;
      displaySnackBar("Your not connected to Internet", context);
    }
  }
  displaySnackBar(String message,BuildContext context){
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



}