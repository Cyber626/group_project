import 'package:flutter/material.dart';
import 'package:group_project/models/order.dart';

class OrderView extends StatelessWidget {
  const OrderView({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Text(order.restaurant);
  }
}
