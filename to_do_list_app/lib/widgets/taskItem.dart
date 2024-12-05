import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_app/controllers/task_controller.dart';
import 'package:to_do_list_app/models/model.dart';
import 'package:to_do_list_app/new_entry.dart';

class Taskitem extends StatefulWidget{

 Taskitem({required this.task,super.key});

   final Task? task;

  @override
  State<Taskitem> createState() => _TaskitemState();
}

class _TaskitemState extends State<Taskitem> {
   final TaskController task_controller=Get.put(TaskController());

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
              InkWell
              (
                onTap: (){
                  final task=widget.task;
                   showModalBottomSheet(
      sheetAnimationStyle: AnimationStyle(
          curve: Curves.bounceInOut, duration: Durations.medium2),
      context: context,
      useSafeArea: true,
      constraints: BoxConstraints.expand(),
      isScrollControlled: true,
      elevation: 10,
      backgroundColor: Color.fromARGB(255, 245, 219, 219),
      builder: (BuildContext context) => NewEntry(initialtask: task,),
         );
                },


                child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 7),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            height: MediaQuery.of(context).size.height*0.2,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 7,
                                      spreadRadius: 1,
                                      blurStyle: BlurStyle.outer,
                                      color: Color.fromARGB(159, 73, 71, 71),
                                      offset: Offset(3, 2))
                                ],
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 15),
                                  child:
                                    Text(
                                      '${widget.task?.taskname}',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 15),
                                  child:  Text(
                                      '${widget.task?.description}',
                                      style: GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        height: 50,
                                        width: 260,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 7,
                                                  spreadRadius: 1,
                                                  blurStyle: BlurStyle.outer,
                                                  color: Color.fromARGB(
                                                      159, 73, 71, 71),
                                                  offset: Offset(3, 2))
                                            ],
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 15),
                                          child: 
                                            Row(
                                              children: [
                                                Text(
                                                  'Deadline : ${widget.task?.Formatteddate} ${widget.task!.hour}:${widget.task!.min} ',
                                                  style: GoogleFonts.quicksand(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                                Text( '${widget.task!.hour! < 12 ?'AM':'PM'}',
                                                 style: GoogleFonts.quicksand(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w700),
                                                )
                                              ],
                                            ),
                                          
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      child: IconButton(
                                        onPressed: (
                                          
                                        ) {
                                          task_controller.removetask(widget.task!.id);
                                        },
                                        icon: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  style: BorderStyle.solid,
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          child: Icon(
                                            Icons.delete_outline_outlined,
                                            color: const Color.fromARGB(
                                                255, 208, 16, 16),
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
              );
  }
}