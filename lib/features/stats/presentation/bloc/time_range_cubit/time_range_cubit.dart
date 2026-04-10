import 'package:fintech_app/features/stats/domain/models/time_range.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeRangeCubit extends Cubit<TimeRange> {
  TimeRangeCubit() : super(TimeRange.week);

  void setTimeRange(TimeRange range) => emit(range);
}
