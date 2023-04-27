String msConverter(double ms) {
  int minutes;
  int hours;

  const msInHour = 3.6e+6;
  hours = (ms / msInHour).floor();

  final msLeftForMinutes = ms - (msInHour * hours);
  const msInMinute = 60000;
  minutes = (msLeftForMinutes / msInMinute).round();

  return "$hours hrs $minutes mins";
}
