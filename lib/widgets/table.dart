import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_project/providers/table.dart';

class TableWidget extends ConsumerStatefulWidget {
  const TableWidget({
    required this.tableNumber,
    super.key,
  });

  final int tableNumber;

  @override
  ConsumerState<TableWidget> createState() {
    return _TableWidgetState();
  }
}

class _TableWidgetState extends ConsumerState<TableWidget> {
  @override
  Widget build(BuildContext context) {
    int? selectedTable = ref.watch(tableProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: selectedTable == widget.tableNumber
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.background,
      ),
      child: GestureDetector(
        onTap: () {
          ref
              .read(tableProvider.notifier)
              .changeSelectedTable(widget.tableNumber);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/table.jpg",
              width: 150,
            ),
            Text(
              widget.tableNumber.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
