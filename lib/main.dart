import 'package:flutter/material.dart';
import 'expensetracker_home_page.dart';
import'expensetracker_home_screen.dart';
void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
const ExpenseTrackerApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),),
        debugShowCheckedModeBanner: false,
      home: const ExpenseTrackerHome(),
    );
  }
}




