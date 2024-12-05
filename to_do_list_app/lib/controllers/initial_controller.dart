import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_fonts/google_fonts.dart';

class InitialController extends GetxController{

RxBool setter=false.obs;
RxString name=''.obs;


void button_changer(){

 if(setter.value==false)
 {
    
    setter.value=true;

 }

}



}