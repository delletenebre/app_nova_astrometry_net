// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calibration.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalibrationAdapter extends TypeAdapter<Calibration> {
  @override
  final int typeId = 1;

  @override
  Calibration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Calibration(
      parity: fields[0] as double?,
      orientation: fields[1] as double?,
      pixscale: fields[2] as double?,
      radius: fields[3] as double?,
      ra: fields[4] as double?,
      dec: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Calibration obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.parity)
      ..writeByte(1)
      ..write(obj.orientation)
      ..writeByte(2)
      ..write(obj.pixscale)
      ..writeByte(3)
      ..write(obj.radius)
      ..writeByte(4)
      ..write(obj.ra)
      ..writeByte(5)
      ..write(obj.dec);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalibrationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
