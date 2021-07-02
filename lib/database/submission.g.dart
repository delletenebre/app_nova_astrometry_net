// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubmissionAdapter extends TypeAdapter<Submission> {
  @override
  final int typeId = 3;

  @override
  Submission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Submission(
      fields[0] as int,
      processingStarted: fields[1] as DateTime?,
      processingFinished: fields[2] as DateTime?,
      jobs: (fields[3] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Submission obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.processingStarted)
      ..writeByte(2)
      ..write(obj.processingFinished)
      ..writeByte(3)
      ..write(obj.jobs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubmissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
