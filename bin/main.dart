import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'commands.dart';
import 'services.dart';

void main(List<String> arguments) {
  tz.initializeTimeZones();
  initializeDateFormatting('ua_UK');

  Services.setup();
  Commands.setup();
}
