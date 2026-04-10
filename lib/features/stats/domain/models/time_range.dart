enum TimeRange {
  week('This Week'),
  month('This Month'),
  year('This Year');

  const TimeRange(this.displayName);

  final String displayName;
}
