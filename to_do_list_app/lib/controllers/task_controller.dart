import 'dart:convert';

//import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_list_app/models/model.dart';

class TaskController extends GetxController {
  RxList<Task> tasklist = <Task>[].obs;
    RxList<Task> filtlist = <Task>[].obs;


  
  RxBool AddButton = false.obs;
  RxString taskname = ''.obs;
  RxString taskdesc = ''.obs;

  Rx<DateTime> date = DateTime.now().obs;
  RxInt? hour = 2.obs;
  RxInt? min = 4.obs;
  RxInt? hourcheck = 4.obs;
  RxString? id = ''.obs;
  RxString category = Category.Work.name.obs;

  void task_adder() async {
    if (AddButton.value == true) {
      final url = Uri.https(
          'to-do-list-29552-default-rtdb.firebaseio.com', '/Tasklist.json');
      final response = await http.post(url,
          headers: {'Content-type': 'application/json'},
          body: json.encode({
            'taskname': taskname.value,
            'taskdesc': taskdesc.value,
            'date': date.value.toIso8601String(),
            'hour': hour?.value,
            'min': min?.value,
            'hourcheck': hourcheck?.value,
            'category': category.value.toString().split('.').last,
            
            
          }));
         print(response.body);
      final  data = json.decode(response.body)  as Map<String, dynamic>;
     
      final String id=data['name'];

      tasklist.add(Task(
        taskname: taskname.value,
        description: taskdesc.value,
        date: date.value,
        hour: hour?.value,
        min: min?.value,
        hourcheck: hourcheck?.value,
        id:id ,
        category: category.value.toString().split('.').last,
      ));
      update();
      print(tasklist);
       update(); // Explicitly call update to refresh the state
    AddButton.value = false;
    }
  }

  void edittask(Task initialtask) async {
    if (initialtask != null) {
      final url = Uri.https('to-do-list-29552-default-rtdb.firebaseio.com',
          '/Tasklist/${initialtask.id}.json');
      final response = await http.patch(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode({
          'taskname': initialtask.taskname,
          'taskdesc': initialtask.description,
          'date': initialtask.date!.toIso8601String(),
          'hour':initialtask.hour,
          'min': initialtask.min,
          'hourcheck': initialtask.hour,
          'id': initialtask?.id ?? '',
          'category':initialtask.category.toString().split('.').last,
        }),
      );

      if (response.statusCode >= 400) {
        print('Failed to update task. Please try again.');
        return;
      }

      final updatedtaskindex =
          tasklist.indexWhere((element) => element.id == initialtask.id);
      if (updatedtaskindex != -1) {
        tasklist[updatedtaskindex] = Task(
            taskname: initialtask.taskname,
            description: initialtask.description,
            date: initialtask.date,
            hour: initialtask.hour,
            min: initialtask.min,
            id: initialtask.id,
            hourcheck: initialtask.hour,
            category: initialtask.category.toString().split('.').last,);
      }
      
    }

  }

  void removetask(String taskid)async{

    final url=Uri.https('to-do-list-29552-default-rtdb.firebaseio.com','/Tasklist/$taskid.json');

    final response=await http.delete(url);

    if(response.statusCode>=400)
    {
      print('Failed to delete task. Please try again.');
    }

    tasklist.removeWhere((task)=>task.id==taskid);
    update();

  }

}
