import 'package:astrometry_net/api/api.dart';
import 'package:hive/hive.dart';

part 'submission.g.dart';

@HiveType(typeId: 3)
class Submission extends HiveObject {

  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime? processingStarted;

  @HiveField(2)
  DateTime? processingFinished;

  @HiveField(3)
  List<int> jobs;

  Submission(this.id, {
    this.processingStarted,
    this.processingFinished,
    this.jobs = const [],
    updatedAt,
  });

  Future<void> updateStatus() async {
    final response = await Api.getSubmissionStatus(id);
    if (response.success) {
      final data = response.data;

      processingStarted = DateTime.tryParse(data['processing_started']);
      processingFinished = DateTime.tryParse(data['processing_finished']);
      
      final jobsNull = List<int?>.from(data['jobs']);

      jobs = List<int>.from(jobsNull.where((job) => job != null)).map((jobId) {
        return jobId;
      }).toList();

      save();
    }
  }
}