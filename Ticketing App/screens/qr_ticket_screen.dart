import 'package:flutter/material.dart';

class QRTicketScreen extends StatelessWidget {
  const QRTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get arguments safely
    final dynamic args = ModalRoute.of(context)?.settings.arguments;
    String ticketId = 'TICKET-0001';
    String routeName = 'Route A';
    int qty = 1;

    if (args is Map) {
      if (args['id'] != null) ticketId = args['id'].toString();
      if (args['route'] != null) routeName = args['route'].toString();
      if (args['qty'] != null) qty = int.tryParse(args['qty'].toString()) ?? 1;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('QR Ticket')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text(routeName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Quantity: $qty', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 16),

                  // Placeholder QR box
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text(
                        'QR Code\nPlaceholder',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  Text('Ticket ID: $ticketId', style: TextStyle(color: Colors.grey[700])),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
              icon: const Icon(Icons.home),
              label: const Text('Back to Home'),
            ),
          ]),
        ),
      ),
    );
  }
}
