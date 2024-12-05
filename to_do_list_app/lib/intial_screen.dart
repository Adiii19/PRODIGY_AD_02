import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/initial_controller.dart';
import 'main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntialScreen extends StatefulWidget {
  @override
  State<IntialScreen> createState() => _IntialScreenState();
}

class _IntialScreenState extends State<IntialScreen> {



  
   

 


  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();

    final InitialController initcontroller = Get.put(InitialController());
    final FocusNode _focusNode = FocusNode();

    saveusername() async{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setString('username', _nameController.text);
    }
   

 

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 71, 133, 136),
              Color.fromARGB(255, 253, 254, 253),
              Colors.white
            ],
            begin: Alignment.topLeft,
            end: Alignment.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 151,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Manage your day with FocusFlow",
                      style: GoogleFonts.urbanist(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Image(
                    image: AssetImage('assets/images/init.jpg'),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: initcontroller.setter.value
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 19, 61, 95),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      labelText: "What shall we call you?",
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 650,
                              height: 74,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 19, 61, 95),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(28),
                                    topRight: Radius.circular(28)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Text(
                                  '"The key is not to do everything, but to select the right things to do." - Nelson Mandela',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Obx(
                    () => Container(
                      height: initcontroller.setter.value ? 50 : 60,
                      width: initcontroller.setter.value ? 150 : 60,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 129, 239, 104),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 7,
                                spreadRadius: 1,
                                blurStyle: BlurStyle.normal,
                                color: Color.fromARGB(159, 73, 71, 71),
                                offset: Offset(7, 2))
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      child: Obx(
                        () => TextButton(
                          onPressed: () {
                            
                            if (initcontroller.setter.value) {
                                  saveusername();

                             Get.to(MainScreen());
                            }else{
                              initcontroller.button_changer();
                             
                            }
                          },
                          child: Text(
                            initcontroller.setter.value
                                ? "Let's Begin!"
                                : " > ",
                            style: GoogleFonts.raleway(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
