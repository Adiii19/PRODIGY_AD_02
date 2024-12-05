import 'package:chat_app/widgets/chat_Messages.dart';
import 'package:chat_app/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget{

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}



class _ChatScreenState extends State<ChatScreen> {
   
  void setuppushnotification()async{

      final fcm=FirebaseMessaging.instance;

      await fcm.requestPermission();
      
      final token =await fcm.getToken();
      print(token);

     fcm.subscribeToTopic('chat');
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setuppushnotification();
  }
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
      
     return 
            Scaffold(

              appBar: AppBar(
                actions: [
                  IconButton(onPressed: (){
                                        FirebaseAuth.instance.signOut();

                  }
                  ,
                   icon: Icon(Icons.exit_to_app),color: Theme.of(context).colorScheme.primary,)
                ],
                title: Text("WeChat"),
              ),

              body: Column(
                children: [
                  Expanded(child: ChatMessages()),
                  NewMessages(),
                ],
              )

            );


  }
}