import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_project/providers/table.dart';
import 'package:group_project/widgets/table.dart';

class SelectTableScreen extends ConsumerStatefulWidget {
  const SelectTableScreen({super.key});

  @override
  ConsumerState<SelectTableScreen> createState() {
    return _SelectTableScreenState();
  }
}

class _SelectTableScreenState extends ConsumerState<SelectTableScreen> {
  bool _isAnyPlace = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a table"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    TableWidget(tableNumber: 1),
                    SizedBox(width: 16),
                    TableWidget(tableNumber: 2),
                    SizedBox(width: 16),
                    TableWidget(tableNumber: 3),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    TableWidget(tableNumber: 4),
                    SizedBox(width: 16),
                    TableWidget(tableNumber: 5),
                    SizedBox(width: 16),
                    TableWidget(tableNumber: 6),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Any place"),
              Checkbox(
                value: _isAnyPlace,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _isAnyPlace = value;
                    });
                  }
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                _isAnyPlace ? 0 : ref.read(tableProvider),
              );
            },
            child: Text(
              "Select",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
