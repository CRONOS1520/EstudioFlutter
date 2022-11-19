import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static String formatTimeOfDay(DateTime day, TimeOfDay hour) {
    final dt = DateTime(day.year, day.month, day.day, hour.hour, hour.minute);
    return DateFormat('dd/MM/yyyy kk:mm:ss').format(dt);
  }
}
