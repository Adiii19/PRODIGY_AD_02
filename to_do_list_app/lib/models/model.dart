import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
final formatter=DateFormat.yMd();

enum Category{

 Work,Family,Health,Leisure

}

class Task{

Task(
{ required this.taskname,
required this.description,
 required this.date,
required this .hour,
required this.min,
required this.id,
required this.hourcheck,
required this.category,

}


);

 String taskname;
 String description;
 DateTime date;
 int?  hour;
 int ?min;
 int ?hourcheck;
 String id;
 String category;


String get Formatteddate{
  return formatter.format(date!);
}

 
        
}