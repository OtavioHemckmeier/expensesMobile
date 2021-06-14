import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import './components/transaction_list.dart';
import './components/transaction_form.dart';
import 'Tansaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.amber,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo tenis',
      value: 1,
      date: DateTime.now(),
    ),Transaction(
      id: 't1',
      title: 'Novo tenis',
      value: 1,
      date: DateTime.now(),
    ),Transaction(
      id: 't1',
      title: 'Novo tenis',
      value: 1,
      date: DateTime.now(),
    ),Transaction(
      id: 't1',
      title: 'Novo tenis',
      value: 1,
      date: DateTime.now(),
    ),Transaction(
      id: 't1',
      title: 'Novo tenis',
      value: 1,
      date: DateTime.now(),
    ),Transaction(
      id: 't1',
      title: 'Novo tenis',
      value: 1,
      date: DateTime.now(),
    ),Transaction(
      id: 't1',
      title: 'Novo tenis',
      value: 1,
      date: DateTime.now(),
    ),Transaction(
      id: 't1',
      title: 'Novo tenis',
      value: 1,
      date: DateTime.now(),
    ),Transaction(
      id: 't1',
      title: 'Novo tenis',
      value: 1,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble.toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas pessoais'),
        actions: [
          IconButton(
              icon: Icon(Icons.add_circle_outlined),
              onPressed: () => _openTransactionFormModal(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: IconButton(
              icon: Icon(Icons.add_circle_outlined),
              onPressed: () => _openTransactionFormModal(context))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
