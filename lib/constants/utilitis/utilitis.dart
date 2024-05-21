class Utilitis {
  static String getWeekDayString(int weekday) => switch (weekday) {
        1 => 'MO',
        2 => 'DI',
        3 => 'MI',
        4 => 'Do',
        5 => 'Fr',
        6 => 'Sa',
        7 => 'So',
        _ => throw Exception('There was a unkown Weekday maybe😅')
      };
}
