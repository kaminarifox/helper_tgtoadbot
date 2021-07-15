import '../../common/types/enums.dart';
import 'scheduler_types.dart';

var schedulerPatterns = [
  SchedulerPattern(r'^покормить жабу$', HelperCommand.feedToad),
  SchedulerPattern(r'^запланировать кормежку (\d\d:\d\d)$', HelperCommand.scheduleToadFeeding)
];
