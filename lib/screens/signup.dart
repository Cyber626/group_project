import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:group_project/models/user.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = "";
  String _password = "";
  String _passwordRepeat = "";
  String _errorMessage = "";

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_password != _passwordRepeat) {
        setState(() {
          _errorMessage = "Password mismatch";
        });
      } else {
        final Uri url = Uri.https(
            'group-order-restaurant-default-rtdb.firebaseio.com', 'users.json');

        final getResponse = await http.get(url);
        final List<User> users = [];
        if (getResponse.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(getResponse.body);
          for (final item in data.entries) {
            users.add(
              User(
                id: item.key,
                phoneNumber: item.value["phoneNumber"],
                password: item.value["password"],
              ),
            );
          }
        } else {
          setState(() {
            _errorMessage = "Connection failed ${getResponse.statusCode}";
          });
          return;
        }

        //Check whether this phone number registered
        if (users
            .where((element) => element.phoneNumber == _phoneNumber)
            .isNotEmpty) {
          setState(() {
            _errorMessage = "User already registered";
          });
          return;
        }

        http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(
            {
              'phoneNumber': _phoneNumber,
              'password': _password,
            },
          ),
        );

        if (!context.mounted) {
          return;
        }
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "Sign Up",
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
                    const SizedBox(height: 40),
                    TextFormField(
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Password repeat",
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
                        _passwordRepeat = value!;
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _errorMessage,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: _signUp,
                      child: const Text("Sign up"),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
