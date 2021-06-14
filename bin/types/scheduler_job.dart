import 'package:mongo_dart/mongo_dart.dart';

import 'enums.dart';

class SchedulerJob {
  ObjectId? id;
  HelperCommand command;
  int runAt;
  JobStatus status;
  Map<String, dynamic>? data;

  SchedulerJob(this.command, this.runAt, this.status, this.data);

  SchedulerJob.fromJson(Map json)
      : id = json['_id'] is ObjectId ? json['_id'] : json['id'],
        command = HelperCommand.values[json['command']],
        runAt = json['runAt'],
        status = json['status'] != null
            ? JobStatus.values[json['status']]
            : JobStatus.active,
        data = json['data'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'command': command.index,
      'runAt': runAt,
      'status': status.index,
      'data': data,
    };
  }
}
