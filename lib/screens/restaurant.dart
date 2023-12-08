import 'package:flutter/material.dart';
import 'package:group_project/models/restaurant.dart';
import 'package:group_project/widgets/order.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.restaurant.name,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: widget.restaurant.images.isEmpty
                  ? Image.asset(
                      "assets/images/no_image.png",
                      height: 150,
                    )
                  : Row(
                      children: [
                        for (int i = 0;
                            i < widget.restaurant.images.length;
                            i++)
                          Image.network(
                            widget.restaurant.images[i],
                            height: 150,
                            errorBuilder: (ctn, obj, stackTrace) {
                              return Image.asset(
                                "assets/images/no_image.png",
                                height: 150,
                              );
                            },
                          ),
                      ],
                    ),
            ),
            const SizedBox(height: 16),
            const Text(
                "data,fhsjkfghlaksfjd;kasdjf;aksjd f;akls jdfka jsdl;kfj asl;dkjf l;aksdjfkl;asjd f;laskjd f;lk jas;ldkfj al;skdj f;askdf;lka jsd;lfkj asl;kdjf l;as"),
            const SizedBox(height: 16),
            OrderWidget(restaurant: widget.restaurant),
          ],
        ),
      ),
    );
  }
}
