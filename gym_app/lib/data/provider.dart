import 'package:gym_app/data/model/client.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'model/event.dart';

class DatabaseProvider {
  static var db, eventCollection, clientCollection;

  static connect() async {
    db = await Db.create('mongodb+srv://moveHub:move2021@cluster0.qrv2b.mongodb.net/movehDB?retryWrites=true&w=majority');
    await db.open();
    eventCollection = db.collection('events');
    clientCollection = db.collection('clients');
  }

  static Future<Map<String, dynamic>> getClient(String username) async {
    try{
      final client = await clientCollection.findOne({'userName': username});
      return client;
    }catch(e){
      return Future.value(null);
    }
  }

  static Future<List<Map<String, dynamic>>> getEvents() async {
    try{
      final events = await eventCollection.find().toList();
      return events;
    } catch(e) {
      return Future.value(null);
    }
  }

  static Future<Map<String, dynamic>> getEvent(String name) async {
    try {
      final event = await eventCollection.findOne({'name': name});
      return event;
    }catch(e){
      return Future.value(null);
    }
  }
  

  static Future<String> addEvent(String name, String teacher, double lat, double long, String data) async {
    try{
      await eventCollection.insertOne({'name': name, 'teacher': teacher, 'lat': lat, 'long': long, 'data': data, 'maxCapacity': 100});
      return "Success";
    }catch(e){
      return "Failed";
    }
  }

  static Future<String> addUser(String firstName, String lastName, String userName, String password, bool isTrainer) async {
    try{
      await clientCollection.insertOne({'firstName': firstName, 'lastName': lastName, 'userName': userName, 'password': password, 'isTrainer': isTrainer});
      return 'Success';
    }catch(e){
      return 'Failed';
    }
  }

  static Future<void> registerClientInEvent(String userName, String eventName) async {
    try{
      await clientCollection.update({'userName': userName}, {'\$addToSet':{'events': eventName}});
    }catch(e){
      return Future.value(null);
    }
  }

  static Future<void> unregisterClientFromEvent(String userName, String eventName) async {
    try{
      await clientCollection.update({'userName': userName},{'\$pull': {'events': eventName}});
    }catch(e){
      return Future.value(null);
    }
  }

  static Future<List<Event>> fromJsonToEvents(List<Map<String, dynamic>> results) async {
    final eventList = <Event>[];
    for(var i = 0; i < results.length; i++){
      eventList.add(
        Event()
          ..name = results[i]['name'] 
          ..teacher = results[i]['teacher'] 
          ..lat = results[i]['lat']
          ..long = results[i]['long'] 
          ..data = results[i]['data'] 
          ..maxCapacity = results[i]['maxCapacity']
      );
    }
    return eventList;
  }

  static Future<Event> fromJsonToEvent(Map<String, dynamic> rawEvent) async {
    final event = Event() 
                  ..name = rawEvent['name'] 
                  ..teacher = rawEvent['teacher'] 
                  ..lat = rawEvent['lat']
                  ..long = rawEvent['long'] 
                  ..data = rawEvent['data'] 
                  ..maxCapacity = rawEvent['maxCapacity'];
    return event; 
  }

 static Future<Client> fromJsonToClient(Map<String, dynamic> rawClient) async {
   final client = Client()
                  ..firstName = rawClient['firstName']
                  ..lastName = rawClient['lastName']
                  ..userName = rawClient['userName']
                  ..password = rawClient['password']
                  ..isTrainer = rawClient['isTrainer']
                  ..events = [];
  return client;
 }

 
 
}



/*

static Future<List<Map<String, dynamic>>> getEventsByName(String name) async {
    try{
      final events = await eventCollection.find({'name': name}).toList();
      return events;
    } catch(e) {
      print(e);
      return Future.value(null);
    }
  }

*/