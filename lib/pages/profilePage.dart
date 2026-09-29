import 'package:flutter/material.dart';
import 'package:money_log/services/supportive.dart';

class ProfilePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        margin: EdgeInsets.only(top: 70, left: 35, right: 35, bottom: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: 
              ClipRRect(borderRadius: BorderRadiusGeometry.circular(80), child: Image.asset('assets/images/pfp.png', height: 150, width: 150, fit: BoxFit.cover,),)
            ),
            SizedBox(height: 60,),
            Material(elevation: 3,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () { Navigator.pushNamed(context, '/expense');
              },
              child: Container(
                // color: const Color.fromARGB(255, 138, 167, 181),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Text("Add expense", style: Appwidget.textStyle(18, fontweight: FontWeight.bold),),
              ),
            ),
            ),
            SizedBox(height: 40,),
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: (){
                  Navigator.pushNamed(context, '/income');
                },
                child: Container(
                  // color: const Color.fromARGB(255, 138, 167, 181),
                  padding:const EdgeInsets.all(20),
                  width: double.infinity,
                  child: Text("Add income", style: Appwidget.textStyle(18, fontweight: FontWeight.bold),),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: (){
                  Navigator.pushNamed(context, '/history');
                },
                child: Container(
                  // color: const Color.fromARGB(255, 138, 167, 181),
                  padding:const EdgeInsets.all(20),
                  width: double.infinity,
                  child: Text("History", style: Appwidget.textStyle(18, fontweight: FontWeight.bold),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}