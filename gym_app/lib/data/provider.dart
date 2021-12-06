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
      print(e);
      return Future.value(null);
    }
  }

  static Future<List<Map<String, dynamic>>> getEventsByName(String name) async {
    try{
      final events = await eventCollection.find({'name': name}).toList();
      return events;
    } catch(e) {
      print(e);
      return Future.value(null);
    }
  }

  static Future<String> addEvent(String name, String teacher, double lat, double long, String data, int maxCapacity) async {
    try{
      await eventCollection.insertOne({'name': name, 'teacher': teacher, 'lat': lat, 'long': long, 'data': data, 'maxCapacity': maxCapacity});
      return "Success";
    }catch(e){
      return "Failed";
    }
  }

  static Future<List<Event>> fromJsonToEvent(List<Map<String, dynamic>> results) async {
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
 
 
}