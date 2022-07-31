import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color rateToColor(num rate) {
  if(rate < 50) {
    return Colors.red;
  } else if(rate < 70) {
    return Colors.orange;
  } else if(rate < 80) {
    return Colors.orangeAccent;
  } else if(rate < 90) {
    return Colors.greenAccent;
  } else {
    return Colors.green;
  }
}

final DateFormat dateFormatter = DateFormat('MMM dd, yyyy');

String durationToString(int minutes) {
  var d = Duration(minutes:minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}