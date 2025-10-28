import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: Icon(Icons.palette, color: Colors.blueAccent),
            title: Text('Theme'),
            subtitle: Text('Light / Dark mode'),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.notifications, color: Colors.orange),
            title: Text('Notifications'),
            subtitle: Text('Manage alerts and sounds'),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.lock, color: Colors.redAccent),
            title: Text('Privacy'),
            subtitle: Text('Change password, 2FA, etc.'),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline, color: Colors.green),
            title: Text('About'),
            subtitle: Text('App version 1.0.0'),
          ),
        ],
      ),
    );
  }
}
