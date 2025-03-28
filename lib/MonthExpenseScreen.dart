import 'package:flutter/material.dart';

class MonthExpenseScreen extends StatelessWidget {
  final List<Map<String, dynamic>> expenses;
  final String monthKey;

  const MonthExpenseScreen(
      {super.key, required this.monthKey, required this.expenses});
  double calculateTotal() {
    return expenses
        .where((e) => DateTime.parse(e['date']).toString().startsWith(monthKey))
        .fold(0.0, (sum, e) => sum + e['amount']);
  }

  @override
  Widget build(BuildContext context) {
    final monthExpenses = expenses
        .where((e) => DateTime.parse(e['date']).toString().startsWith(monthKey))
        .toList();
    final total = calculateTotal();
    DateTime date = DateTime.parse('$monthKey-01');
    String monthName = '${_monthNames[date.month - 1]} ${date.year}';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          monthName,
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFCCD6F6)),
        ),
        iconTheme: IconThemeData(color: Color(0xFFCCD6F6)),
        backgroundColor: Color(0xFF020C1B),
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
              Text(
                "Total: ${total.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCCD6F6)),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: monthExpenses.length,
                itemBuilder: (context, index) {
                  final expense = monthExpenses[index];
                  // DateTime expenseDate = DateTime.parse(expense['date']);
                  // String formattedDate =
                  //     DateFormat('dd MMM yyyy').format(expenseDate);
                  return Padding(
                    padding: const EdgeInsets.only(top: 10,left: 7,right: 7),
                    child: Card(
                      color: Color(0xFF112240),
                      child: ListTile(
                        title: Text(
                          "${expense['amount']} :- ${expense['category']}",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFCCD6F6)),
                        ),
                        subtitle: Text(expense['date'],style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8892B0)),),
                      ),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> _monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
