import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
var formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  leisure,
  work,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
  Category.leisure: Icons.movie
};

class Expense {
  Expense({
    required this.title,
    required this.time,
    required this.amount,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime time;
  final Category category;

  String get fomattedDate {
    return formatter.format(time);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenseList});

  ExpenseBucket.forCategory(List<Expense> allExpense, this.category)
      : expenseList = allExpense
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenseList;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenseList) {
      sum += expense.amount;
    }
    return sum;
  }
}
