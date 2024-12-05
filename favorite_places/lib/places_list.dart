import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';

class PlacesList extends StatelessWidget {
  PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          "No data here",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        leading: CircleAvatar(backgroundImage: FileImage(places[index].image!),
        radius: 28,),
        
        title: Text(
          places[index].title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        subtitle: Text(places[index].location.address,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                )),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => PlaceDetailsScreen(place: places[index])),
            ),
          );
        },
      ),
    );
  }
}
