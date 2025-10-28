import 'package:flutter/material.dart';

class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(title: Text('Live Tracking')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.map, size: 80, color: primary),
            SizedBox(height: 12),
            Text('Live vehicle tracking will appear here', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Integrate Google Maps / Mapbox for real tracking', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/live'),
              child: Text('(Placeholder) Refresh'),
            )
          ]),
        ),
      ),
    );
  }
}
