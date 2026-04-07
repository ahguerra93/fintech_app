import 'package:fintech_app/common/app_formatters.dart';
import 'package:fintech_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Your Balance', style: Theme.of(context).textTheme.titleMedium),

        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              (previous is HomeLoading) != (current is HomeLoading) &&
              (previous is! HomeError && current is! HomeError),
          builder: (context, state) {
            return Skeletonizer(
              enableSwitchAnimation: true,
              enabled: state is HomeLoading,
              child: Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium,
                  children: [
                    TextSpan(text: '\$ ', style: Theme.of(context).textTheme.titleLarge),
                    TextSpan(
                      text: state is HomeLoading
                          ? '\$1,000.00'
                          : AppFormatters.amount((switch (state) {
                              HomeSuccess(:final data) => data.balance,
                              _ => 0,
                            })),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
