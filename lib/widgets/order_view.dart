import 'package:flutter/material.dart';
import 'package:group_project/models/order.dart';
import 'package:group_project/widgets/order.dart';

class OrderView extends StatelessWidget {
  const OrderView({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSecondary,
        );

    final localizations = MaterialLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).colorScheme.secondary,
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Restaurant:",
                style: textStyle,
              ),
              const Spacer(),
              Text(
                order.restaurant,
                style: textStyle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                "Date:",
                style: textStyle,
              ),
              const Spacer(),
              Text(
                formatter.format(order.date),
                style: textStyle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                "Time:",
                style: textStyle,
              ),
              const Spacer(),
              Text(
                localizations.formatTimeOfDay(order.time),
                style: textStyle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                "Number of guests:",
                style: textStyle,
              ),
              const Spacer(),
              Text(
                "${order.numberOfGuests.toString()} guests",
                style: textStyle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                "Status:",
                style: textStyle,
              ),
              const Spacer(),
              Text(
                "Pending",
                style: textStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
