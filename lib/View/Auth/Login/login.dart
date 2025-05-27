import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospirent/main.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool success = authProvider.login(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );
    if (success) {
      final redirectRoute = authProvider.redirectRoute ?? '/';
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 0,)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}