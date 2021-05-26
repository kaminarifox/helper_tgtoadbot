import 'package:get_it/get_it.dart';

import 'commands/inline/inline_command.dart';

class Commands {

  static void setup() {
    GetIt.I.registerSingleton<InlineCommand>(InlineCommand());
  }
}
