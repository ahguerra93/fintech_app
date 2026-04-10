import 'package:fintech_app/app_colors.dart';
import 'package:fintech_app/common/app_dimens.dart';
import 'package:fintech_app/common/widgets/animated/stacked_cards.dart';
import 'package:fintech_app/common/widgets/cards/card_widget.dart';
import 'package:fintech_app/common/widgets/error_screen.dart';
import 'package:fintech_app/common/widgets/section_title.dart';
import 'package:fintech_app/common/widgets/transaction_tile.dart';
import 'package:fintech_app/common/widgets/empty_state.dart';
import 'package:fintech_app/config/routing/router.dart';
import 'package:fintech_app/features/cards/domain/models/card_model.dart';
import 'package:fintech_app/features/cards/domain/models/recent_transaction_model.dart';
import 'package:fintech_app/features/cards/presentation/bloc/cards_bloc/cards_bloc.dart';
import 'package:fintech_app/features/cards/presentation/bloc/recent_transactions_bloc/recent_transactions_bloc.dart';
import 'package:fintech_app/features/dev_tools/presentation/cubit/devtools_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CardsBloc(context.read<DevToolsCubit>())..add(const FetchCards())),
        BlocProvider(
          create: (context) =>
              RecentTransactionsBloc(context.read<DevToolsCubit>())..add(const FetchRecentTransactions()),
        ),
      ],
      child: const _CardsPageBody(),
    );
  }
}

class _CardsPageBody extends StatefulWidget {
  const _CardsPageBody();

  @override
  State<_CardsPageBody> createState() => _CardsPageBodyState();
}

class _CardsPageBodyState extends State<_CardsPageBody> {
  GoRouterDelegate? _delegate;
  late String _currentLocation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final delegate = GoRouter.of(context).routerDelegate;
    if (identical(_delegate, delegate)) {
      return;
    }

    _delegate?.removeListener(_routeChanged);
    _delegate = delegate;
    _currentLocation = delegate.currentConfiguration.uri.path;
    delegate.addListener(_routeChanged);
  }

  void _routeChanged() {
    final delegate = _delegate;
    if (!mounted || delegate == null) {
      return;
    }

    final newLocation = delegate.currentConfiguration.uri.path;
    if (newLocation == _currentLocation) {
      return;
    }

    if (newLocation == AppRoutes.cards) {
      context.read<CardsBloc>().add(const FetchCards());
      context.read<RecentTransactionsBloc>().add(const FetchRecentTransactions());
    }

    _currentLocation = newLocation;
  }

  @override
  void dispose() {
    _delegate?.removeListener(_routeChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final themeExt = Theme.of(context).extension<AppColorTheme>()!;

    final TextStyle style = theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold);
    final cardSectionHeight = size.height / 3.5;
    const overlap = AppDimens.spacingXl + AppDimens.spacingSm;

    return Scaffold(
      appBar: AppBar(
        title: Text('My cards', style: style),
        centerTitle: true,
        elevation: AppDimens.elevationNone,
      ),
      body: BlocBuilder<CardsBloc, CardsState>(
        buildWhen: (previous, current) => (previous is CardsError) != (current is CardsError),
        builder: (context, cardsState) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: switch (cardsState) {
              CardsError(:final message) => ErrorScreen(
                key: const ValueKey('cards_error'),
                message: message,
                onRetry: () {
                  context.read<CardsBloc>().add(const FetchCards());
                  context.read<RecentTransactionsBloc>().add(const FetchRecentTransactions());
                },
              ),
              _ => Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl, vertical: AppDimens.spacingMd),
                child: SingleChildScrollView(
                  key: const ValueKey('cards_content'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _CardsSection(
                        cardSectionHeight: cardSectionHeight,
                        overlap: overlap,
                        theme: theme,
                        themeExt: themeExt,
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
                      const _RecentTransactionsSection(),
                    ],
                  ),
                ),
              ),
            },
          );
        },
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
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppDimens.radiusFull),
          child: CircleAvatar(
            radius: AppDimens.iconLg,
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color, size: AppDimens.iconLg),
          ),
        ),
        const SizedBox(height: AppDimens.spacingSm),
        Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: color)),
      ],
    );
  }
}

