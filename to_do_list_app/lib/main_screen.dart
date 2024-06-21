import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_app/controllers/initial_controller.dart';
import 'package:to_do_list_app/controllers/task_controller.dart';
import 'package:to_do_list_app/models/model.dart';
import 'package:to_do_list_app/new_entry.dart';
import 'package:to_do_list_app/widgets/taskItem.dart';
import 'package:http/http.dart'as http;

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
      final TaskController task_controller=Get.put(TaskController());

  void showmodealsheet() {
    showModalBottomSheet(
      sheetAnimationStyle: AnimationStyle(
          curve: Curves.bounceInOut, duration: Durations.medium2),
      context: context,
      useSafeArea: true,
      constraints: BoxConstraints.expand(),
      isScrollControlled: true,
      elevation: 10,
      backgroundColor: Color.fromARGB(255, 245, 219, 219),
      builder: (BuildContext context) => NewEntry(),
    );
  }

  Future<void> loaditems()async{

     final url=Uri.https(
      'task-manager-app-67b0c-default-rtdb.firebaseio.com', '/Tasklist.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      print('Failed to fetch data. Please try again.');
      return;
    }

     if (response.body == 'null') {
      print("Body null");
      setState(() {
        task_controller.tasklist.value = [];
      });
      return;
    }

    final Map<dynamic, dynamic> data =
        json.decode(response.body) as Map<dynamic, dynamic>;
    for (var entry in data.entries) {
    
      final Task task = Task(
          taskname: entry.value['taskname'],
          description: entry.value['taskdesc'],
          date:DateTime.parse(entry.value['date']),
          hour: entry.value['hour']as int ,
          min: entry.value['min']as int,
          id: entry.key,
          category: entry.value['category'],
          hourcheck: entry.value['hourcheck']as int);

          task_controller.tasklist.add(task);
         
          print(task);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaditems();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final InitialController initialController = Get.put(InitialController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(color: Color.fromARGB(255, 245, 219, 219)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        showmodealsheet();
                      },
                      icon: Icon(Icons.add)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 20),
                child: Text(
                  "Have a Good Day ,",
                  style: GoogleFonts.urbanist(
                      color: Color.fromARGB(255, 6, 53, 20),
                      fontSize: 43,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Obx(
                  () => Text(
                    "${initialController.name.value} 👋!",
                    style: GoogleFonts.urbanist(
                        color: Color.fromARGB(255, 6, 53, 20),
                        fontSize: 43,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 3, right: 3),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.97,
                  height: 310,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          width: 2),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(31, 118, 201, 218),
                        Colors.white
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),
                  child: Container(
                    height: 200,
                    width: 190,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 7,
                              spreadRadius: 1,
                              blurStyle: BlurStyle.outer,
                              color: Color.fromARGB(159, 73, 71, 71),
                              offset: Offset(7, 2))
                        ],
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Categories",
                            style: GoogleFonts.urbanist(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(left: 10, bottom: 5),
                            childAspectRatio: 0.67,
                            children: [
                              Card(
                                elevation: 15,
                                margin: EdgeInsets.all(10),
                                child: Stack(
                                  children: [
                                    Image(
                                      image:
                                          AssetImage('assets/images/work.jpg'),
                                      height: 90,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: 190,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(74, 0, 0, 0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 120,
                                        top: 80,
                                      ),
                                      child: Text(
                                        "Work",
                                        style: GoogleFonts.urbanist(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Card(
                                elevation: 15,
                                margin: EdgeInsets.all(10),
                                child: Stack(
                                  children: [
                                    Image(
                                      image:
                                          AssetImage('assets/images/fam.jpg'),
                                      height: 103,
                                      width: 212,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: 193,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(74, 0, 0, 0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 109,
                                        top: 80,
                                      ),
                                      child: Text(
                                        "Family",
                                        style: GoogleFonts.urbanist(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.all(10),
                                elevation: 10,
                                child: Stack(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/leisure.jpg'),
                                      height: 100,
                                      width: 210,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: 190,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(74, 0, 0, 0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 103,
                                        top: 80,
                                      ),
                                      child: Text(
                                        "Leisure",
                                        style: GoogleFonts.urbanist(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Card(
                                margin: EdgeInsets.all(10),
                                elevation: 10,
                                child: Stack(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/health.jpg'),
                                      height: 100,
                                      width: 210,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: 190,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(74, 0, 0, 0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 103,
                                        top: 80,
                                      ),
                                      child: Text(
                                        "Health",
                                        style: GoogleFonts.urbanist(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 6, right: 6),
                child: Container(
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width * 0.96,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 235, 235, 209),
                        Colors.white
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 7,
                            spreadRadius: 1,
                            blurStyle: BlurStyle.outer,
                            color: Color.fromARGB(159, 73, 71, 71),
                            offset: Offset(7, 2))
                      ],
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Your Today's Tasks :",
                          style: GoogleFonts.urbanist(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                        
                        Expanded(
                          child: ListView.builder(
                           itemCount: task_controller.tasklist.length,
                            itemBuilder:(ctx,index)
                          {
                            final task=task_controller.tasklist[index];
                            return
                                    Taskitem(task:task);
                          } ),
                        )

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
