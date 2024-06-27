import 'package:flutter/material.dart';
import 'package:my_expances/model/expanse.dart';
import 'package:my_expances/widget/chart/chart.dart';
import 'package:my_expances/widget/expases_list/expenses_list.dart';
import 'package:my_expances/widget/new_expenses.dart';

class Expanses extends StatefulWidget {
  const Expanses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expanses> {
  final List<Expense> _expensesList = [
    Expense(
      title: "Groceries",
      amount: 50.0,
      time: DateTime.now().subtract(Duration(days: 5)),
      category: Category.food,
    ),
    Expense(
      title: "Flight tickets",
      amount: 200.0,
      time: DateTime.now().subtract(Duration(days: 10)),
      category: Category.travel,
    ),
    Expense(
      title: "Movie tickets",
      amount: 20.0,
      time: DateTime.now().subtract(Duration(days: 2)),
      category: Category.leisure,
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _expensesList.add(expense);
    });
  }

  void _remomoveExpens(Expense expense) {
    final expenseIndex = _expensesList.indexOf(expense);
    setState(() {
      _expensesList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense was deleted...'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expensesList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _clickOnAddExpenses() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpenses(
          onAddExpens: _addExpense,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('There are no expenses...'));

    if (_expensesList.isNotEmpty) {
      mainContent = ExpansesList(
        expansesList: _expensesList,
        onRemoveExpens: _remomoveExpens,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpensesTracker'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _clickOnAddExpenses,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _expensesList),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
