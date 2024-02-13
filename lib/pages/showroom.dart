import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pract/First/constants.dart';
import 'package:pract/First/data.dart';

import 'package:pract/First/car_widget.dart';

import 'package:pract/First/available_cars.dart';
import 'package:pract/First/book_car.dart';
import 'package:pract/login/login_page.dart';


class Showroom extends StatefulWidget {
  @override
  _ShowroomState createState() => _ShowroomState();
}

class _ShowroomState extends State<Showroom> {
  List<NavigationItem> navigationItems = getNavigationItemList();
   late NavigationItem selectedItem;

  List<Car> cars = getCarList();


  @override
  void initState() {
    super.initState();
    setState(() {
      selectedItem = navigationItems[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          "Car Rental App",

        ),
        centerTitle: false,
        actions:  [

          GestureDetector(
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (c) => Login_Page()),
                      (route) => false,
                );
              } catch (error) {
                print('Error logging out: $error');
                // Handle error if necessary
              }
            },
            child: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [


          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "TOP DEALS",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Center(

                      child: Container(

                      alignment: Alignment.topRight,

                        height: 280,

                        child:
                        ListView(
                       physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: buildDeals(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AvailableCars()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          padding: const EdgeInsets.all(24),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text(
                                    "Available Cars",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),

                                  Text(
                                    "Long term and short term",
                                    style: TextStyle(color: Colors.white),
                                  ),

                                ],
                              ),

                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                   ],
              ),
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildNavigationItems(),
        ),
      ),
    );
  }

  List<Widget> buildDeals(){
    List<Widget> list = [];
    for (var i = 0; i < cars.length; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookCar(car: cars[i])),
            );
          },
          child: buildCar(cars[i], i)
        )
      );
    }
    return list;
  }

  // List<Widget> buildDealers(){
  //   List<Widget> list = [];
  //   for (var i = 0; i < dealers.length; i++) {
  //     list.add(buildDealer(dealers[i], i));
  //   }
  //   return list;
  // }

  List<Widget> buildNavigationItems() {
    List<Widget> list = [];
    for (int index = 0; index < navigationItems.length; index++) {
      list.add(buildNavigationItem(index, navigationItems[index]));
    }
    return list;
  }
  Widget buildNavigationItem(int index,NavigationItem item){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = item;
        });
        onItemSelected(index,context);      },
      child: Container(
        width: 50,
        child: Stack(
          children: <Widget>[

            selectedItem == item
            ? Center(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColorShadow,
                ),
              ),
            )
            : Container(),

            Center(
              child: Icon(
                item.iconData,
                color: selectedItem == item ? kPrimaryColor : Colors.grey[400],
                size: 24,
              ),
            )

          ],
        ),
      ),
    );
  }

}