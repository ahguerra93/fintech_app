import 'package:fintech_app/common/widgets/section_title.dart';
import 'package:flutter/material.dart';

class RecentPaymentsSection extends StatelessWidget {
  const RecentPaymentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'Recent Payments', subtitle: 'View All', onTap: () {}),
          SizedBox(height: 16.0),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => PaymentTile(),
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}

class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key});

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
