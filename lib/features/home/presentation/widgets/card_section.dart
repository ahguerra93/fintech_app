import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_assets.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/widgets/cards/card_widget.dart';
import 'package:fintech_app/common/widgets/section_title.dart';
import 'package:fintech_app/common/widgets/empty_state.dart';
import 'package:fintech_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardSection extends StatelessWidget {
  const CardSection({super.key});

  static final List<CardModel> _dummyCards = List.filled(
    3,
    CardModel(cardNumber: '**** **** **** 1234', balance: 5230.75, type: CardType.debit),
  );

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
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                (previous is HomeLoading) != (current is HomeLoading) &&
                (previous is! HomeError && current is! HomeError),
            builder: (context, state) {
              final loading = state is HomeLoading;
              final cards = switch (state) {
                HomeSuccess(:final data) => data.cards,
                _ => _dummyCards,
              };
              print('Rebuilding CardSection - loading: $loading, cards: ${cards.length}');
              return Skeletonizer(
                key: ValueKey('card_section_skeletonizer_${loading ? 'loading' : 'loaded'}'),
                enabled: loading,
                enableSwitchAnimation: true,
                child: cards.isEmpty
                    ? EmptyStateWidget(
                        message: 'No cards added yet',
                        // icon: Icon(Icons.credit_card, size: 48, color: Theme.of(context).hintColor),
                        actionLabel: 'Add Card +',
                        onActionPressed: () {
                          // Navigate to add card
                        },
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          final card = cards[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? AppDimens.spacingMd : AppDimens.spacingSm,
                              right: index == cards.length - 1 ? AppDimens.spacingMd : AppDimens.spacingSm,
                            ),
                            child: CardWidget(
                              balance: card.balance,
                              cardNumber: card.cardNumber,
                              debit: card.type == CardType.debit,
                            ),
                          );
                        },
                      ),
              );
            },
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
          child: Material(
            color: Colors.transparent,

            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(AppDimens.radiusXl),
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
                      ).textTheme.titleLarge?.copyWith(color: debit ? null : onSurface, fontWeight: FontWeight.bold),
                    ),
                    CardBody(
                      balance: balance,
                      cardNumber: cardNumber,
                      foregroundColor: debit ? themeExt.textPrimary : onSurface,
                      hidden: hidden,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Opacity(
            opacity: 0.2,
            child: ClipRect(
              child: Align(
                alignment: Alignment.bottomLeft,
                widthFactor: 0.7,
                heightFactor: 0.6,
                child: Image.asset(AppAssets.logoOutlined, width: 100, height: 100, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
