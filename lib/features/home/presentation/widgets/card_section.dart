import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_assets.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/widgets/cards/card_widget.dart';
import 'package:fintech_app/common/widgets/section_title.dart';
import 'package:flutter/material.dart';

class CardSection extends StatelessWidget {
  const CardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppDimens.spacingMd,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd),
          child: SectionTitle(title: 'Cards', subtitle: 'View All', onTap: () {}),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? AppDimens.spacingMd : AppDimens.spacingSm,
                  right: index == 1 ? AppDimens.spacingMd : AppDimens.spacingSm,
                ),
                child: CardWidget(balance: 222852.00, cardNumber: '1234567812345678', debit: index == 0),
              );
            },
            itemCount: 2,
          ),
        ),
      ],
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    required this.balance,
    required this.cardNumber,
    required this.debit,
    this.hidden = false,
    super.key,
  });
  final bool debit;
  final String cardNumber;
  final double balance;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<AppColorTheme>()!;
    final onSurface = Theme.of(context).colorScheme.onPrimary;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.radiusXl),
            color: debit ? themeExt.softAccent : themeExt.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  debit ? 'Debit Card' : 'Credit Card',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: onSurface, fontWeight: FontWeight.bold),
                ),
                CardBody(balance: balance, cardNumber: cardNumber, hidden: hidden),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Opacity(
            opacity: 0.25,
            child: ClipRect(
              child: Align(
                alignment: Alignment.bottomLeft,
                widthFactor: 0.7,
                heightFactor: 0.6,
                child: Image.asset(AppAssets.logoOutlined, width: 160, height: 160, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
