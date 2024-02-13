import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// import '../First/constants.dart';
// import '../First/data.dart';

class Calender_P extends StatefulWidget {
  const Calender_P({super.key});

  @override
  State<Calender_P> createState() => _Calender_PState();
}

class _Calender_PState extends State<Calender_P> {
  //


  final FirebaseAuth _auth = FirebaseAuth.instance;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


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
      ),
      body: Center(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 365)),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
            ),
            if (_selectedDay != null)
              Text('Selected Day: ${_selectedDay!.toLocal()}'),
            ElevatedButton(
              onPressed: () {
                // Add logic to check availability and book the car on _selectedDay
                // Update Firebase with booking details
              },
              child: Text('Book Car'),
            ),
          ],
        ),
      ),);
  }
}
