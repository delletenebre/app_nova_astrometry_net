import 'package:astrometry_net/api/api.dart';
import 'package:hive/hive.dart';

import 'calibration.dart';

part 'job.g.dart';

@HiveType(typeId: 2)
class Job extends HiveObject {
  static const UNKNOWN_STATUS = 'unknown'; 
  static const SUCCESS_STATUS = 'success'; 

  @HiveField(0)
  int id;

  @HiveField(1)
  String status;

  @HiveField(2)
  List<String> tags;

  @HiveField(3)
  List<String> machineTags;

  @HiveField(4)
  List<String> objectsInField;
  
  @HiveField(5)
  String originalFilename;

  @HiveField(6)
  Calibration? calibration;

  Job(this.id, {
    this.status = UNKNOWN_STATUS,
    this.tags = const [],
    this.machineTags = const [],
    this.objectsInField = const [],
    this.originalFilename = '',
    this.calibration,
  });

  bool get success => status == 'success';
  bool get failed => status == 'failure';
  bool get finished => success || failed;

  Future<void> updateStatus() async {
    final response = await Api.getJobInfo(id);
    if (response.success) {
      final data = response.data;

      status = data['status'];
      tags = List<String>.from(data['tags']);
      machineTags = List<String>.from(data['machine_tags']);
      objectsInField = List<String>.from(data['objects_in_field']);
      originalFilename = data['original_filename'];
      calibration = Calibration.fromJson(data['calibration'] ?? {});

      await save();
    }
  }
}