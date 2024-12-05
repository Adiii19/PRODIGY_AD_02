import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_app/intial_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_list_app/firebase_options.dart';
import 'package:to_do_list_app/main_screen.dart';

void main() async{
     WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( MyApp());
  
}


class MyApp extends StatelessWidget {
   MyApp({super.key});

      String? check='';
  Future<Widget> loadusername ()async{

  SharedPreferences prefs=await SharedPreferences.getInstance();
  check=prefs.getString('username');
  if(check==null)
  {

    return IntialScreen();
  }
else{
       return MainScreen();
}

    }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<Widget>(future: loadusername(),builder: (context, snapshot) {

        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return const Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        else{
          return snapshot.data!;
        }
         
      },)
    );
  }
}

