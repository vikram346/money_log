import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_log/database/db_helper.dart';

class History extends StatefulWidget {
  const new({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DbHelper? dbRef;
  List<Map<String, dynamic>> allTransaction = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = DbHelper.getInstance;
    getAllTrans();
  }

  void getAllTrans() async {
    allTransaction = await dbRef!.getTransactions();
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30),
        child: allTransaction.isNotEmpty
            ? ListView.builder(
                itemCount: allTransaction.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14, top: 8),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        leading: Text(
                          allTransaction[index][DbHelper.COLUMN_TYPE] ==
                                  "expense"
                              ? "Expense"
                              : "Income",
                        ),
                        title: Text(
                          "₹${allTransaction[index][DbHelper.COLUMN_AMOUNT].toString().split(".")[0]}",
                        ),
                        subtitle: Text( allTransaction[index][DbHelper.COLUMN_DATE].toString().split("T")[0]
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            bool check = await dbRef!.deleteTransaction(
                              id: allTransaction[index][DbHelper.COLUMN_ID],
                            );
                            if (check) {
                              getAllTrans();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Data Deleted Successfully"),
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(child: Text("No Transction History available")),
      ),
    );
  }
}
