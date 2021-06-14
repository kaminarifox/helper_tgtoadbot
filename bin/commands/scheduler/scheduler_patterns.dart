import '../../types/enums.dart';

var schedulerPatterns = [
  {
    'pattern': RegExp(r'^запланировать кормежку (\d\d:\d\d)$',
        unicode: true, caseSensitive: false),
    'command': HelperCommand.scheduleToadFeeding,
  },
];
