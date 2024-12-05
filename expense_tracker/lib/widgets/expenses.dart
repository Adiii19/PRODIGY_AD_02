import 'package:expense_tracker/widgets/expenses_list.dart/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
  ];

  void _openAddExpenseOverlays() {
    
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: addexpensedata);
        });
  }

  void addexpensedata(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeexpense(Expense expense) {
    final expenseindex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense Deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(expenseindex, expense);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
       final width= MediaQuery.of(context).size.width;
       final height=MediaQuery.of(context).size.height;


    Widget maincontent =
        Center(child: Text("No expenses found.Add some expenses"));

    if (_registeredExpenses.isNotEmpty) {
      maincontent = ExpensesList(
        expenses: _registeredExpenses,
        onremoveexpense: removeexpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
          
          title: Text(
            "Expenses App",
            
          ),
          toolbarHeight: 60,
          actions: [
            IconButton(
                onPressed: () {
                  _openAddExpenseOverlays();
                },
                icon: Icon(Icons.add))
          ]),
      body: width<600?Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text('This Week',style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 25
            ),),
          ),
          Chart(expenses:_registeredExpenses),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text('Today\'s Expenses',style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 25
            ),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Container(
              height: MediaQuery.sizeOf(context).height*0.4,
              width: MediaQuery.sizeOf(context).width*0.89,
               decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 19, 68, 27),
              Color.fromARGB(115, 255, 255, 255)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
                    ),
                  ),
              child: 
             maincontent 
            ),
          ),
        ],
      ):
      Row(
          children: [
          Expanded(child: Chart(expenses:_registeredExpenses)),
          Expanded(child: maincontent),
        ],
      )

    );
  }
}
