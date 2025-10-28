import 'package:flutter/material.dart';


class RouteCard extends StatelessWidget {
final String title;
final String subtitle;
final VoidCallback onBook;


const RouteCard({required this.title, required this.subtitle, required this.onBook});


@override
Widget build(BuildContext context) {
return Card(
margin: EdgeInsets.symmetric(vertical: 8),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
elevation: 2,
child: ListTile(
leading: CircleAvatar(child: Icon(Icons.directions_bus)),
title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
subtitle: Text(subtitle),
trailing: ElevatedButton(onPressed: onBook, child: Text('Book')),
),
);
}
}