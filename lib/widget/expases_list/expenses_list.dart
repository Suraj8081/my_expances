import 'package:flutter/material.dart';
import 'package:my_expances/model/expanse.dart';
import 'package:my_expances/widget/expases_list/expense_item.dart';

class ExpansesList extends StatelessWidget {
  const ExpansesList(
      {super.key, required this.expansesList, required this.onRemoveExpens});

  final List<Expense> expansesList;

  final void Function(Expense expense) onRemoveExpens;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expansesList.length,
      itemBuilder: (ctx, itemPosition) {
        return Dismissible(
          key: ValueKey(expansesList[itemPosition]),
          background: Container(
            color: Theme.of(context).colorScheme.error,
            margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          ),
          onDismissed: (direction) {
            onRemoveExpens(expansesList[itemPosition]);
          },
          child: ExpanseItem(
            expansesList[itemPosition],
          ),
        );
      },
    );
  }
}
