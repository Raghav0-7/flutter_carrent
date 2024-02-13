

import 'package:flutter/material.dart';
import 'package:pract/pages/calender.dart';
import 'package:pract/pages/showroom.dart';

class NavigationItem {

  IconData iconData;

  NavigationItem(this.iconData);

}

List<NavigationItem> getNavigationItemList(){
  return <NavigationItem>[
    NavigationItem(Icons.home),
    // NavigationItem(Icons.calendar_today),
    NavigationItem(Icons.person),
  ];
}
void onItemSelected(int selectedIndex,BuildContext context) {
  // Perform actions based on the selected index
  switch (selectedIndex) {
    case 0:
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => Showroom()), (route) => false);
      break;
    // case 1:
    //   Navigator.push(context, MaterialPageRoute(builder: (c) => Calender_P()));
    //   break;

  // Handle other cases
  // ...
  }
}
class Car {

  String brand;
  String model;
  double price;
  String condition;
  List<String> images;

  Car(this.brand, this.model, this.price, this.condition, this.images);

}

List<Car> getCarList(){
  return <Car>[
    Car(
      "Land Rover",
      "Discovery",
      2580,
      "Weekly",
      [
        "assets/images/land_rover_0.png",
        "assets/images/land_rover_1.png",
        "assets/images/land_rover_2.png",
      ],
    ),
  ];
}





class Filter {

  String name;

  Filter(this.name);

}

List<Filter> getFilterList(){
  return <Filter>[
    Filter("Best Match"),
    Filter("Highest Price"),
    Filter("Lowest Price"),
  ];
}