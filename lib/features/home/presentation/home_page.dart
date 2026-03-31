import 'package:fintech_app/features/home/presentation/widgets/balance_widget.dart';
import 'package:fintech_app/features/home/presentation/widgets/card_section.dart';
import 'package:fintech_app/features/home/presentation/widgets/home_actions.dart';
import 'package:fintech_app/features/home/presentation/widgets/home_appbar.dart';
import 'package:fintech_app/features/home/presentation/widgets/recent_payments_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(userName: 'Kimberly'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            spacing: 16.0,
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: BalanceWidget()),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: HomeActions()),
              CardSection(),
              RecentPaymentsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
