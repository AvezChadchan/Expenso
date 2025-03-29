import 'dart:convert';
import 'package:Expenso/AddExpenseScreen.dart';
import 'package:Expenso/MonthExpenseScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> expenses = [];
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

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final String? expensesJson = prefs.getString('expenses');
    if (expensesJson != null) {
      setState(() {
        expenses
            .addAll(List<Map<String, dynamic>>.from(jsonDecode(expensesJson)));
      });
    }
  }

  Future<void> saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final expensesJson = jsonEncode(expenses);
    await prefs.setString('expenses', expensesJson);
  }

  Set<String> getUniqueMonths() {
    return expenses.map((e) {
      DateTime date = DateTime.parse(e['date']);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}';
    }).toSet();
  }

  void addExpense(Map<String, dynamic> expense) {
    setState(() {
      expenses.add(expense);
    });
    saveExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final months = getUniqueMonths();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expenso",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFFCCD6F6)),
        ),
        backgroundColor: Color(0xFF020C1B),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFF020C1B),
        child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: months.length,
            itemBuilder: (context, index) {
              String monthKey = months.elementAt(index);
              DateTime date = DateTime.parse("$monthKey-01");
              String monthName = '${_monthNames[date.month - 1]} ${date.year}';
              return Card(
                color: Color(0xFF112240),
                margin: const EdgeInsets.symmetric(vertical: 18.0),
                child: ListTile(
                  title: Center(
                      child: Text(
                    monthName,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCCD6F6)),
                  )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MonthExpenseScreen(
                                  monthKey: monthKey,
                                  expenses: expenses,
                                )));
                  },
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF112240),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddExpenseScreen(onAdd: addExpense)));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
