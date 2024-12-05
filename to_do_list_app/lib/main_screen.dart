import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_app/category_screen.dart';
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
      final InitialController initialController = Get.put(InitialController());

  void showmodealsheet() {
    showModalBottomSheet(
      sheetAnimationStyle: AnimationStyle(
          curve: Curves.bounceInOut, duration: Durations.long4),
      context: context,
      useSafeArea: true,
      constraints: const BoxConstraints.expand(),
      isScrollControlled: true,
      elevation: 10,
      backgroundColor: const Color.fromARGB(255, 245, 219, 219),
      builder: (BuildContext context) => NewEntry(),
    );
  }

 loadusername ()async{

  SharedPreferences prefs=await SharedPreferences.getInstance();
  initialController.name.value=prefs.getString('username')!;

 }

  Future<void> loaditems()async{

          task_controller.tasklist.clear();
     final url=Uri.https(
      'to-do-list-29552-default-rtdb.firebaseio.com', '/Tasklist.json');
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
          description: entry.value['taskdesc'].toString(),
          date:DateTime.parse(entry.value['date']),
          hour: entry.value['hour']as int ,
          min: entry.value['min']as int,
          id: entry.key,
          category: entry.value['category'].toString(),
          hourcheck: entry.value['hourcheck']as int);

          task_controller.tasklist.add(task);
         
          
    }
           print(task_controller.tasklist);
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    loadusername();
    loaditems();
  
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(color: Color.fromARGB(255, 245, 219, 219)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          showmodealsheet();
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 20),
                  child: Text(
                    "Have a Good Day ,",
                    style: GoogleFonts.urbanist(
                        color: const Color.fromARGB(255, 6, 53, 20),
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
                          color: const Color.fromARGB(255, 6, 53, 20),
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
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(31, 118, 201, 218),
                          Colors.white
                        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        )),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width*5,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 7,
                                spreadRadius: 1,
                                blurStyle: BlurStyle.outer,
                                color: Color.fromARGB(159, 73, 71, 71),
                                offset: Offset(7, 2))
                          ],
                          border: Border.all(color: Colors.black),
                          borderRadius: const BorderRadius.all(
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
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GridView.count(
                                crossAxisCount: 2,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(left: 4, bottom: 5),
                                childAspectRatio: 0.67,
                                children: [
                                  InkWell(
                                    onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CategoryScreen(cat_name: 'Work')));
                                    },
                                    child: Card(
                                      
                                      elevation: 15,
                                      margin: const EdgeInsets.all(10),
                                      child: Stack(
                                        children: [
                                          const Image(
                                            image:
                                                AssetImage('assets/images/work.jpg'),
                                            height: 110,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            width: 200,
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(74, 0, 0, 0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1))),
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
                                  ),
                                  InkWell(
                                    onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CategoryScreen(cat_name: 'Family')));
                                    },
                                    child: Card(
                                      elevation: 15,
                                      margin: const EdgeInsets.all(10),
                                      child: Stack(
                                        children: [
                                          const Image(
                                            image:
                                                AssetImage('assets/images/fam.jpg'),
                                            height: 110,
                                            width: 212,
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            width: 193,
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(74, 0, 0, 0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1))),
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
                                  ),
                                  InkWell(
                                    onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CategoryScreen(cat_name: 'Leisure')));
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.all(10),
                                      elevation: 10,
                                      child: Stack(
                                        children: [
                                          const Image(
                                            image: AssetImage(
                                                'assets/images/leisure.jpg'),
                                            height: 110,
                                            width: 210,
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            width: 190,
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(74, 0, 0, 0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1))),
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
                                  ),
                                  InkWell(
                                    onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CategoryScreen(cat_name: 'Health')));
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.all(10),
                                      elevation: 10,
                                      child: Stack(
                                        children: [
                                          const Image(
                                            image: AssetImage(
                                                'assets/images/health.jpg'),
                                            height: 110,
                                            width: 210,
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            width: 190,
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(74, 0, 0, 0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1))),
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
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width * 0.97,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 235, 235, 209),
                          Colors.white
                        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 7,
                              spreadRadius: 1,
                              blurStyle: BlurStyle.outer,
                              color: Color.fromARGB(159, 73, 71, 71),
                              offset: Offset(7, 2))
                        ],
                        border: Border.all(color: Colors.black),
                        borderRadius: const BorderRadius.all(
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
                            child: Obx(
                              ()=> ListView.builder(
                               itemCount: task_controller.tasklist.length,
                                itemBuilder:(ctx,index)
                              {
                                final taskw=task_controller.tasklist[index];
                                return
                                  Taskitem(task:taskw);
                              } ),
                            ),
                          )
        
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
