import 'package:flutter/material.dart';
import 'package:group_project/data/restaurants.dart';
import 'package:group_project/screens/restaurant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeScreen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      drawer: const Drawer(),
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
          leading: Image.asset(
            "assets/images/no_image.png",
            height: 50,
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
