import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_app/controllers/task_controller.dart';
import 'package:to_do_list_app/models/model.dart';
import 'package:to_do_list_app/widgets/taskItem.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({required this.cat_name, super.key});

  final String cat_name;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final TaskController task_controller = Get.put(TaskController());
    
    

    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(color: Color.fromARGB(255, 219, 244, 245)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  '${widget.cat_name}',
                  style: GoogleFonts.urbanist(
                      color: Color.fromARGB(255, 6, 53, 20),
                      fontSize: 43,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 20,
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
                        child: Obx(() {
                          final filtertask =
                              task_controller.tasklist.where((task) {
                            return widget.cat_name==task.category.toString().split('.').last ;
                          }).toList();

                          return ListView.builder(
                              itemCount: filtertask.length,
                              itemBuilder: (ctx, index) {
                                final taskw = filtertask[index];
                                return Taskitem(task: taskw);
                              });
                        }),
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
