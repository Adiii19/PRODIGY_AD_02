import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/maps_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class LocationInput extends StatefulWidget
{
  LocationInput({super.key,required this.onselectlocation});

  void Function(PlaceLocation location) onselectlocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  PlaceLocation? pickedlocation;
  var isGettingLocation=false;

  String get locationimage{

    if (pickedlocation == null) {
      return '';
    }

    final lat=pickedlocation!.latitude;
    final lng=pickedlocation!.langitude;
    return
            'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyAelfiMUF41wf194bu4qAHhDsLkxtKiltE';
           

  }

   void saveplace(double latitude,double longitude)async{

      
   final url=Uri.parse(
    'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAelfiMUF41wf194bu4qAHhDsLkxtKiltE');
    final response=await http.get(url);
    final resData=json.decode(response.body);
    print(resData);
    final address=resData['results'][0]['formatted_address'];

  setState(() {
    pickedlocation=PlaceLocation(address: address
    , langitude: longitude, 
    latitude: latitude);
  isGettingLocation=false;
    });

  widget.onselectlocation(pickedlocation!);

   }

  void selectonmap() async{
     final pickedlocation=await Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (ctx)=>
     
        const MapScreen()
      
      )
      );
      saveplace(pickedlocation!.latitude, pickedlocation.longitude);
  }

    void getcurrentlocation()async{

      Location? location =  Location();

bool serviceEnabled;
PermissionStatus permissionGranted;
LocationData locationData;

serviceEnabled = await location.serviceEnabled();
if (!serviceEnabled) {
  serviceEnabled = await location.requestService();
  if (!serviceEnabled) {
    return;
  }
}

permissionGranted = await location.hasPermission();
if (permissionGranted == PermissionStatus.denied) {
  permissionGranted = await location.requestPermission();
  if (permissionGranted != PermissionStatus.granted) {
    return;
  }
}

   setState(() {
  isGettingLocation=true;
});

locationData = await location.getLocation();
  final lat=locationData.latitude;
  final lng=locationData.longitude;

  if (lat==null||lng==null)
  {
    return;
  }
    saveplace(lat, lng);

   
     
    }

   


   @override
  Widget build(BuildContext context) {
    
    Widget previewContent=Center(child: Text('No location added'));

    if(pickedlocation!=null)
    {
          previewContent=Image.network(locationimage,
          fit:BoxFit.cover,
          width: double.infinity,
          height: double.infinity,);

    }

    if(isGettingLocation)
    {
      previewContent=const CircularProgressIndicator(
        
      );
    }

     return
            Column(
              children: [
                Container(
                   height: 170,
                   width: double.infinity,
                   decoration: BoxDecoration(
                    border: Border.all(
                      width: 1
                    ),
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2)
                   ),
                   child:previewContent
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(onPressed: getcurrentlocation, icon: Icon(Icons.location_on), label: Text('Add Current Location')),
                    TextButton.icon(onPressed: 
                      selectonmap
                    , icon: Icon(Icons.map), label: Text('Select on Map'))
                  ],
                )
              ],
            );
  }
}