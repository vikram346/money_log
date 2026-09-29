import 'package:flutter/material.dart';
import 'package:money_log/services/supportive.dart';

class OnBoarding extends StatefulWidget {
  const new({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset('assets/images/Money.png'),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38),
                  color: Color.fromRGBO(248, 237, 194, 1),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Manage your expenses\nin a easy way!",
                      textAlign: TextAlign.center,
                      style: Appwidget.textStyle(
                        30,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Take control of your finances and keep your expenses organized in one place. "
                      "Track your daily spending, understand where your money goes, "
                      "and build better spending habits. Start your journey toward smarter money management today.",
                      style: Appwidget.textStyle(18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: () {Navigator.pushNamed(context, '/home');},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,129,180,70),
                          elevation: 8,
                        minimumSize: const Size(150, 60),
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(fontSize:18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
