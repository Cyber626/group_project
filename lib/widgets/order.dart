import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_project/data/users.dart';
import 'package:group_project/models/restaurant.dart';
import 'package:group_project/providers/table.dart';
import 'package:group_project/screens/select_table.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

final formatter = DateFormat.yMd();

class OrderWidget extends ConsumerStatefulWidget {
  const OrderWidget({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  ConsumerState<OrderWidget> createState() {
    return _OrderWidgetState();
  }
}

class _OrderWidgetState extends ConsumerState<OrderWidget> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _selectedBranch = 0;
  int? _numberOfGuests, _selectedTable;
  String? _phoneNumber;

  final _formKey = GlobalKey<FormState>();

  void _presentDatePicker() async {
    final now = DateTime.now();
    final tillNextMonth = DateTime(now.year, now.month + 1, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: now, lastDate: tillNextMonth);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _selectTable() async {
    int? returnValue = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctn) => const SelectTableScreen(),
      ),
    );
    setState(() {
      _selectedTable = returnValue;
    });
    ref.read(tableProvider.notifier).changeSelectedTable(null);
  }

  void _presentTimePicker() async {
    const now = TimeOfDay(hour: 12, minute: 0);
    final pickedTime = await showTimePicker(context: context, initialTime: now);
    setState(() {
      _selectedTime = pickedTime;
    });
  }

  void _orderPlace() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate != null ||
          _selectedTime != null ||
          _selectedTable != null) {
        _formKey.currentState!.save();

        if (user == null) {
          return;
        } else {
          //Combine DateTime and TimeOfDay
          _selectedDate = DateTime(
            _selectedDate!.year,
            _selectedDate!.month,
            _selectedDate!.day,
            _selectedTime!.hour,
            _selectedTime!.minute,
          );

          final Uri url = Uri.https(
              'group-order-restaurant-default-rtdb.firebaseio.com',
              'orders/${user!.id}.json');
          http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode(
              {
                'restaurant': widget.restaurant.name,
                'selectedBranch': _selectedBranch,
                'numberOfGuests': _numberOfGuests!,
                'table': _selectedTable!,
                'phoneNumber': _phoneNumber!,
                'date': _selectedDate.toString(),
              },
            ),
          );
        }

        if (!context.mounted) {
          return;
        }
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Order saved"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    String formattedTimeOfDay = "No time selected";

    if (_selectedTime != null) {
      formattedTimeOfDay = localizations.formatTimeOfDay(_selectedTime!);
    }

    var selectedBranch = widget.restaurant.branches.entries.first.key;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
            onSaved: (value) {
              _selectedBranch = value!;
            },
            validator: (value) {
              if (value == 0 || value == null) {
                return "Please select a branch";
              }
              return null;
            },
            value: selectedBranch,
            items: [
              for (final branchId in widget.restaurant.branches.entries)
                DropdownMenuItem(
                  value: branchId.key,
                  child: Text(branchId.value),
                ),
            ],
            onChanged: (value) {
              setState(() {
                selectedBranch = value!;
              });
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text("Date"),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No date selected"
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text("Time"),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      formattedTimeOfDay,
                    ),
                    IconButton(
                      onPressed: _presentTimePicker,
                      icon: const Icon(Icons.access_time),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text("Number of guests"),
              const Spacer(
                flex: 5,
              ),
              Expanded(
                flex: 1,
                child: TextFormField(
                  onSaved: (value) {
                    _numberOfGuests = int.parse(value!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Input";
                    }
                    if (int.tryParse(value) == null) {
                      return "Invalid";
                    }
                    if (int.parse(value) < 1) {
                      return "Min.";
                    }
                    return null;
                  },
                  initialValue: "0",
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text("Table Number"),
              const Spacer(),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedTable == null
                            ? "No table selected"
                            : _selectedTable == 0
                                ? "Any place"
                                : _selectedTable.toString(),
                      ),
                      IconButton(
                        onPressed: _selectTable,
                        icon: const Icon(Icons.table_bar),
                      ),
                    ],
                  )),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text("Phone Number"),
              const Spacer(),
              Expanded(
                child: TextFormField(
                  onSaved: (value) {
                    _phoneNumber = value;
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length < 12 ||
                        !value.startsWith("998")) {
                      return "Incorrect type";
                    }
                    return null;
                  },
                  maxLength: 12,
                  keyboardType: const TextInputType.numberWithOptions(),
                  initialValue: "998",
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _orderPlace,
            child: const Text("Order"),
          ),
        ],
      ),
    );
  }
}
