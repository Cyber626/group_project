import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:group_project/data/users.dart';
import 'package:group_project/models/user.dart';
import 'package:group_project/screens/login.dart';
import 'package:group_project/widgets/change_password.dart';
import 'package:group_project/widgets/change_phone_number.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _changePhoneNumber() {
    setState(() {
      _additionalWidget = ChangePhoneNumberWidget(
        onSave: _onPhoneNumberChange,
      );
    });
  }

  void _onPhoneNumberChange(String phoneNumber) async {
    final Uri url = Uri.https(
        'group-order-restaurant-default-rtdb.firebaseio.com',
        'users/${user!.id}.json');

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "phoneNumber": phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      setState(() {
        user = User(
            id: user!.id,
            phoneNumber: responseBody["phoneNumber"],
            password: user!.password);
        _additionalWidget = const Text("Phone number changed successfully");
      });
    }
  }

  void _changePassword() {
    setState(() {
      _additionalWidget = ChangePasswordWidget(
        onSave: _onPasswordChange,
      );
    });
  }

  void _onPasswordChange(String newPassword) async {
    final Uri url = Uri.https(
        'group-order-restaurant-default-rtdb.firebaseio.com',
        'users/${user!.id}.json');

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "password": newPassword,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      setState(() {
        user = User(
            id: user!.id,
            phoneNumber: user!.phoneNumber,
            password: responseBody["password"]);
        _additionalWidget = const Text("Phone number changed successfully");
      });
    }
  }

  void _logoutButton() {
    user = null;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctn) => const LoginScreen(),
      ),
    );
  }

  Widget? _additionalWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Phone number"),
              subtitle: Text(
                user == null
                    ? "No user data"
                    : "*****${user!.phoneNumber.substring(user!.phoneNumber.length - 4)}",
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: _changePhoneNumber,
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Password"),
              subtitle: const Text("Change password"),
              trailing: const Icon(Icons.chevron_right),
              onTap: _changePassword,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              subtitle: const Text("Logout the user"),
              trailing: const Icon(Icons.chevron_right),
              onTap: _logoutButton,
            ),
            _additionalWidget != null ? _additionalWidget! : Container(),
          ],
        ),
      ),
    );
  }
}
