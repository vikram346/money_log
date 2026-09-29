import 'package:flutter/material.dart';
import 'package:money_log/database/db_helper.dart';
import 'package:money_log/services/supportive.dart';
import 'package:pie_chart/pie_chart.dart';
// import 'package:sqflite/sqlite_api.dart';

class HOmePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HOmePage> createState() => _HOmePageState();
}

class _HOmePageState extends State<HOmePage> {
  DbHelper? dbRef;
  List<Map<String, dynamic>> allTransaction = [];
  double groceries = 0;
  double shopping = 0;
  double other = 0;
  bool selectedMonth = true;
  double totalIncome = 0;
  double totalExpense = 0;

  void calculateTotal() {
     totalIncome = 0;
     totalExpense = 0;

    DateTime now = DateTime.now();
    for (var transaction in allTransaction) {
      DateTime TransactionDate = DateTime.parse(transaction['date']);
      bool isSelectedPeriod;
      if (selectedMonth) {
        isSelectedPeriod =
            TransactionDate.year == now.year &&
            TransactionDate.month == now.month;
      } else {
        isSelectedPeriod = TransactionDate.year == now.year;
      }
      double amount = transaction['amount'];
      if (transaction['type'] == 'income') {
        totalIncome += amount;
      } else if (transaction['type'] == 'expense') {
        totalExpense += amount;
      }
    }
  }

  void calculateCategoryTotals() {
    groceries = 0;
    shopping = 0;
    other = 0;
    for (var transaction in allTransaction) {
      double amount = transaction['amount'];
      DateTime now = DateTime.now();
      DateTime transactionDate = DateTime.parse(transaction['date']);
      if (transaction['type'] != 'expense') {
        continue;
      }
      if (transactionDate.year != now.year ||
          transactionDate.month != now.month) {
        continue;
      }
      if (transaction['category'] == 'Groceries') {
        groceries += amount;
      } else if (transaction['category'] == 'Shopping') {
        shopping += amount;
      } else if (transaction['category'] == 'Other') {
        other += amount;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    dbRef = DbHelper.getInstance;
    getAllTransaction();
  }

  void getAllTransaction() async {
    allTransaction = await dbRef!.getTransactions();
    calculateCategoryTotals();
    calculateTotal();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 237, 194, 1),
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 40, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Welcome Back!", style: Appwidget.textStyle(17)),
                    Text(
                      "Vikram yadav",
                      style: Appwidget.textStyle(
                        18,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async{
                    await Navigator.pushNamed(context, '/profile');
                    getAllTransaction();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(30),
                    child: Image.asset(
                      'assets/images/pfp.png',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Manage Your\nExpenses",
              style: Appwidget.textStyle(28, fontweight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 18, bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Expenses",
                        style: Appwidget.textStyle(
                          24,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   "₹900",
                      //   style: TextStyle(
                      //     color: Colors.redAccent,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 20,
                      //   ),
                      // ),
                    ],
                  ),
                  Text(
                    "Month - ${["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][DateTime.now().month-1]}",
                    style: Appwidget.textStyle(14),
                  ),
                  PieChart(
                    dataMap: {
                      "Groceries": groceries,
                      "Shopping": shopping,
                      "Others": other,
                    },
                    animationDuration: Duration(seconds: 4),
                    chartType: ChartType.disc,
                    colorList: [Colors.blueAccent, Colors.green, Colors.red],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedMonth = true;
                      calculateTotal();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedMonth
                        ? const Color.fromARGB(255, 241, 145, 97)
                        : Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      'This Month',
                      style: Appwidget.textStyle(
                        20,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedMonth = false;
                      calculateTotal();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedMonth
                        ? Colors.white
                        : const Color.fromARGB(255, 241, 145, 97),
                    elevation: 5,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      'This Year',
                      style: Appwidget.textStyle(
                        20,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: 14,
                    right: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Income",
                        style: Appwidget.textStyle(
                          24,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹$totalIncome",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: 14,
                    right: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expenses",
                        style: Appwidget.textStyle(
                          24,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹$totalExpense",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
