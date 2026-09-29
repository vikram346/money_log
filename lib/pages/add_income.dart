import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_log/database/db_helper.dart';

class AddIncome extends StatefulWidget {
  const new({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  TextEditingController amountController = TextEditingController();
  DateTime? selectTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Income")),
      body: Container(
        margin: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 30),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: InputDecoration(
                hintText: "e.g. ₹10000",
                label: Text("Amount"),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickTime = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2025),
                  lastDate: DateTime(2027),
                  initialDate: DateTime.now(),
                );
                if (pickTime != null) {
                  setState(() {
                    selectTime = pickTime;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
              child: Text(
                selectTime == null
                    ? "Pick a date"
                    : "${selectTime!.day}/${selectTime!.month}/${selectTime!.year}",
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                if (amountController.text.isEmpty || selectTime == null) {
                  return;
                }
                bool success = await DbHelper.getInstance.insertTransaction(
                  amount: double.parse(amountController.text),
                  type: "income",
                  date: selectTime!.toIso8601String(),
                );
                if(success){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Income added SuccessFully"), backgroundColor: Colors.green,));
                  Navigator.pop(context);
                }
                },
              child: Text("Add Income"),
            ),
          ],
        ),
      ),
    );
  }
}
