import 'package:get_it/get_it.dart';
import 'package:fintech_app/features/cards/di/cards_di.dart';
import 'package:fintech_app/features/home/di/home_di.dart';
import 'package:fintech_app/features/stats/di/stats_di.dart';
import 'package:fintech_app/features/profile/di/profile_di.dart';
import 'package:fintech_app/features/auth/di/auth_di.dart';
import 'package:fintech_app/features/transfers/di/transfer_di.dart';

final GetIt getIt = GetIt.instance;

void initDependencies() {
  initCardsDependencies(getIt);
  initHomeDependencies(getIt);
  initStatsDependencies(getIt);
  initProfileDependencies(getIt);
  initAuthDependencies(getIt);
  initTransferDependencies(getIt);
}
