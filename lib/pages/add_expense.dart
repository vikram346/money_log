import 'package:money_log/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:money_log/services/supportive.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  DateTime? selectedTime;
  String? selectedCategory;
  @override
  void dispose() {
    amountController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Expense",
          style: Appwidget.textStyle(20, fontweight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text("Titile"),
                hintText: "e.g. bought milk",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Amount"),
                hintText: "e.g. ₹200",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                label: Text("Category"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: const [
                DropdownMenuItem(value: "Groceries", child: Text("Groceries")),
                DropdownMenuItem(value: "Shopping", child: Text("Shopping")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2025),
                  lastDate: DateTime(2027),
                );
                if (pickDate != null) {
                  setState(() {
                    selectedTime = pickDate;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
              child: Text(
                selectedTime == null
                    ? "Pick Date"
                    : "${selectedTime!.day}/${selectedTime!.month}/${selectedTime!.year}",
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                if (amountController.text.isEmpty ||
                    selectedCategory == null ||
                    selectedTime == null) {
                  return;
                }
                bool success = await DbHelper.getInstance.insertTransaction(
                  amount: double.parse(amountController.text),
                  type: "expense",
                  date: selectedTime!.toIso8601String(),
                  title: titleController.text,
                  category: selectedCategory,
                );
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Expense added successfully"), backgroundColor: Colors.green,));
                  Navigator.pop(context);
                }
              },
              child: Text("Add Expense"),
            ),
          ],
        ),
      ),
    );
  }
}
