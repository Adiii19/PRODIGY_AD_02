import 'package:favorite_places/image_input.dart';
import 'package:favorite_places/location_input.dart';
import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'dart:io';

class AddPlaces extends ConsumerStatefulWidget{
  AddPlaces({super.key});

  @override
  ConsumerState<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends ConsumerState<AddPlaces> {
    File ? selectedimage;
    PlaceLocation ? selectedlocation;


              final titlecontroller=TextEditingController();

              void saveitem()
            {
                  final enteredTitle=titlecontroller.text;
                
                if(enteredTitle.isEmpty ||
        selectedimage == null ||
        selectedlocation == null)
                {
                      return;
                }
                ref.read(UserPlacesProvider.notifier).
                addPlace(enteredTitle,selectedimage!,selectedlocation!);

                  Navigator.of(context).pop();
              }

@override
  void dispose() {
    titlecontroller.dispose();
    super.dispose();
  }
   @override
  Widget build(BuildContext context) {

    return
      Scaffold(
            appBar: AppBar(
              title: Text("Add a New Place"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(child: Column(
                  children: [
                    TextFormField(
                      controller: titlecontroller,         //used to extract the inputed data
                      decoration: InputDecoration(
                        label: Text("Title"),
                          ),
                          style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                   ImageInput(onPickImage: (image) {
                    selectedimage=image;
                   },),
                   SizedBox(
                      height: 10,
                    ),
                    LocationInput(
                      onselectlocation: (location){
                          selectedlocation=location;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  Center(child: ElevatedButton.icon(onPressed: (){
                    saveitem();
                    }
                  , icon: Icon(Icons.add), 
                  label: Text('Add Place')),)
                  
                  ],
                ),
                ),
              ),
            ),

      );
      
}

}