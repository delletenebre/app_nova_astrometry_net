import 'package:hive/hive.dart';

part 'calibration.g.dart';

@HiveType(typeId: 1)
class Calibration extends HiveObject {

  @HiveField(0)
  double? parity;

  @HiveField(1)
  double? orientation;

  @HiveField(2)
  double? pixscale;

  @HiveField(3)
  double? radius;

  @HiveField(4)
  double? ra;

  @HiveField(5)
  double? dec;

  Calibration({
    this.parity,
    this.orientation,
    this.pixscale,
    this.radius,
    this.ra,
    this.dec,
  });

  factory Calibration.fromJson(Map<String, dynamic> json) {
    return Calibration(
      parity: json['parity'],
      orientation: json['orientation'],
      pixscale: json['pixscale'],
      radius: json['radius'],
      ra: json['ra'],
      dec: json['dec'],
    );
  }
}