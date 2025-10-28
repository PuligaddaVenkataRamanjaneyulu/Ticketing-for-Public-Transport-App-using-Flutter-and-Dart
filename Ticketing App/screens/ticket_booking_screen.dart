import 'package:flutter/material.dart';

class TicketBookingScreen extends StatefulWidget {
  const TicketBookingScreen({Key? key}) : super(key: key);
  @override
  State<TicketBookingScreen> createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<TicketBookingScreen> {
  int quantity = 1;
  String? routeName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Selected Route';
  }

  void _confirm() {
    // Example: create ticket then go to QR screen
    final id = 'TKT-${DateTime.now().millisecondsSinceEpoch}';
    Navigator.pushNamed(context, '/qr', arguments: {'id': id, 'route': routeName, 'qty': quantity});
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(title: Text('Book Ticket')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.route, size: 36, color: primary),
              title: Text(routeName ?? ''),
              subtitle: Text('One-way, Non-refundable'),
            ),
          ),
          SizedBox(height: 12),
          Row(children: [
            Text('Quantity:', style: TextStyle(fontSize: 16)),
            Spacer(),
            IconButton(onPressed: () => setState(() => quantity = (quantity - 1).clamp(1, 10)), icon: Icon(Icons.remove_circle_outline)),
            Text(quantity.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            IconButton(onPressed: () => setState(() => quantity = (quantity + 1).clamp(1, 10)), icon: Icon(Icons.add_circle_outline)),
          ]),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _confirm,
            icon: Icon(Icons.payment),
            label: SizedBox(width: double.infinity, child: Center(child: Text('Pay & Get Ticket'))),
            style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 48)),
          )
        ]),
      ),
    );
  }
}
