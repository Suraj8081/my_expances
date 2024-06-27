import 'package:flutter/material.dart';
import 'package:my_expances/model/expanse.dart';

class ExpanseItem extends StatelessWidget {
  const ExpanseItem(this.expanse, {super.key});

  final Expense expanse;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expanse.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              children: [
                Text(
                  '\$${expanse.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expanse.category]),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      expanse.fomattedDate,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
