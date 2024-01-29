import 'package:flutter/material.dart';
import 'package:group_project/data/users.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({
    required this.onSave,
    super.key,
  });

  final void Function(String newPassword) onSave;

  @override
  State<ChangePasswordWidget> createState() {
    return _ChangePasswordWidgetState();
  }
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final newPasswordRepeat = TextEditingController();
  String _errorMessage = "";

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    newPasswordRepeat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const Text("Want to change password?"),
          const SizedBox(height: 8),
          TextField(
            controller: oldPassword,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Old password",
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
          const SizedBox(height: 8),
          TextField(
            controller: newPassword,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "New password",
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
          const SizedBox(height: 8),
          TextField(
            controller: newPasswordRepeat,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Repeat new password",
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
              if (oldPassword.text.length < 6 ||
                  newPassword.text.length < 6 ||
                  newPasswordRepeat.text.length < 6) {
                setState(() {
                  _errorMessage = "Minimum length 6 characters";
                });
              } else if (newPassword.text != newPasswordRepeat.text) {
                setState(() {
                  _errorMessage = "Password mismatch";
                });
              } else if (oldPassword.text != user!.password) {
                setState(() {
                  _errorMessage = "Old password is incorrect";
                });
              } else {
                widget.onSave(newPassword.text);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
