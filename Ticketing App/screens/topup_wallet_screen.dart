import 'package:flutter/material.dart';

class TopUpWalletScreen extends StatefulWidget {
  const TopUpWalletScreen({Key? key}) : super(key: key);
  @override
  State<TopUpWalletScreen> createState() => _TopUpWalletScreenState();
}

class _TopUpWalletScreenState extends State<TopUpWalletScreen> {
  double amount = 100.0;

  void _pay() {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text('Success'),
      content: Text('₹${amount.toStringAsFixed(2)} added to wallet.'),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top-up Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Card(child: ListTile(title: Text('Current balance'), subtitle: Text('₹ 250.00'), trailing: Icon(Icons.account_balance_wallet))),
          SizedBox(height: 12),
          Text('Choose amount', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [50, 100, 200, 500, 1000].map((v) => ChoiceChip(
              label: Text('₹$v'),
              selected: amount == v,
              onSelected: (_) => setState(() => amount = v.toDouble()),
            )).toList(),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(onPressed: _pay, icon: Icon(Icons.payment), label: Text('Pay ₹${amount.toStringAsFixed(0)}')),
        ]),
      ),
    );
  }
}
