import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:group_project/data/users.dart';
import 'package:group_project/models/order.dart';
import 'package:group_project/widgets/order_view.dart';
import 'package:http/http.dart' as http;

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> orders = [];
  String text = "Loading";

  @override
  void initState() {
    super.initState();
    _getDataFromBackend();
  }

  void _getDataFromBackend() async {
    if (user == null) {
      return;
    }
    final Uri url = Uri.https(
        'group-order-restaurant-default-rtdb.firebaseio.com',
        'orders/${user!.id}.json');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      setState(() {
        text = "Connection error ${response.statusCode}";
      });
    } else {
      if (json.decode(response.body) == null) {
        setState(() {
          text = "List is empty";
        });
        return;
      }
      final List<Order> responseOrders = [];
      final Map<String, dynamic> data = json.decode(response.body);
      for (final item in data.entries) {
        responseOrders.add(
          Order(
            id: item.key,
            restaurant: item.value['restaurant'],
            selectedBranch: item.value['selectedBranch'],
            numberOfGuests: item.value['numberOfGuests'],
            table: item.value['table'],
            phoneNumber: item.value['phoneNumber'],
            date: DateTime.parse(
              item.value['date'],
            ),
          ),
        );
      }
      setState(() {
        orders = responseOrders;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? Center(
              child: Text(text),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              itemBuilder: (ctn, index) {
                return OrderView(order: orders[index]);
              },
            ),
    );
  }
}
