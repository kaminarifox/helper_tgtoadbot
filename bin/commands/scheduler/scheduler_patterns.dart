import '../../common/types/enums.dart';
import 'scheduler_types.dart';

var schedulerPatterns = [
  SchedulerPattern(r'^покормить жабу$', HelperCommand.feedToad),
  SchedulerPattern(r'^запланировать кормежку (\d\d:\d\d)$', HelperCommand.scheduleToadFeeding)
  SchedulerPattern(r'^подписаться на жабу$', HelperCommand.subscribeToad),
  SchedulerPattern(r'^тебе жаба, милая беседа', HelperCommand.toadSent),
  SchedulerPattern(r'^отписаться от жабы$', HelperCommand.unsubscribeToad),
  SchedulerPattern(r'^собрать банду$', HelperCommand.unsubscribeToad),
];
