import 'package:get_it/get_it.dart';

import 'commands/inline/inline.commands.dart';
import 'commands/internal/internal.commands.dart';
import 'commands/scheduler/scheduler.commands.dart';

class Commands {

  static void setup() {
    GetIt.I.registerSingleton<InternalCommands>(InternalCommands());
    GetIt.I.registerSingleton<InlineCommands>(InlineCommands());
    GetIt.I.registerSingleton<SchedulerCommands>(SchedulerCommands());
  }
}
