import 'package:hive/hive.dart';
import 'package:gym_app/model/event.dart';

part 'client.g.dart';

@HiveType(typeId: 1)
class Client extends HiveObject {
  
  @HiveField(0)
  late String firstName;

  @HiveField(1)
  late String lastName;

  @HiveField(2)
  late String userName;

  @HiveField(3)
  late String password;

  @HiveField(4)
  late bool isTrainer;

  @HiveField(5)
  late List<Event> events;

  





}