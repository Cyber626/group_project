import 'package:flutter/material.dart';
import 'package:group_project/models/order.dart';
import 'package:group_project/widgets/order.dart';

class OrderView extends StatefulWidget {
  const OrderView({required this.order, required this.deleteOrder, super.key});

  final Order order;
  final void Function(String id) deleteOrder;

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  Widget? _additionalWidget;

  void _onTap() {
    if (_additionalWidget == null) {
      setState(() {
        _additionalWidget = Container(
          margin: const EdgeInsets.only(top: 12),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.red,
              ),
            ),
            onPressed: () async {
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Are you sure to delete?'),
                  content: const Text(
                      'Deleting the order cannot be undone.\nDo you still want to delete the order?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.deleteOrder(widget.order.id);
                        Navigator.pop(context);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              "Delete",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onError,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        );
      });
    } else {
      setState(() {
        _additionalWidget = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSecondary,
        );

    final localizations = MaterialLocalizations.of(context);
    final TimeOfDay time = TimeOfDay.fromDateTime(widget.order.date);
    return InkWell(
      onTap: _onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).colorScheme.secondary,
        ),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Restaurant:",
                  style: textStyle,
                ),
                const Spacer(),
                Text(
                  widget.order.restaurant,
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
                  formatter.format(widget.order.date),
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
                  localizations.formatTimeOfDay(time),
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
                  "${widget.order.numberOfGuests.toString()} guests",
                  style: textStyle,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "Table number:",
                  style: textStyle,
                ),
                const Spacer(),
                Text(
                  widget.order.table == 0
                      ? "Any free table"
                      : widget.order.table.toString(),
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
            _additionalWidget == null
                ? const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  )
                : _additionalWidget!,
          ],
        ),
      ),
    );
  }
}
