import 'package:gym_app/data/model/event.dart';
import 'package:gym_app/data/provider.dart';

class Repository {

  const Repository();

  Future<List<Event>> getAllEvents() async {
    final rawEvents = await DatabaseProvider.getEvents();
    List<Event> filteredEvents = await DatabaseProvider.fromJsonToEvent(rawEvents);
    return filteredEvents;
  }

  Future<List<Event>> getAllEventsByName(String name) async {
    final rawEvents = await DatabaseProvider.getEventsByName(name);
    List<Event> filteredEvents = await DatabaseProvider.fromJsonToEvent(rawEvents);
    return filteredEvents;

  }

  Future<String> insertEvent(String name, String teacher, double lat, double long, String data, int maxCapacity) async {
    String result = await DatabaseProvider.addEvent(name, teacher, lat, long, data, maxCapacity);
    return result;
  }

  Future<String> checkLogIn(String username, String password) async {
    final client = await DatabaseProvider.getClient(username);
    if(client['password'] == password){
      return "success";
    }
    return "failure"; 
  }
}