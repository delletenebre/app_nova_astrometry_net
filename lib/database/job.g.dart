// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobAdapter extends TypeAdapter<Job> {
  @override
  final int typeId = 2;

  @override
  Job read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Job(
      fields[0] as int,
      status: fields[1] as String,
      tags: (fields[2] as List).cast<String>(),
      machineTags: (fields[3] as List).cast<String>(),
      objectsInField: (fields[4] as List).cast<String>(),
      originalFilename: fields[5] as String,
      calibration: fields[6] as Calibration?,
    )..createdAt = fields[7] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Job obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.tags)
      ..writeByte(3)
      ..write(obj.machineTags)
      ..writeByte(4)
      ..write(obj.objectsInField)
      ..writeByte(5)
      ..write(obj.originalFilename)
      ..writeByte(6)
      ..write(obj.calibration)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
