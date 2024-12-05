import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget
{
    ExpenseItem(this.expense,{super.key});

    final Expense expense;

     @override
  Widget build(BuildContext context) {
    
    return
          Card(
             child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
             child:
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(expense.title,style: Theme.of(context).textTheme.titleLarge,),//Title
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Rs.${expense.amount.toStringAsFixed(2)}',style: TextStyle(
                          color: Colors.white
                        ),),//amount
                          Spacer(),
                  
                    Row(
                      children: [
                        Icon(categoryIcons[expense.category]),  //category
                        SizedBox(width:4),
                        Text(expense.FormattedDate,style: TextStyle(
                          color: Colors.white
                        ),)//data
                      ],
                    ),
                   ] ),
                  ],
                ),
              
            
           ));
  
  }

}