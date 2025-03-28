import 'package:flutter/material.dart';

class AddExpenseScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) onAdd;
  final TextEditingController amount_Controller = TextEditingController();
  final TextEditingController category_Controller = TextEditingController();
  AddExpenseScreen({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Expenses",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27,color: Color(0xFFCCD6F6)),
        ),
        backgroundColor: Color(0xFF020C1B),
        iconTheme: IconThemeData(color: Color(0xFFCCD6F6)),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFF020C1B),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  cursorColor: Color(0xFFCCD6F6),
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 20,color: Color(0xFFCCD6F6)),
                  controller: amount_Controller,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF12192C),
                      labelText: 'Amount',
                      labelStyle: TextStyle(color: Color(0xFFA8B2D1),fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF25355A),width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                          BorderSide(color: Color(0xFF3E4C76), width: 2))),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: category_Controller,
                  style: TextStyle(fontSize: 20,color: Color(0xFFCCD6F6)),

                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF12192C),
                      labelText: 'Category',
                      labelStyle: TextStyle(color:Color(0xFFA8B2D1),fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF25355A),width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(color: Color(0xFF3E4C76), width: 2))),
                ),
                SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (amount_Controller.text.isNotEmpty &&
                          category_Controller.text.isNotEmpty) {
                        // DateTime now = DateTime.now();
                        // String formattedDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
                        onAdd({
                          'amount': double.parse(amount_Controller.text),
                          'category': category_Controller.text,
                          'date': DateTime.now().toString(),
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Add Expense"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3A496B),
                  foregroundColor: Color(0xFFFFFFFF)
                ),
                ),
              ],
            )),
      ),
    );
  }
}
