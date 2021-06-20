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
  final List<Transaction> _transactions = [];
  bool _showChat = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape =
        mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Despesas pessoais'),
      actions: [
        if (isLandscape)
          IconButton(
            icon: Icon(_showChat ? Icons.show_chart : Icons.list),
            onPressed: () {
              setState(() {
                _showChat = !_showChat;
              });
            },
          ),
        IconButton(
          icon: Icon(Icons.add_circle_outlined),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );

    final avalilabelHeigth = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              _showChat
                  ? Container(
                      height: avalilabelHeigth * 0.5,
                      child: Chart(_recentTransactions),
                    )
                  : Container(
                      height: avalilabelHeigth * 0.5,
                      child: TransactionList(_transactions, _deleteTransaction),
                    ),
            if (!isLandscape)
              Container(
                height: avalilabelHeigth * 0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape)
              Container(
                height: avalilabelHeigth * 0.7,
                child: TransactionList(_transactions, _deleteTransaction),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: IconButton(
              icon: Icon(Icons.add_circle_outlined),
              onPressed: () => _openTransactionFormModal(context))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
