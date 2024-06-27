import 'package:flutter/material.dart';
import 'package:my_expances/model/expanse.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddExpens});

  final void Function(Expense expense) onAddExpens;

  @override
  State<NewExpenses> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selecetdCategories = Category.food;

  void _presentDatePickerDialog() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final isValidAmount = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty &&
        isValidAmount &&
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Check Title ,Anount, Date and categories which was entered by you..'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else {
      widget.onAddExpens(Expense(
          title: _titleController.text.trim(),
          time: _selectedDate!,
          amount: enteredAmount!,
          category: _selecetdCategories));

          Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            keyboardType: TextInputType.text,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    prefixText: '\$  ',
                    label: Text('Amount'),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Selected Date'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePickerDialog,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selecetdCategories,
                items: Category.values.map((categories) {
                  return DropdownMenuItem(
                    value: categories,
                    child: Text(
                      categories.name.toLowerCase(),
                    ),
                  );
                }).toList(),
                onChanged: (vlaue) {
                  if (vlaue == null) {
                    return;
                  }
                  setState(() {
                    _selecetdCategories = vlaue;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Add Expenses'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
