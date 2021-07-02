// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnnotationAdapter extends TypeAdapter<Annotation> {
  @override
  final int typeId = 0;

  @override
  Annotation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Annotation()
      ..radius = fields[0] as double?
      ..type = fields[1] as String?
      ..names = (fields[2] as List?)?.cast<String>()
      ..pixelx = fields[3] as double?
      ..pixely = fields[4] as double?
      ..vmag = fields[5] as double?;
  }

  @override
  void write(BinaryWriter writer, Annotation obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.radius)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.names)
      ..writeByte(3)
      ..write(obj.pixelx)
      ..writeByte(4)
      ..write(obj.pixely)
      ..writeByte(5)
      ..write(obj.vmag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnnotationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
