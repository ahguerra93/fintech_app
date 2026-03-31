import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/widgets/animated/stacked_cards.dart';
import 'package:fintech_app/common/widgets/cards/card_widget.dart';
import 'package:fintech_app/common/widgets/section_title.dart';
import 'package:fintech_app/common/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final themeExt = Theme.of(context).extension<AppColorTheme>()!;
    final TextStyle style = theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold);
    final cardSectionHeight = size.height / 3;
    const overlap = AppDimens.spacingXl + AppDimens.spacingSm; // 32 + 8 = 40 (closest to 70)
    return Scaffold(
      appBar: AppBar(
        title: Text('My cards', style: style),
        centerTitle: true,
        elevation: AppDimens.elevationNone,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl, vertical: AppDimens.spacingMd),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card stack area
              Container(
                height: cardSectionHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                ),
                child: StackedCards(
                  expandedHeight: cardSectionHeight - (overlap * 2),
                  overlap: overlap,
                  items: [
                    CardItem(
                      title: Text('Debit', style: TextStyle(color: theme.colorScheme.onPrimary)),
                      solidColor: theme.primaryColor,
                      body: CardBody(cardNumber: 'XXXX XXXX XXXX XXXX', balance: 3000, watermark: true),
                    ),
                    CardItem(
                      title: Text('Credit', style: TextStyle(color: themeExt.textPrimary)),
                      solidColor: themeExt.mutedSurfaceAccent,
                      body: CardBody(
                        cardNumber: 'XXXX XXXX XXXX XXXX',
                        balance: 3000,
                        foregroundColor: themeExt.textPrimary,
                        watermark: true,
                      ),
                    ),
                    CardItem(
                      title: Text('Platinum Credit', style: TextStyle(color: theme.colorScheme.onPrimary)),
                      solidColor: themeExt.primaryDark,
                      body: SizedBox(
                        height: double.maxFinite,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: CardBody(cardNumber: 'XXXX XXXX XXXX XXXX', balance: 3000, watermark: true),
                        ),
                      ),
                    ),
                  ],
                ), // Placeholder
              ),
              const SizedBox(height: AppDimens.spacingLg),
              // Actions row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _CardAction(label: 'Add funds', icon: Icons.add),
                  _CardAction(label: 'Freeze Card', icon: Icons.ac_unit),
                  _CardAction(label: 'Limits', icon: Icons.tune),
                ],
              ),
              const SizedBox(height: AppDimens.spacingXl),
              // Recent transactions section
              const SectionTitle(title: 'Recent transactions'),
              const SizedBox(height: AppDimens.spacingSm),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => const TransactionTile(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardAction extends StatelessWidget {
  const _CardAction({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: AppDimens.iconLg,
          backgroundColor: color.withValues(alpha: 0.1),
          child: Icon(icon, color: color, size: AppDimens.iconLg),
        ),
        const SizedBox(height: AppDimens.spacingSm),
        Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: color)),
      ],
    );
  }
}
