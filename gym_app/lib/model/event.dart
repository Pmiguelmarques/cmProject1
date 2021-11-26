import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 0)
class Event extends HiveObject {
  @HiveField(0)
  late final String name;
  
  @HiveField(1)
  late String teacher;
  
  @HiveField(2)
  late double lat;
  
  @HiveField(3)
  late double long;
  
  @HiveField(4)
  late String data;
  
  @HiveField(5)
  late int maxCapacity;



}