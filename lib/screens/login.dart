import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:group_project/data/users.dart';
import 'package:group_project/models/user.dart';
import 'package:group_project/screens/signup.dart';
import 'package:group_project/screens/tabs.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  String _phoneNumber = "";
  String _password = "";
  String _errorMessage = "";

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final Uri url = Uri.https(
          'group-order-restaurant-default-rtdb.firebaseio.com', 'users.json');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final users = [];
        for (final item in data.entries) {
          users.add(
            User(
              id: item.key,
              phoneNumber: item.value["phoneNumber"],
              password: item.value["password"],
            ),
          );
        }
        if (!context.mounted) {
          return;
        }
        final User? tempUser = users.firstWhere((element) =>
            element.phoneNumber == _phoneNumber &&
            element.password == _password);
        if (tempUser != null) {
          user = tempUser;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctn) => const TabsScreen(),
            ),
          );
        } else {
          setState(() {
            _errorMessage = "User not found";
          });
        }
      } else {
        setState(() {
          _errorMessage = "Connection failed! ${response.statusCode}";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "Login",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 36,
                    ),
              ),
              const SizedBox(height: 28),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 12,
                      initialValue: "998",
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        labelText: "Phone number",
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Input phone number";
                        }
                        if (value.length != value.replaceAll(' ', '').length) {
                          return "Phone number must not contain whitespace";
                        }
                        if (value.length != 12 || !value.startsWith("998")) {
                          return "998xxxxxxxxx";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _phoneNumber = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Input password";
                        }
                        if (value.length != value.replaceAll(' ', '').length) {
                          return "Password must not contain whitespace";
                        }
                        if (value.length < 6) {
                          return "At least 6 characters";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _errorMessage,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: _login,
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctn) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
