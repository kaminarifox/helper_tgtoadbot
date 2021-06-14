import 'package:get_it/get_it.dart';

import 'commands/inline/inline_command.dart';
import 'commands/scheduler/scheduler_commands.dart';

class Commands {

  static void setup() {
    GetIt.I.registerSingleton<InlineCommand>(InlineCommand());
    GetIt.I.registerSingleton<SchedulerCommand>(SchedulerCommand());
  }
}
