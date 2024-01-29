import 'package:flutter/material.dart';

class ChangePhoneNumberWidget extends StatefulWidget {
  const ChangePhoneNumberWidget({super.key, required this.onSave});

  final void Function(String phoneNumber) onSave;

  @override
  State<StatefulWidget> createState() {
    return _ChangePhoneNumberWidgetState();
  }
}

class _ChangePhoneNumberWidgetState extends State<ChangePhoneNumberWidget> {
  final textController = TextEditingController();
  String _errorMessage = "";

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textController.text = "998";
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const Text("Want to change phone number?"),
          const SizedBox(height: 8),
          TextField(
            controller: textController,
            maxLength: 12,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              labelText: "New phone number",
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Text(
            _errorMessage,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.length != 12) {
                setState(() {
                  _errorMessage = "Invalid phone number";
                });
              } else {
                widget.onSave(textController.text);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
