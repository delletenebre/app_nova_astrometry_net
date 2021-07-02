import 'package:hive/hive.dart';

part 'annotation.g.dart';

@HiveType(typeId: 0)
class Annotation extends HiveObject {

  @HiveField(0)
  double? radius;

  @HiveField(1)
  String? type;

  @HiveField(2)
  List<String>? names;

  @HiveField(3)
  double? pixelx;

  @HiveField(4)
  double? pixely;

  @HiveField(5)
  double? vmag;

}