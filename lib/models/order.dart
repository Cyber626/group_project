import 'package:flutter/material.dart';

class Order {
  const Order({
    required this.restaurant,
    required this.selectedBranch,
    required this.numberOfGuests,
    required this.phoneNumber,
    required this.date,
    required this.time,
  });

  final String restaurant;
  final int selectedBranch;
  final int numberOfGuests;
  final String phoneNumber;
  final DateTime date;
  final TimeOfDay time;
}
