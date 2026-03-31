import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(Icons.attach_money)),
      title: Text('John Doe'),
      subtitle: Text('Today 12:40'),
      trailing: Text('\$50.00'),
    );
  }
}
