import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/expensetracker_home_page.dart';
class ExpenseTrackerHome extends StatefulWidget {
  const ExpenseTrackerHome({super.key});
  @override
  _ExpenseTrackerHomeState createState() => _ExpenseTrackerHomeState();
}
class _ExpenseTrackerHomeState extends State<ExpenseTrackerHome> {
  final List<Transaction> _transactions = [];
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedCategory = 'Miscellaneous';
  final double _monthlyBudget = 1000.0; // Example budget

  void _addTransaction() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _transactions.add(Transaction(
          description: _descriptionController.text,
          amount: double.parse(_amountController.text),
          category: _selectedCategory,
          date: DateTime.now(),
        ));
        _descriptionController.clear();
        _amountController.clear();
      });
    }
  }

  double _calculateTotalExpenses() {
    return _transactions.fold(
        0.0, (sum, transaction) => sum + transaction.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expense Tracker'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    items: [
                      'Food',
                      'Transport',
                      'Entertainment',
                      'Miscellaneous'
                    ]
                        .map((category) =>
                        DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Category'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addTransaction,
                    child: const Text('Add Transaction'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Expenses: \$${_calculateTotalExpenses().toStringAsFixed(
                  2)} / \$${_monthlyBudget.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                return ListTile(
                  title: Text(transaction.description),
                  subtitle: Text(transaction.category),
                  trailing:
                  Text('\$${transaction.amount.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}