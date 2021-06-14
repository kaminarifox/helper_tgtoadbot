import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rxdart/rxdart.dart';
import '../types/enums.dart';
import '../types/scheduler_job.dart';
import 'mongo.service.dart';

class SchedulerService {
  late final MongoService _mongo;
  late final DbCollection _collection;
  late final BehaviorSubject<SchedulerJob> jobStream;

  SchedulerService() {
    _mongo = GetIt.I.get<MongoService>();
    _collection = _mongo.db.collection('schedulerJobs');
    jobStream = BehaviorSubject<SchedulerJob>();

    _mongo.db.open().then((value) => _setup());
  }

  void _setup() {
    _loadJobs();
  }

  void _loadJobs() {
    final now = DateTime.now().millisecondsSinceEpoch;
    _collection.find(where.gt('timestamp', now)).forEach((element) {
      schedule(SchedulerJob.fromJson(element));
    });
  }

  void schedule(SchedulerJob job) async {
    if (job.id == null) {
      var newJob = await _collection.insertOne(job.toJson());
      job.id = newJob.id;
    }

    final duration = Duration(
        milliseconds: job.runAt - DateTime.now().millisecondsSinceEpoch);

    await Future.delayed(duration).then((value) => {
          _collection
              .findOne(where.id(job.id).eq('status', JobStatus.active.index))
              .then((value) => {
                    if (value.isNotEmpty)
                      {jobStream.add(SchedulerJob.fromJson(value))}
                  })
        });
  }
}
