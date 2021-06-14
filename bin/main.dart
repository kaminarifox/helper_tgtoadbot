import 'package:get_it/get_it.dart';

import 'commands.dart';
import 'services.dart';
import 'services/scheduler.service.dart';

void main(List<String> arguments) {
  Services.setup();
  Commands.setup();
}
