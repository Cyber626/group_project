import 'package:flutter/material.dart';
import 'package:group_project/data/restaurants.dart';
import 'package:group_project/screens/profile.dart';
import 'package:group_project/screens/restaurant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noImage = Image.asset(
      "assets/images/no_image.png",
      height: 50,
      width: 50,
      fit: BoxFit.fill,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeScreen"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctn) => const ProfileScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.person,
            size: 35,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: restaurants.length,
        itemBuilder: (ctn, index) => ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctn) => RestaurantScreen(
                  restaurant: restaurants[index],
                ),
              ),
            );
          },
          leading: restaurants[index].images.isEmpty
              ? noImage
              : Image.network(
                  restaurants[index].images[0],
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                  errorBuilder: (ctn, obj, stackTrace) {
                    return noImage;
                  },
                ),
          title: Text(
            restaurants[index].name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          trailing: const Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
