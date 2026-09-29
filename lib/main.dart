import 'package:flutter/material.dart';
import 'package:money_log/pages/add_expense.dart';
import 'package:money_log/pages/add_income.dart';
import 'package:money_log/pages/history.dart';
import 'package:money_log/pages/homepage.dart';
import 'package:money_log/pages/onboarding.dart';
import 'package:money_log/pages/profilePage.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      initialRoute: '/',
      routes: {
        '/' :(context) => OnBoarding(),
        '/home':(context) => HOmePage(),
        '/profile':(context) => ProfilePage(),
        '/expense':(context) => AddExpense(),
        '/income':(context) => AddIncome(),
        '/history':(context) => History()
      },
    );
  }
}