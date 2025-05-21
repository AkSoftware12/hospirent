import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Drawer(
      backgroundColor: AppColors.primary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
            },
          ),
          ListTile(
            title: Text(authProvider.user == null ? 'Login' : 'Logout'),
            onTap: () {
              if (authProvider.user == null) {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              } else {
                authProvider.logout();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