class _CardsSection extends StatelessWidget {
  const _CardsSection({
    required this.cardSectionHeight,
    required this.overlap,
    required this.theme,
    required this.themeExt,
  });

  final double cardSectionHeight;
  final double overlap;
  final ThemeData theme;
  final AppColorTheme themeExt;

  static final List<CardModel> _dummyCards = List.filled(
    1,
    CardModel(cardNumber: '**** **** **** 1234', balance: 5230.75, type: CardType.debit),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardSectionHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      ),
      child: BlocBuilder<CardsBloc, CardsState>(
        buildWhen: (previous, current) =>
            (previous is CardsLoading) != (current is CardsLoading) &&
            (previous is! CardsError && current is! CardsError),
        builder: (context, state) {
          final loading = state is CardsLoading;
          final cards = loading ? _dummyCards : (state as CardsSuccess).cards;

          return Skeletonizer(
            key: Key('cards_section'),
            enabled: loading,
            enableSwitchAnimation: true,
            // ignoreContainers: true,
            ignorePointers: true,
            justifyMultiLineText: true,
            containersColor: theme.colorScheme.secondary,

            child: RepaintBoundary(
              child: cards.isEmpty
                  ? EmptyStateWidget(
                      message: 'No cards added yet',
                      icon: Icon(Icons.credit_card, size: 48, color: theme.hintColor),
                      actionLabel: 'Add Card +',
                      onActionPressed: () {
                        // Navigate to add card
                      },
                    )
                  : StackedCards(
                      expandedHeight: cardSectionHeight - (overlap * 2),
                      overlap: overlap,
                      items: cards
                          .map(
                            (card) => CardItem(
                              title: Text(
                                card.type.displayName,
                                style: TextStyle(
                                  color: switch (card.type) {
                                    CardType.debit => theme.colorScheme.onPrimary,
                                    CardType.credit => themeExt.textPrimary,
                                    CardType.platinum => theme.colorScheme.onPrimary,
                                  },
                                ),
                              ),
                              solidColor: switch (card.type) {
                                CardType.debit => theme.colorScheme.primary,
                                CardType.credit => theme.colorScheme.secondaryContainer,
                                CardType.platinum => themeExt.primaryDark,
                              },
                              body: CardBody(
                                foregroundColor: switch (card.type) {
                                  CardType.debit => theme.colorScheme.onPrimary,
                                  CardType.credit => themeExt.textPrimary,
                                  CardType.platinum => theme.colorScheme.onPrimary,
                                },
                                cardNumber: card.cardNumber,
                                balance: card.balance,
                                watermark: true,
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _RecentTransactionsSection extends StatelessWidget {
  const _RecentTransactionsSection();

  static final List<RecentTransactionModel> _dummyTransactions = List.filled(
    3,
    RecentTransactionModel(title: 'Loading', amount: 100.0, date: DateTime.now(), category: 'Loading', id: ''),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentTransactionsBloc, RecentTransactionsState>(
      buildWhen: (previous, current) =>
          (previous is RecentTransactionsLoading) != (current is RecentTransactionsLoading) &&
          (previous is! RecentTransactionsError && current is! RecentTransactionsError),
      builder: (context, state) {
        final loading = state is RecentTransactionsLoading;
        final transactions = switch (state) {
          RecentTransactionsLoading() => _dummyTransactions,
          RecentTransactionsSuccess s => s.transactions,
          _ => const <RecentTransactionModel>[],
        };
        return Skeletonizer(
          key: Key('transactions_cards'),
          enabled: loading,
          enableSwitchAnimation: true,
          child: RepaintBoundary(
            child: transactions.isEmpty
                ? EmptyStateWidget(key: const ValueKey('empty_transactions'), message: 'No recent transactions')
                : Align(
                    key: const ValueKey('transactions_list'),
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      itemCount: transactions.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final tx = transactions[index];
                        return TransactionTile(
                          title: tx.title,
                          amount: tx.amount,
                          date: tx.date,
                          category: tx.category,
                        );
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }
}
